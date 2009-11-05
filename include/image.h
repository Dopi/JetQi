/*
 * (C) Copyright 2008 Semihalf
 *
 * (C) Copyright 2000-2005
 * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 *
 * Copyright 2009, Roberto Gordo Saez <roberto.gordo@gmail.com>
 * Modified for SmartQ Qi bootloader.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 *
 ********************************************************************
 * NOTE: This header file defines an interface to U-Boot. Including
 * this (unmodified) header file in another file is considered normal
 * use of U-Boot, and does *not* fall under the heading of "derived
 * work".
 ********************************************************************
 */

#ifndef __IMAGE_H__
#define __IMAGE_H__

/*
 * Operating System Codes
 */
#define IH_OS_INVALID		0	/* Invalid OS	*/
#define IH_OS_OPENBSD		1	/* OpenBSD	*/
#define IH_OS_NETBSD		2	/* NetBSD	*/
#define IH_OS_FREEBSD		3	/* FreeBSD	*/
#define IH_OS_4_4BSD		4	/* 4.4BSD	*/
#define IH_OS_LINUX		5	/* Linux	*/
#define IH_OS_SVR4		6	/* SVR4		*/
#define IH_OS_ESIX		7	/* Esix		*/
#define IH_OS_SOLARIS		8	/* Solaris	*/
#define IH_OS_IRIX		9	/* Irix		*/
#define IH_OS_SCO		10	/* SCO		*/
#define IH_OS_DELL		11	/* Dell		*/
#define IH_OS_NCR		12	/* NCR		*/
#define IH_OS_LYNXOS		13	/* LynxOS	*/
#define IH_OS_VXWORKS		14	/* VxWorks	*/
#define IH_OS_PSOS		15	/* pSOS		*/
#define IH_OS_QNX		16	/* QNX		*/
#define IH_OS_U_BOOT		17	/* Firmware	*/
#define IH_OS_RTEMS		18	/* RTEMS	*/
#define IH_OS_ARTOS		19	/* ARTOS	*/
#define IH_OS_UNITY		20	/* Unity OS	*/

/*
 * CPU Architecture Codes (supported by Linux)
 */
#define IH_ARCH_INVALID		0	/* Invalid CPU	*/
#define IH_ARCH_ALPHA		1	/* Alpha	*/
#define IH_ARCH_ARM		2	/* ARM		*/
#define IH_ARCH_I386		3	/* Intel x86	*/
#define IH_ARCH_IA64		4	/* IA64		*/
#define IH_ARCH_MIPS		5	/* MIPS		*/
#define IH_ARCH_MIPS64		6	/* MIPS	 64 Bit */
#define IH_ARCH_PPC		7	/* PowerPC	*/
#define IH_ARCH_S390		8	/* IBM S390	*/
#define IH_ARCH_SH		9	/* SuperH	*/
#define IH_ARCH_SPARC		10	/* Sparc	*/
#define IH_ARCH_SPARC64		11	/* Sparc 64 Bit */
#define IH_ARCH_M68K		12	/* M68K		*/
#define IH_ARCH_NIOS		13	/* Nios-32	*/
#define IH_ARCH_MICROBLAZE	14	/* MicroBlaze   */
#define IH_ARCH_NIOS2		15	/* Nios-II	*/
#define IH_ARCH_BLACKFIN	16	/* Blackfin	*/
#define IH_ARCH_AVR32		17	/* AVR32	*/
#define IH_ARCH_ST200	        18	/* STMicroelectronics ST200  */

