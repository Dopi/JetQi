/*
 * (C) Copyright 2004
 *  esd gmbh <www.esd-electronics.com>
 *  Reinhard Arlt <reinhard.arlt@esd-electronics.com>
 *
 *  based on code of fs/reiserfs/dev.c by
 *
 *  (C) Copyright 2003 - 2004
 *  Sysgo AG, <www.elinos.com>, Pavel Bartusek <pba@sysgo.com>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */


#include <qi.h>
#include <ext2.h>
#include <string.h>

extern unsigned long partition_offset_blocks;
extern unsigned long partition_length_blocks;

/* Al Ch edited this file at 2010-05-17 */
#include "../cpu/s3c6410/jet.h"
#include "../cpu/s3c6410/boot_loader_interface.h"
#define puts(s) LCD_print_newline(s)

int ext2fs_devread(int sector, int filesystem_block_log2, int byte_offset, int byte_len, u8 *buf)
{
	unsigned char sec_buf[SECTOR_SIZE];
	unsigned block_len;

	sector = sector << filesystem_block_log2;

/*
 *  Check partition boundaries
 */
	if ((sector < 0)
	|| ((sector + ((byte_offset + byte_len - 1) >> SECTOR_BITS)) >=
	partition_length_blocks)) {
		/* errnum = ERR_OUTSIDE_PART; */
		puts(" ** ext2fs_devread() read outside partition sector ");
		puts("\n");
		return 0;
	}

#if 0
	if (this_board->get_ui_keys)
		if ((this_board->get_ui_keys)() & UI_ACTION_SKIPKERNEL) {
			puts(" ** skipping \n");
			return 0;
		}
#endif

/*
 *  Get the read to the beginning of a partition.
 */
	sector += byte_offset >> SECTOR_BITS;
	byte_offset &= SECTOR_SIZE - 1;

	if (byte_offset) {
		int minimum = SECTOR_SIZE - byte_offset;

		if (byte_len < minimum)
			minimum = byte_len;

		/* read first part which isn't aligned with start of sector */
		if ((this_kernel->block_read)(sec_buf,
				partition_offset_blocks + sector, 1) < 0) {
			puts(" ** ext2fs_devread() read error **\n");
			return 0;
		}
		memcpy(buf, sec_buf + byte_offset, minimum);
		buf += minimum;
		byte_len -= minimum;
		sector++;
	}

	if (!byte_len)
		return 1;

	/*  read sector aligned part */
	block_len = byte_len & ~(SECTOR_SIZE - 1);

	if (block_len > 0) {
		if (this_kernel->block_read(buf, partition_offset_blocks + sector, block_len / SECTOR_SIZE) < 0) {
			puts(" ** ext2fs_devread() read error - block\n");
			return 0;
		}
		block_len = byte_len & ~(SECTOR_SIZE - 1);
		buf += block_len;
		byte_len -= block_len;
		sector += block_len / SECTOR_SIZE;
	}
  //puts("ext2fs_devread 4");

	if (byte_len) {
		/* read rest of data which are not in whole sector */
		if (this_kernel->block_read(sec_buf, partition_offset_blocks + sector, 1) != 1) {
			puts(" ** ext2fs_devread() read error - last part\n");
			return 0;
		}
		memcpy (buf, sec_buf, byte_len);
	}
  //puts("ext2fs_devread 5");
	return 1;
}
