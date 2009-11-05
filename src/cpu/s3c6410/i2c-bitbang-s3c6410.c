/*
 * (C) Copyright 2007 OpenMoko, Inc.
 * Author: Andy Green <andy@openmoko.com>
 *
 * s3c6410-specific i2c
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
 *
 */

#include <qi.h>
#include <i2c-bitbang.h>
#include <s3c6410.h>

static char i2c_read_sda_s3c6410(void)
{
	return !!(__REG(GPBDAT) & (1 << 6));
}

static void i2c_set_s3c6410(char clock, char data)
{
	if (clock) /* SCL <- input */
		__REG(GPBCON) = (__REG(GPBCON) & ~(3 << (5 * 4)));
	else { /* SCL <- output 0 */
		__REG(GPBDAT) = (__REG(GPBDAT) & ~(1 << 5));
		__REG(GPBCON) = (__REG(GPBCON) & ~(3 << (5 * 4))) | (1 << (5 * 4));
	}
	if (data) /* SDA <- input */
		__REG(GPBCON) = (__REG(GPBCON) & ~(3 << (6 * 4)));
	else { /* SDA <- output 0 */
		__REG(GPBDAT) = (__REG(GPBDAT) & ~(1 << 6));
		__REG(GPBCON) = (__REG(GPBCON) & ~(3 << (6 * 4))) | (1 << (6 * 4));
	}
}

static void i2c_close_s3c6410(void)
{
	/* set back to hardware I2C ready for Linux */
	__REG(GPBCON) = (__REG(GPBCON) & ~(3 << (5 * 4))) | (2 << (5 * 4));
	__REG(GPBCON) = (__REG(GPBCON) & ~(3 << (6 * 4))) | (2 << (6 * 4));
}

static void i2c_spin_s3c6410(void)
{
	int n;

	for (n = 0; n < 1000; n++)
		__REG(GPBDAT) = __REG(GPBDAT);
}

struct i2c_bitbang bb_s3c6410 = {
	.read_sda = i2c_read_sda_s3c6410,
	.set = i2c_set_s3c6410,
	.spin = i2c_spin_s3c6410,
	.close = i2c_close_s3c6410,
};
