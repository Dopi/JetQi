/*
 * (C) Copyright 2002
 * Gary Jennejohn, DENX Software Engineering, <gj@denx.de>
 *
 * See file CREDITS for list of people who contributed to this
 * project.
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

OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
/*OUTPUT_FORMAT("elf32-arm", "elf32-arm", "elf32-arm")*/
OUTPUT_ARCH(arm)
ENTRY(_start)
SECTIONS
{
	. = 0x00000000;

	__system_ram_start = 0x50000000;
	__steppingstone = 0x0c000000;

	/* this text section is magically pulled from the SD Card
	 * and stored by the iRom at 0x0c000000, then it is jumped into
	 * by the iRom.  So we arrange our early parts needed at 0 in the
	 * output file, but set to run at 0x0c000000+
	 */

	.text
		__steppingstone :
		AT (0)
	{
	  src/cpu/s3c6410/start.o		(.text .rodata* .data .bss)
	  src/cpu/s3c6410/boot_loader.little.o		(.text .rodata* .data .bss)
/*	  src/cpu/s3c6410/start_qi.o		(.text .rodata* .data .bss) */
/*	  src/cpu/s3c6410/jet.o			(.text .rodata* .data .bss) */
/*	  src/cpu/s3c6410/serial-s3c64xx.o	(.text .rodata* .data .bss) */
/*	  src/utils.o				(.text .rodata* .data .bss) */
/*	  src/ctype.o				(.text .rodata* .data .bss) */
	  *					(.steppingstone)
	}

	. = ALIGN(4);
	.everything_else
		__system_ram_start + 0x3000000 + SIZEOF(.text) :
		AT (SIZEOF(.text))
	{
		*(.text .rodata* .data)
	}

	__bss_start = __system_ram_start + 0x03800000;
	.bss_6410
		__bss_start (NOLOAD) :
		AT (SIZEOF(.text) + SIZEOF(.everything_else))
	{
		* (.bss)
	}

	_end = .;
}
