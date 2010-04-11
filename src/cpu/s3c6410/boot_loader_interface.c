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

//#include <s3c6410.h>

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

