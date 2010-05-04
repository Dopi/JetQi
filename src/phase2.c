/*
 * (C) Copyright 2008 Openmoko, Inc.
 * Author: Andy Green <andy@openmoko.org>
 *
 * Parse the U-Boot header and Boot Linux
 * based on various code from U-Boot
 *
 * Modified for Jet, 2010, dopi711@googlemail.com
 * based on smartQi by Roberto Gordo Saez <roberto.gordo@gmail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */

#include <qi.h>
#define __ARM__
#include <image.h>
#include <setup.h>
#include <ext2.h>

#include "cpu/s3c6410/jet.h"
#include "cpu/s3c6410/boot_loader_interface.h"

#define DEBUG(s) LCD_print_newline(s)	// initially it was puts(s)

typedef void (*the_kernel_fn)(int zero, int arch, unsigned int params);

unsigned long partition_offset_blocks = 0;
unsigned long partition_length_blocks = 0;

struct kernel_source const * this_kernel = 0;

static const int INITRD_OFFSET = (8 * 1024 * 1024);


int raise(int n)
{
	return 0;
}

static void indicate(enum ui_indication ui_indication)
{
	if (this_board->set_ui_indication)
		(this_board->set_ui_indication)(ui_indication);
}

static int read_file(const char * filepath, u8 * destination, int size)
{
	int len = size;
	int ret;

	switch (this_kernel->filesystem) {
	case FS_EXT2:
		if (!ext2fs_mount()) {
			DEBUG("Unable to mount ext2 filesystem\n");
			indicate(UI_IND_MOUNT_FAIL);
			return -2; /* death */
		}
		DEBUG("    EXT2 open: ");
		//DEBUG(filepath);
		len = ext2fs_open(filepath);
		if (len < 0) {
			DEBUG(" Open failed\n");
			return -1;
		}
		DEBUG(" OK\n");
		ret = ext2fs_read((char *)destination, size);
		if (ret < 0) {
			DEBUG(" Read failed\n");
			return -1;
		}
		break;

	case FS_FAT:
		/* FIXME */
	case FS_RAW:
		/* any filename-related request in raw filesystem will fail */
		if (filepath)
			return -1;
		DEBUG("     RAW open: +");
		printdec(partition_offset_blocks);
		DEBUG(" 512-byte blocks\n");
		if (this_kernel->block_read(destination, partition_offset_blocks, size >> 9) < 0) {
			DEBUG("Bad kernel header\n");
			return -1;
		}
		break;
	}

	return len;
}

static int do_block_init(void)
{
	static void * last_block_init = NULL;
	static int last_block_init_result = 0;
	int fresh = 0;

	/* if this device needs initializing, try to init it */
	if (!this_kernel->block_init)
		return 1; /* happy */

	/*
	 * cache result to limit attempts for same
	 * block device to one time
	 */
	if (this_kernel->block_init != last_block_init) {
		last_block_init = this_kernel->block_init;
		last_block_init_result = (this_kernel->block_init)();
		fresh = 1;
	}

	if (last_block_init_result) {
		DEBUG("block device init failed\n");
		if (fresh)
			indicate(UI_IND_MOUNT_FAIL);

		return 0; /* failed */
	}
	last_block_init = this_kernel->block_init;

	return 1; /* happy */
}

static int do_partitions(void *kernel_dram)
{
	unsigned char *p = kernel_dram;

	/* if there's a partition table implied, parse it, otherwise
	 * just use a fixed offset
	 */
	if (!this_kernel->partition_index) {
		partition_offset_blocks =
			  this_kernel->offset_blocks512_if_no_partition;
		return 1;
	}

	if ((int)this_kernel->block_read(kernel_dram, 0, 4) < 0) {
		DEBUG("Bad partition read\n");
		indicate(UI_IND_MOUNT_FAIL);
		return 0;
	}

	if ((p[0x1fe] != 0x55) || (p[0x1ff] != 0xaa)) {
		DEBUG("partition signature missing\n");
		indicate(UI_IND_MOUNT_FAIL);
		return 0;
	}

	p += 0x1be + 8 + (0x10 * (this_kernel->partition_index - 1));

	partition_offset_blocks = (((u32)p[3]) << 24) |
				  (((u32)p[2]) << 16) |
				  (((u32)p[1]) << 8) |
				  p[0];
	partition_length_blocks = (((u32)p[7]) << 24) |
				  (((u32)p[6]) << 16) |
				  (((u32)p[5]) << 8) |
				  p[4];

	DEBUG("    Partition: ");
	printdec(this_kernel->partition_index);
	DEBUG(" start +");
	printdec(partition_offset_blocks);
	DEBUG(" 512-byte blocks, size ");
	printdec(partition_length_blocks / 2048);
	DEBUG(" MiB\n");

	return 1;
}

