/*
 * (C) Copyright 2007 OpenMoko, Inc.
 * Author: xiangfu liu <xiangfu@openmoko.org>
 *         Andy Green <andy@openmoko.com>
 *
 * Modified for Jet, 2010 dopi711@googlemail.com
 * based on SmartQi by Roberto Gordo Saez <roberto.gordo@gmail.com>
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
#include "jet.h"
#include "boot_loader_interface.h"

#define stringify2(s) stringify1(s)
#define stringify1(s) #s
#define DEBUG(s) LCD_print_newline(s)	// initially it was puts(s)

void bootloader_second_phase(void);

const struct board_api *boards[] = {
	&board_api_jet,
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
	 * We were copied into steppingstone and TEXT_BASE already
	 * by the original bootloader and some additional custom code.
	 * We don't have to do anything else.  
	 *
	 */

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

	//set_putc_func(this_board->putc);

	/* stick some hello messages on debug output */

	DEBUG("Qi Bootloader "stringify2(QI_CPU)"  "
	   stringify2(BUILD_HOST)" "
	   stringify2(BUILD_VERSION)" "
	   "\n");

	DEBUG(stringify2(BUILD_DATE) "  Copyright (C) 2008 Openmoko, Inc.\n");
	DEBUG("  This version of Qi for Jet (S8000) is modified by\n");
	DEBUG("  dopi711@googlemail.com>\n\n");

	if (this_board->port_init)
		this_board->port_init();

	/* DEBUG("\n     Detected: ");
	DEBUG(this_board->name);
	DEBUG((this_board->get_board_variant)()->name);

	/* jump to bootloader_second_phase() running from DRAM copy */
	DEBUG("starting second phase ...");
	bootloader_second_phase();
}
