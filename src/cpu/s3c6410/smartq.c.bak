/**********************************************************************
* This file is constructed by Roberto Gordo Saez
* <roberto.gordo@gmail.com>, based on U-Boot and Qi source for SmartQ.
*
* SmartQ source:
* board/samsung/smdk6410/cmd_hhtech.c
* board/samsung/smdk6410/misc.c
*
*   王刚(WangGang)  <wanggang@hhcn.com>
*   CopyRight (c)  2009  HHTech
*     www.hhcn.com, www.hhcn.org
*     All rights reserved.
*
*   This file is free software;
*     you are free to modify and/or redistribute it
*     under the terms of the GNU General Public Licence (GPL).
*
*   No warranty, no liability, use this at your own risk!
*
* Qi source is (C) Copyright 2008 Openmoko, Inc.
* Author: Andy Green <andy@openmoko.org>
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
**********************************************************************/

#include <qi.h>
#include <serial-s3c64xx.h>

#define SMDK6410_DEBUG_UART 0


#define CHANNEL ((*(volatile u32*)0x0C003FEC == 0x7c300000) ? 1 : 0)

#define CopyMMCtoMem(a,b,c,e) (((u8(*)(int, unsigned int, unsigned short, unsigned int*, u8)) \
	(*((unsigned int*)0x0C004008)))(CHANNEL,a,b,c,e))

/* LED is on GPN8 and GPN9 */
#define GPIO_LED_0 (('N'-'A')*16 + 8)
#define GPIO_LED_1 (('N'-'A')*16 + 9)
/* SMARTQ7:
#define GPIO_LED_0 (('N'-'A')*16 + 9)
#define GPIO_LED_1 (('N'-'A')*16 + 8)
*/

/* high poweroff, low start */
#define GPIO_POWEROFF (('K'-'A')*16 + 15)

/* LCD backlight on or off */
#define GPIO_LCD_BACKLIGHT (('F'-'A')*16 + 15)

/* DAT offset for groups */
static char gdat[]= {4, 4, 4, 4, 4, 4, 4, 8, 4, 4, 8, 8, 4, 4, 4, 4, 4};
/* CONF MASK BITS for groups */
static char gcsz[]= {4, 4, 4, 4, 4, 2, 4, 4, 2, 2, 4, 4, 4, 2, 2, 2, 2};
static unsigned short gbase[] =
	{0x000, 0x020, 0x040, 0x060, 0x080, 0x0A0, 0x0C0, 0x0E0, 0x100, 0x120, /* A ... J */
	 0x800, 0x810, 0x820, 0x830, /* K ... N */
	 0x140, 0x160, 0x180, }; /* O P Q */

static unsigned long gpio_base = 0x7f008000;

#define readl(a) (*(volatile unsigned int *)(a))
#define writel(v,a) (*(volatile unsigned int *)(a) = (v))

static int gpio_direction_set(int gpio, int out)
{
	int group = gpio >> 4, sub = gpio % 16;
	unsigned char mask = 0x03;
	unsigned int regconf = 0, val, regpud = 0;

	regconf = gpio_base + gbase[group];
	if(gcsz[group] == 4) {
		mask = 0x0F;
		if(sub >= 8) regconf += 4;
	}

	val = readl(regconf);
	if(4 == gcsz[group] && sub >= 8)
		val &= ~((mask) << (gcsz[group] * (sub-8)));
	else
		val &= ~((mask) << (gcsz[group] * sub));

	if(out) {
		if(4 == gcsz[group] && sub >= 8)
			val |= ((0x01) << (gcsz[group] * (sub-8)));
		else
			val |= ((0x01) << (gcsz[group] * sub));
	}
	writel(val, regconf);

	regpud = gpio_base + gbase[group] + gdat[sub] + 4;
	if(4 == gcsz[group]) regpud += 4;
	val = readl(regpud);
	val &= ~(0x3<<(sub*2));
	writel(val, regpud);

	return 0;
}

/* ret : high is 1, low is 0 */
static int gpio_set_value(int gpio, int dat)
{
	int group = gpio >> 4, sub = gpio % 16;
	unsigned int regdat = 0, val;

	regdat = gpio_base + gbase[group] + gdat[sub];
	if(4 == gcsz[group]) regdat += 4;
	val = readl(regdat);

	if(dat)
		val |= (1<<sub);
	else
		val &= ~(1<<sub);

	writel(val, regdat);
	return 0;
}