static void do_params(unsigned initramfs_len,
	const char *commandline_rootfs_append)
{
	const struct board_variant * board_variant =
						  (this_board->get_board_variant)();
	const char *p;
	char * cmdline;
	struct tag *params = (struct tag *)this_board->linux_tag_placement;

	/* eat leading white space */
	for (p = this_board->commandline_board; *p == ' '; p++);

	/* first tag */
	params->hdr.tag = ATAG_CORE;
	params->hdr.size = tag_size(tag_core);
	params->u.core.flags = 0;
	params->u.core.pagesize = 0;
	params->u.core.rootdev = 0;
	params = tag_next(params);

	/* revision tag */
	params->hdr.tag = ATAG_REVISION;
	params->hdr.size = tag_size(tag_revision);
	params->u.revision.rev = board_variant->machine_revision;
	params = tag_next(params);

	/* memory tags */
	params->hdr.tag = ATAG_MEM;
	params->hdr.size = tag_size(tag_mem32);
	params->u.mem.start = this_board->linux_mem_start;
	params->u.mem.size = this_board->linux_mem_size;
	params = tag_next(params);

	if (this_kernel->initramfs_filepath) {
		/* INITRD2 tag */
		params->hdr.tag = ATAG_INITRD2;
		params->hdr.size = tag_size(tag_initrd);
		params->u.initrd.start = this_board->linux_mem_start +
								  INITRD_OFFSET;
		params->u.initrd.size = initramfs_len;
		params = tag_next(params);
	}

	/* kernel commandline */

	cmdline = params->u.cmdline.cmdline;

	/* start with the fixed device part of the commandline */

	cmdline += strlen(strcpy(cmdline, p));

	/* if the board itself needs a computed commandline, add it now */

	if (this_board->append_device_specific_cmdline)
		cmdline = (this_board->append_device_specific_cmdline)(cmdline);

	/* If he is giving an append commandline for this rootfs, apply that */

	if (this_kernel->commandline_append)
		cmdline += strlen(strcpy(cmdline,
					  this_kernel->commandline_append));
		if (commandline_rootfs_append[0])
			cmdline += strlen(strcpy(cmdline,
					  commandline_rootfs_append));

	/* deal with any trailing newlines that hitched a ride */

	while (*(cmdline - 1) == '\n')
		cmdline--;

	*cmdline = '\0';

	/*
	 * if he's still holding down the UI_ACTION_SKIPKERNEL key
	 * now we finished loading the kernel, take it to mean he wants
	 * to have the debugging options added to the commandline
	 */

	if (this_board->commandline_board_debug && this_board->get_ui_debug)
		if ((this_board->get_ui_debug)())
			cmdline += strlen(strcpy(cmdline, this_board->
						  commandline_board_debug));

	params->hdr.tag = ATAG_CMDLINE;
	params->hdr.size = (sizeof(struct tag_header) +
		strlen(params->u.cmdline.cmdline) + 1 + 4) >> 2;

	DEBUG("      Cmdline: ");
	DEBUG(params->u.cmdline.cmdline);
	DEBUG("\n");

	params = tag_next(params);

	/* needs to always be the last tag */
	params->hdr.tag = ATAG_NONE;
	params->hdr.size = 0;
}

static int do_crc(const image_header_t *hdr, const void *kernel_dram)
{
	unsigned long crc;

	/*
	 * It's good for now to know that our kernel is intact from
	 * the storage before we jump into it and maybe crash silently
	 * even though it costs us some time
	 */
	crc = crc32(0, kernel_dram + sizeof(image_header_t),
						   __be32_to_cpu(hdr->ih_size));
	if (crc == __be32_to_cpu(hdr->ih_dcrc))
		return 1;

	DEBUG("\nKernel CRC ERROR: read 0x");
	print32(crc);
	DEBUG(" vs hdr CRC 0x");
	print32(__be32_to_cpu(hdr->ih_dcrc));
	DEBUG("\n");

	return 0;
}

static the_kernel_fn load_uimage(void *kernel_dram)
{
	image_header_t	*hdr;
	u32 kernel_size;

	hdr = (image_header_t *)kernel_dram;

	if (__be32_to_cpu(hdr->ih_magic) != IH_MAGIC) {
		DEBUG("bad magic ");
		print32(hdr->ih_magic);
		DEBUG("\n");
		return NULL;
	}

	DEBUG("        Found: \"");
	//DEBUG((const char *)hdr->ih_name);
	DEBUG("\"\n         Size: ");
	printdec(__be32_to_cpu(hdr->ih_size) >> 10);
	DEBUG(" KiB\n");

	kernel_size = ((__be32_to_cpu(hdr->ih_size) +
			  sizeof(image_header_t) + 2048) & ~(2048 - 1));

	if (read_file(this_kernel->filepath, kernel_dram, kernel_size) < 0) {
		indicate(UI_IND_KERNEL_PULL_FAIL);
		return NULL;
	}

	indicate(UI_IND_KERNEL_PULL_OK);

	if (!do_crc(hdr, kernel_dram))
		return NULL;

	return (the_kernel_fn) (((char *)hdr) + sizeof(image_header_t));
}

