/*
 * (C) Copyright 2007 OpenMoko, Inc.
 * Author: xiangfu liu <xiangfu@openmoko.org>
 *         Andy Green <andy@openmoko.com>
 *
 * Modified for SmartQ, 2009, Roberto Gordo Saez <roberto.gordo@gmail.com>
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

/* NOTE this stuff runs in steppingstone context! */


#include <qi.h>
#include <serial-s3c64xx.h>
#include "smartq.h"

#define stringify2(s) stringify1(s)
#define stringify1(s) #s

void bootloader_second_phase(void);

const struct board_api *boards[] = {
	&board_api_smartq,
	NULL /* always last */
};

struct board_api const * this_board;
extern int is_jtag;

#define BOOTLOADER_MEM_ADDR (0x53000000) /* run bootloader here */
#define BOOTLOADER_BLKS (1008) /* max size is 504KiB (1008 blocks) */

#define globalBlockSizeHide (*((volatile unsigned int*)(0x0C004000-0x4)))

void start_qi(void)
{
	int flag = 0;
	int board = 0;

	/*
	 * well, we can be running on this CPU two different ways.
	 *
	 * 1) We were copied into steppingstone and TEXT_BASE already
	 *    by JTAG.  We don't have to do anything else.  JTAG script
	 *    then sets data at address 0x4 to 0xffffffff as a signal we
	 *    are running by JTAG.
	 *
	 * 2) We only got our first 4K into steppingstone, we need to copy
	 *    the rest of ourselves into TEXT_BASE.
	 *
	 * So we do the copy out of NAND only if we see we did not come up
	 * under control of JTAG.
	 */

	led_set(2);

	/* ask all the boards we support in turn if they recognize this
	 * hardware we are running on, accept the first positive answer
	 */

	this_board = boards[board];
	while (this_board)
		/* check if it is the right board... */
		if (this_board->is_this_board())
			break;
		else
			this_board = boards[board++];

	/* okay, do the critical port and serial init for our board */

	if (this_board->early_port_init)
		this_board->early_port_init();

	set_putc_func(this_board->putc);

	/* stick some hello messages on debug console */

	puts("\n\n\nQi Bootloader "stringify2(QI_CPU)"  "
	   stringify2(BUILD_HOST)" "
	   stringify2(BUILD_VERSION)" "
	   "\n");

	puts(stringify2(BUILD_DATE) "  Copyright (C) 2008 Openmoko, Inc.\n");
	puts("  This version of Qi for SmartQ devices is modified by\n");
	puts("  Roberto Gordo Saez <roberto.gordo@gmail.com>\n\n");

	if (!is_jtag) {
		/*
		* We got the first 8KBytes of the bootloader pulled into the
		* steppingstone SRAM for free.  Now we pull the whole bootloader
		* image into SDRAM.
		*
		* This code and the .S files are arranged by the linker script
		* to expect to run from 0x0.  But the linker script has told
		* everything else to expect to run from 0x53000000+.  That's
		* why we are going to be able to copy this code and not have it
		* crash when we run it from there.
		*/

		if (!(flag = sd_card_block_read_smartq((void*)BOOTLOADER_MEM_ADDR,
		globalBlockSizeHide - BOOTLOADER_BLKS - 18, BOOTLOADER_BLKS))) {
			led_blink(3, 0);
			poweroff();
		}
	}

	/* all of Qi is in memory now, stuff outside steppingstone too */

	if (this_board->port_init)
		this_board->port_init();

	/* puts("\n     Detected: ");
	puts(this_board->name);
	puts(", ");
	puts((this_board->get_board_variant)()->name);
	puts("\n"); */

	/* jump to bootloader_second_phase() running from DRAM copy */
	bootloader_second_phase();
}