/*
 * Image Types
 *
 * "Standalone Programs" are directly runnable in the environment
 *	provided by U-Boot; it is expected that (if they behave
 *	well) you can continue to work in U-Boot after return from
 *	the Standalone Program.
 * "OS Kernel Images" are usually images of some Embedded OS which
 *	will take over control completely. Usually these programs
 *	will install their own set of exception handlers, device
 *	drivers, set up the MMU, etc. - this means, that you cannot
 *	expect to re-enter U-Boot except by resetting the CPU.
 * "RAMDisk Images" are more or less just data blocks, and their
 *	parameters (address, size) are passed to an OS kernel that is
 *	being started.
 * "Multi-File Images" contain several images, typically an OS
 *	(Linux) kernel image and one or more data images like
 *	RAMDisks. This construct is useful for instance when you want
 *	to boot over the network using BOOTP etc., where the boot
 *	server provides just a single image file, but you want to get
 *	for instance an OS kernel and a RAMDisk image.
 *
 *	"Multi-File Images" start with a list of image sizes, each
 *	image size (in bytes) specified by an "uint32_t" in network
 *	byte order. This list is terminated by an "(uint32_t)0".
 *	Immediately after the terminating 0 follow the images, one by
 *	one, all aligned on "uint32_t" boundaries (size rounded up to
 *	a multiple of 4 bytes - except for the last file).
 *
 * "Firmware Images" are binary images containing firmware (like
 *	U-Boot or FPGA images) which usually will be programmed to
 *	flash memory.
 *
 * "Script files" are command sequences that will be executed by
 *	U-Boot's command interpreter; this feature is especially
 *	useful when you configure U-Boot to use a real shell (hush)
 *	as command interpreter (=> Shell Scripts).
 */

#define IH_TYPE_INVALID		0	/* Invalid Image		*/
#define IH_TYPE_STANDALONE	1	/* Standalone Program		*/
#define IH_TYPE_KERNEL		2	/* OS Kernel Image		*/
#define IH_TYPE_RAMDISK		3	/* RAMDisk Image		*/
#define IH_TYPE_MULTI		4	/* Multi-File Image		*/
#define IH_TYPE_FIRMWARE	5	/* Firmware Image		*/
#define IH_TYPE_SCRIPT		6	/* Script file			*/
#define IH_TYPE_FILESYSTEM	7	/* Filesystem Image (any type)	*/
#define IH_TYPE_FLATDT		8	/* Binary Flat Device Tree Blob	*/

/*
 * Compression Types
 */
#define IH_COMP_NONE		0	/*  No	 Compression Used	*/
#define IH_COMP_GZIP		1	/* gzip	 Compression Used	*/
#define IH_COMP_BZIP2		2	/* bzip2 Compression Used	*/

#define IH_MAGIC	0x27051956	/* Image Magic Number		*/
#define IH_NMLEN		32	/* Image Name Length		*/

/*
 * Legacy format image header,
 * all data in network byte order (aka natural aka bigendian).
 */
typedef struct image_header {
	uint32_t	ih_magic;	/* Image Header Magic Number	*/
	uint32_t	ih_hcrc;	/* Image Header CRC Checksum	*/
	uint32_t	ih_time;	/* Image Creation Timestamp	*/
	uint32_t	ih_size;	/* Image Data Size		*/
	uint32_t	ih_load;	/* Data	 Load  Address		*/
	uint32_t	ih_ep;		/* Entry Point Address		*/
	uint32_t	ih_dcrc;	/* Image Data CRC Checksum	*/
	uint8_t		ih_os;		/* Operating System		*/
	uint8_t		ih_arch;	/* CPU architecture		*/
	uint8_t		ih_type;	/* Image Type			*/
	uint8_t		ih_comp;	/* Compression Type		*/
	uint8_t		ih_name[IH_NMLEN];	/* Image Name		*/
} image_header_t;

/*
 * Legacy and FIT format headers used by do_bootm() and do_bootm_<os>()
 * routines.
 */
