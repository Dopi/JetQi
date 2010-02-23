/*
 *
 * Jet (GT-S8000/8003) asm second sage start code
 * (C) Copiright 2010 Dopi711@googlemail.com
 *
 * This program is free software// you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation// either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY// without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program// if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */

#define __ASM_MODE__
#define __ASSEMBLY__

#include <s3c6410.h>

#define TEXT_BASE 0x53000000

#define RET		bx	lr

.globl _pre_start, processor_id

_pre_start:
	b	_pre_start2

_pre_start_1:
	b	_pre_start_1
_pre_start_2:
	b	_pre_start_2
_pre_start_3:
	b	_pre_start_3
_pre_start_4:
	b	_pre_start_4
_pre_start_5:
	b	_pre_start_5

_pre_start2:

_wait_10s:
	mov	r0, #0x20000000			// approx 10 sec wait
_waitloop:
	subs	r0, r0, #1
	cmp	r0, #0
	bne	_waitloop

_continue_with_start_qi:
	ldr	pc, _start_oldboot
//	ldr	pc, _start_armboot

_start_armboot:
	.word 	start_qi
_start_oldboot:
	.word 	#0x51400000

