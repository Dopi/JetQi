/*
 * (C) Copyright 2007 OpenMoko, Inc.
 * Author: Andy Green <andy@openmoko.com>
 *
 * Configuation settings for the FIC Neo GTA02 Linux GSM phone
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
#include <s3c6410.h>

/*
 * Output a single byte to the serial port.
 */
void serial_putc_s3c64xx(const int uart, const char c)
{
	if (uart >= 4)
		return;

	while (!(__REG(0x7F005000 + UTRSTAT_OFFSET + (uart << 10)) & 0x2))
		;

	__REG(0x7F005000 + UTXH_OFFSET + (uart << 10)) = c;
}