typedef struct bootm_headers {
	/*
	 * Legacy os image header, if it is a multi component image
	 * then boot_get_ramdisk() and get_fdt() will attempt to get
	 * data from second and third component accordingly.
	 */
	image_header_t	*legacy_hdr_os;
	unsigned long		legacy_hdr_valid;

#if defined(CONFIG_FIT)
	const char	*fit_uname_cfg;	/* configuration node unit name */

	void		*fit_hdr_os;	/* os FIT image header */
	const char	*fit_uname_os;	/* os subimage node unit name */
	int		fit_noffset_os;	/* os subimage node offset */

	void		*fit_hdr_rd;	/* init ramdisk FIT image header */
	const char	*fit_uname_rd;	/* init ramdisk subimage node unit name */
	int		fit_noffset_rd;	/* init ramdisk subimage node offset */

#if defined(CONFIG_PPC)
	void		*fit_hdr_fdt;	/* FDT blob FIT image header */
	const char	*fit_uname_fdt;	/* FDT blob subimage node unit name */
	int		fit_noffset_fdt;/* FDT blob subimage node offset */
#endif
#endif

	int		verify;		/* getenv("verify")[0] != 'n' */
	int		autostart;	/* getenv("autostart")[0] != 'n' */
	struct lmb	*lmb;		/* for memory mgmt */
} bootm_headers_t;

/*
 * Some systems (for example LWMON) have very short watchdog periods;
 * we must make sure to split long operations like memmove() or
 * crc32() into reasonable chunks.
 */
#define CHUNKSZ (64 * 1024)

#define uimage_to_cpu(x)		__be32_to_cpu(x)
#define cpu_to_uimage(x)		__cpu_to_be32(x)

#ifndef USE_HOSTCC
/* Image format types, returned by _get_format() routine */
#define IMAGE_FORMAT_INVALID	0x00
#define IMAGE_FORMAT_LEGACY	0x01	/* legacy image_header based format */
#define IMAGE_FORMAT_FIT	0x02	/* new, libfdt based format */

int genimg_has_config (bootm_headers_t *images);

int boot_get_ramdisk (int argc, char *argv[], bootm_headers_t *images,
		uint8_t arch, unsigned long *rd_start, unsigned long *rd_end);

#if defined(CONFIG_PPC) || defined(CONFIG_M68K)
int boot_ramdisk_high (struct lmb *lmb, unsigned long rd_data, unsigned long rd_len,
		  unsigned long *initrd_start, unsigned long *initrd_end);

int boot_get_cmdline (struct lmb *lmb, unsigned long *cmd_start, unsigned long *cmd_end,
			unsigned long bootmap_base);
int boot_get_kbd (struct lmb *lmb, bd_t **kbd, unsigned long bootmap_base);
#endif /* CONFIG_PPC || CONFIG_M68K */
#endif /* !USE_HOSTCC */


/*******************************************************************/
/* New uImage format specific code (prefixed with fit_) */
/*******************************************************************/
#if defined(CONFIG_FIT)

#define FIT_IMAGES_PATH		"/images"
#define FIT_CONFS_PATH		"/configurations"

/* hash node */
#define FIT_HASH_NODENAME	"hash"
#define FIT_ALGO_PROP		"algo"
#define FIT_VALUE_PROP		"value"

/* image node */
#define FIT_DATA_PROP		"data"
#define FIT_TIMESTAMP_PROP	"timestamp"
#define FIT_DESC_PROP		"description"
#define FIT_ARCH_PROP		"arch"
#define FIT_TYPE_PROP		"type"
#define FIT_OS_PROP		"os"
#define FIT_COMP_PROP		"compression"
#define FIT_ENTRY_PROP		"entry"
#define FIT_LOAD_PROP		"load"

/* configuration node */
#define FIT_KERNEL_PROP		"kernel"
#define FIT_RAMDISK_PROP	"ramdisk"
#define FIT_FDT_PROP		"fdt"
#define FIT_DEFAULT_PROP	"default"

#define FIT_MAX_HASH_LEN	20	/* max(crc32_len(4), sha1_len(20)) */

#endif /* CONFIG_FIT */

#endif	/* __IMAGE_H__ */