static void gpio_direction_output(int gpio, int dat)
{
	gpio_direction_set(gpio, 1);
	gpio_set_value(gpio, dat);
}

void led_set(int flag)
{
	flag = flag % 4;

	if(flag & 0x01)
		gpio_direction_output(GPIO_LED_0, 0);
	else
		gpio_direction_output(GPIO_LED_0, 1);

	if(flag & 0x02)
		gpio_direction_output(GPIO_LED_1, 0);
	else
		gpio_direction_output(GPIO_LED_1, 1);
}

void led_blink(int l1, int l2)
{
	int i = 5;
	while(i--) {
		led_set(l1);
		udelay(600000);
		led_set(l2);
		udelay(600000);
	}
}

void poweroff(void)
{
	led_set(0);
	gpio_direction_output(GPIO_POWEROFF, 1);
}

/*void set_lcd_backlight(int flag)
{
	gpio_direction_output(GPIO_LCD_BACKLIGHT, flag ? 1 : 0);
}*/

int battery_probe(void)
{
	/* TODO */
	return 0;
}

int is_this_board_smartq(void)
{
	/* FIXME: find something SmartQ specific */
	return 1;
}

static void putc_smdk6410(char c)
{
	serial_putc_s3c64xx(SMDK6410_DEBUG_UART, c);
}

int sd_card_block_read_smartq(unsigned char *buf, unsigned long start512, int blocks512)
{
	int retval;

	if(blocks512 > 1)
		retval = (int)CopyMMCtoMem(start512, blocks512, (void*)buf, 0);
	else if(blocks512 == 1) {
		/* CopyMMCtoMem fails to read 1 block. This is a workaround that reads 2
		blocks to a temporary buffer and copy only the first one. */
		u8 tmpbuf[512 * 2];
		retval = (int)CopyMMCtoMem(start512, 2, (void*)tmpbuf, 0);
		if(retval)
			memcpy(buf, tmpbuf, 512);
	} else
		return 0;
	if(!retval)
		return -1;
	return blocks512;
}

static const struct board_variant board_variants[] = {
	[0] = {
		.name = "SmartQ",
		.machine_revision = 0,
	},
};

const struct board_variant const * get_board_variant_smartq(void)
{
	return &board_variants[0];
}

const struct board_api board_api_smartq = {
	.name = "SMDK6410",
	.linux_machine_id = 1626,
	.linux_mem_start = 0x50000000,
	.linux_mem_size = (128 * 1024 * 1024),
	.linux_tag_placement = 0x50000000 + 0x100,
	.get_board_variant = get_board_variant_smartq,
	.is_this_board = is_this_board_smartq,
	.putc = putc_smdk6410,
	.commandline_board = "loglevel=6 rootwait s3cfb.backlight=80 ",
	.commandline_board_debug = "console=ttySAC0,115200n8 ignore_loglevel ",
	.noboot = "boot/noboot-SMDK6410",
	.append = "boot/append-SMDK6410",
	.kernel_source = {
		[0] = {
			.name = "SD Card rootfs P1",
			.block_read = sd_card_block_read_smartq,
			.filesystem = FS_EXT2,
			.partition_index = 1,
			.filepath = "boot/linux-SMDK6410.bin",
			.commandline_append = "root=/dev/mmcblk1p1 "
		},
		[1] = {
			.name = "SD Card rootfs P2",
			.block_read = sd_card_block_read_smartq,
			.filesystem = FS_EXT2,
			.partition_index = 2,
			.filepath = "boot/linux-SMDK6410.bin",
			.commandline_append = "root=/dev/mmcblk1p2 "
		},
		[2] = {
			.name = "SD Card rootfs P3",
			.block_read = sd_card_block_read_smartq,
			.filesystem = FS_EXT2,
			.partition_index = 3,
			.filepath = "boot/linux-SMDK6410.bin",
			.commandline_append = "root=/dev/mmcblk1p3 "
		},
		[3] = {
			.name = "SD Card rootfs P4",
			.block_read = sd_card_block_read_smartq,
			.filesystem = FS_EXT2,
			.partition_index = 4,
			.filepath = "boot/linux-SMDK6410.bin",
			.commandline_append = "root=/dev/mmcblk1p4 "
		},
	},
};
