/*
 * (C) Copyright 2009 
 * Author: Dopi <dopi711@googlemail.com>
 *
 * bootloader specific code
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

#include <s3c6410.h>
#include "boot_loader_interface.h"

void jump_OneNAND_Init (void)
{
asm volatile (
	"ldr	pc, adr_OneNAND_Init\n\t"
	"adr_OneNAND_Init:	.word	0x51401C3C\n\t"
);
}

void jump_LCD_InitWin (void)
{
asm volatile (
	"ldr	pc, adr_LCD_InitWin\n\t"
	"adr_LCD_InitWin:	.word	0x51401B28"
);
}

void jump_LaunchNucleus (void)
{
//	char *jump_addr;
//	jump_addr = (char*) 0x514023A8;
asm volatile (
//	"ldr	pc, %[pointer]"
//	: : [pointer] "X" (&jump_addr)
	"ldr	pc, adr_LaunchNucleus\n\t"
	"adr_LaunchNucleus:	.word	0x514023A8"
);
}	

int LCD_printf (char *out_string, int line_number)
{
	int res;
asm volatile (
	"mov	R3, #0\n\t"
	"mov	r1, %[line_pointer]\n\t"
	"mov	r0, %[out_string]\n\t"
	"ldr	pc, adr_LCD_printf\n\t"
//	"adr_LCD_printf:	.word	0x514182D4"
	: [result] "=r" (res) 
	: [line_pointer] "r" (line_number), [out_string] "r" (out_string)
);
	return res;
}	

void jump_LCD_printf (void)
{
asm volatile (
	"ldr	pc, adr_LCD_printf\n\t"
	"adr_LCD_printf:	.word	0x514182D4"
);
}	

void jump_MSG_UPLOAD_data_to_pc (void)
{
asm volatile (
	"ldr	pc, adr_MSG_UPLOAD_data_to_pc\n\t"
	"adr_MSG_UPLOAD_data_to_pc:	.word	0x5141852C"
);
}	

void jump_LCD_clear_screen (void)
{
asm volatile (
	"ldr	pc, adr_LCD_clear_screen\n\t"
	"adr_LCD_clear_screen:	.word	0x5141847C"
);
}

void jump_Samsung_boot_logo (void)
{
asm volatile (
	"ldr	pc, adr_Samsung_boot_logo\n\t"
	"adr_Samsung_boot_logo:	.word	0x51418498"
);
}

void jump_LCD_blue_screen (void)
{
asm volatile (
	"ldr	pc, adr_LCD_blue_screen\n\t"
	"adr_LCD_blue_screen:	.word	0x5141864C"
);
}

void jump_Baseband_Init (void)
{
asm volatile (
	"ldr	pc, adr_Baseband_Init\n\t"
	"adr_Baseband_Init:	.word	0x5141983C"
);
}





void wait_10s (void)
{
asm volatile (
	"mov	r0, #0x20000000\n\t"	// approx 10 sec wait
	"_wait10loop:"
	"subs	r0, r0, #1\n\t"
	"cmp	r0, #0\n\t"
	"bne	_wait10loop"
	: : : "r0"
);
}

void wait_5s (void)
{
asm volatile (
	"mov	r0, #0x10000000\n\t"	// approx 5 sec wait
	"_wait5loop:"
	"subs	r0, r0, #1\n\t"
	"cmp	r0, #0\n\t"
	"bne	_wait5loop"
	: : : "r0"
);
}

void spin_forever (void)
{
asm volatile (
	"_spin_forever:"
	"b	_spin_forever"
);
}


/*
unsigned long ByteSwap(unsigned long val)
{
asm volatile (
        "eor     r3, %1, %1, ror #16\n\t"
        "bic     r3, r3, #0x00FF0000\n\t"
        "mov     %0, %1, ror #8\n\t"
        "eor     %0, %0, r3, lsr #8"
        : "=r" (val)
        : "0"(val)
        : "r3" 
);
return val;
}
*/