static the_kernel_fn load_zimage(void *kernel_dram)
{
	u32 magic = *(u32 *) (kernel_dram + 0x24);
	u32 size = *(u32 *) (kernel_dram + 0x2c);
	int got;

	if (magic != 0x016f2818) {
		DEBUG("bad magic ");
		print32(magic);
		DEBUG("\n");
		return NULL;
	}

	DEBUG("         Size: ");
	printdec(size >> 10);
	DEBUG(" KiB\n");

	got = read_file(this_kernel->filepath, kernel_dram, size);
	if (got < 0) {
		indicate(UI_IND_KERNEL_PULL_FAIL);
		return NULL;
	}

	if (got != size) {
		DEBUG("short kernel\n");
		return NULL;
	}

	indicate(UI_IND_KERNEL_PULL_OK);

	return (the_kernel_fn) kernel_dram;
}

static void try_this_kernel(void)
{
	the_kernel_fn the_kernel;
	unsigned int initramfs_len = 0;
	static char commandline_rootfs_append[512] = "";
	int ret;
	void * kernel_dram = (void *)this_board->linux_mem_start + 0x8000;

	partition_offset_blocks = 0;
	partition_length_blocks = 0;

	DEBUG("\nTrying kernel: ");
	//DEBUG(this_kernel->name);
	//DEBUG("\n");

	indicate(UI_IND_MOUNT_PART);

	if (!do_block_init())
		return;

	if (!do_partitions(kernel_dram))
		return;

	/* does he want us to skip this? */

	ret = read_file(this_board->noboot, kernel_dram, 512);
	if (ret != -1) {
		/* -2 (mount fail) should make us give up too */
		if (ret >= 0) {
			DEBUG("    (Skipping on finding ");
			//DEBUG(this_board->noboot);
			DEBUG(")\n");
			indicate(UI_IND_SKIPPING);
		}
		return;
	}

	/* is there a commandline append file? */

	commandline_rootfs_append[0] = '\0';
	read_file(this_board->append, (u8 *)commandline_rootfs_append, 512);

	indicate(UI_IND_KERNEL_PULL);

	/* pull the kernel image */

	if (read_file(this_kernel->filepath, kernel_dram, 4096) < 0)
		return;

	the_kernel = load_uimage(kernel_dram);
	if (!the_kernel)
		the_kernel = load_zimage(kernel_dram);
	if (!the_kernel)
		return;

	/* initramfs if needed */

	if (this_kernel->initramfs_filepath) {
		indicate(UI_IND_INITRAMFS_PULL);
		initramfs_len = read_file(this_kernel->initramfs_filepath,
			  (u8 *)this_board->linux_mem_start + INITRD_OFFSET,
							  16 * 1024 * 1024);
		if (initramfs_len < 0) {
			DEBUG("initramfs load failed\n");
			indicate(UI_IND_INITRAMFS_PULL_FAIL);
			return;
		}
		indicate(UI_IND_INITRAMFS_PULL_OK);
	}

	do_params(initramfs_len, commandline_rootfs_append);

	/* give board implementation a chance to shut down
	 * anything it may have going on, leave GPIO set for Linux
	 */
	if (this_board->close)
		(this_board->close)();

	DEBUG("Starting --->\n\n");
	indicate(UI_IND_KERNEL_START);

	led_set(1);
	/*
	* ooh that's it, we're gonna try boot this image!
	* never mind the cache, Linux will take care of it
	*/
	the_kernel(0, this_board->linux_machine_id, this_board->linux_tag_placement);

	/* we won't come back here no matter what */
}

void bootloader_second_phase(void)
{
	/* give device a chance to print device-specific things */

	if (this_board->post_serial_init)
		(this_board->post_serial_init)();

	/* we try the possible kernels for this board in order */

	DEBUG("Phase2\n");

	udelay(100000);
	led_set(3);
	for (this_kernel = this_board->kernel_source; this_kernel->name; this_kernel++)
		try_this_kernel();

	/* none of the kernels worked out */

	DEBUG("\nNo usable kernel image found\n");
	led_blink(1, 0);
	poweroff();
}
