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
	mrc	p15, 0, r0, cr1, cr0, 2
	orr	r0, r0, #0xf00000
	mcr	p15, 0, r0, cr1, cr0, 2
	.word	0xeef81a10		//	fmrx	r1, fpexc
	orr	r1, r1, #0x40000000
	.word	0xeee81a10		//	fmxr	fpexc, r1
	mov	r0, #0x3000000
	.word	0xeee10a10		//	fmxr	fpscr, r0
	mov	r0, #0	// 0x0
	mcr	p15, 0, r0, cr9, cr2, 0
	mov	r0, #0x4000
	orr	r0, r0, #1	// 0x1
	mcr	p15, 0, r0, cr9, cr1, 0
	mov	r0, #1	// 0x1
	mcr	p15, 0, r0, cr9, cr2, 0
	mov	r0, #0x6000
	orr	r0, r0, #1	// 0x1
	mcr	p15, 0, r0, cr9, cr1, 0
	mov	r0, #0	// 0x0
	mcr	p15, 0, r0, cr9, cr2, 0
	mov	r0, #0	// 0x0
	orr	r0, r0, #1	// 0x1
	mcr	p15, 0, r0, cr9, cr1, 1
	mov	r0, #1	// 0x1
	mcr	p15, 0, r0, cr9, cr2, 0
	mov	r0, #0x2000
	orr	r0, r0, #1	// 0x1
	mcr	p15, 0, r0, cr9, cr1, 1
	ldr	r0, _5140011c
	mvn	r1, #0	// 0x0
	str	r1, [r0]
	ldr	r0, _51400120
	mvn	r1, #0	// 0x0
	str	r1, [r0]
	ldr	r0, _51400124
	mov	r1, #0	// 0x0
	str	r1, [r0]
	mov	r0, #0	// 0x0
	mcr	p15, 0, r0, cr8, cr7, 0
	mcr	p15, 0, r0, cr7, cr5, 0
	mcr	p15, 0, r0, cr7, cr6, 0
	bl	sub_51433bb4
	bl	sub_51433b64
	bl	sub_51433b74
	mrs	r0, CPSR
	bic	r0, r0, #31	// 0x1f
	orr	r1, r0, #210	// 0xd2
	msr	CPSR_fsxc, r1
	ldr	sp, _51400128
	bic	r0, r0, #223	// 0xdf
	orr	r1, r0, #19	// 0x13
	msr	CPSR_fsxc, r1
	ldr	sp, _5140012c
	mov	r8, #80	// 0x50
	ldr	r9, _51400130
	ldmia	r9!, {r0, r1, r2, r3, r4, r5, r6, r7}
	stmia	r8!, {r0, r1, r2, r3, r4, r5, r6, r7}
	mov	r8, #0	// 0x0
	ldr	r9, _51400134
	ldmia	r9!, {r0, r1, r2, r3, r4, r5, r6, r7}
	stmia	r8!, {r0, r1, r2, r3, r4, r5, r6, r7}
	b	_init2
_init1_end:
	b	_init1_end


/*
 * Variables
 */

_oldstart:	.word	0x5140300C //0x51403010 //0x51402FE0 //0x51402f7c // 0x51400000

_5140011c:	.word	0x71200014
_51400120:	.word	0x71300014
_51400124:	.word	0x7e004000
_51400128:	.word	0x518fff00
_5140012c:	.word	0x518ff900
_51400130:	.word	0x514400d4
_51400134:	.word	0x514400b4

sub_514380F8:	.word	0x514380F8
sub_51438078:	.word	0x51438078
sub_514381C4:	.word	0x514381C4
sub_514152F8:	.word	0x514152F8
sub_514029B0:	.word	0x514029B0
sub_51401C3C:	.word	0x51401C3C
sub_51438160:	.word	0x51438160
sub_51430F80:	.word	0x51430F80
sub_51419D0C:	.word	0x51419D0C
sub_5141AF20:	.word	0x5141AF20
sub_51401B28:	.word	0x51401B28
sub_51417FA0:	.word	0x51417FA0
sub_51417F24:	.word	0x51417F24
sub_514182D4:	.word	0x514182D4
sub_5141AB40:	.word	0x5141AB40
sub_5142fd5c: 	.word	0x5142fd5c

var_adr_51403204:	.word	0x51403204
var_adr_51403208:	.word	0x51403208
var_adr_5140320c:	.word 	0x5140320c
var_adr_51403210:	.word	0x51403210
var_adr_51403214:	.word	0x51403214
var_51415448:	.word	0x5a0b0004
var_51402258:	.word	0x514449A8

/*
 * Long Distance Calls
 */

call_sub_514380F8:
	stmdb   sp!, {lr}
	adr	lr, locret_call_sub_514380F8
	ldr	r2, sub_514380F8 // r2 is going to be cleared in the sub, anyway
	bx	r2
locret_call_sub_514380F8:
	ldmia	sp!, {pc}

call_sub_51438078:
	stmdb   sp!, {lr}
	adr	lr, locret_call_sub_51438078
	ldr	r4, sub_51438078 // r4 is going to be cleared in the sub, anyway
	bx	r4
locret_call_sub_51438078:
	ldmia	sp!, {pc}

call_sub_514381C4:
	stmdb   sp!, {lr}
	adr	lr, locret_call_sub_514381C4
	ldr	r2, sub_514381C4 // r2 is going to be cleared in the sub, anyway
	bx	r2
locret_call_sub_514381C4:
	ldmia	sp!, {pc}

call_sub_5142FD38:
	stmdb   sp!, {lr}
	adr	lr, locret_call_sub_5142FD38
	ldr	r3, sub_5142FD38 // r3 is going to be cleared in the sub, anyway
	bx	r3
locret_call_sub_5142FD38:
	ldmia	sp!, {pc}

call_sub_5142fd5c:
	stmdb   sp!, {lr}
	adr	lr, locret_call_sub_5142fd5c
	ldr	r3, sub_5142fd5c // r3 is going to be cleared in the sub, anyway
	bx	r3
locret_call_sub_5142fd5c:
	ldmia	sp!, {pc}

call_sub_514152F8:
	stmdb   sp!, {lr}
	adr	lr, locret_call_sub_514152F8
	ldr	r0, sub_514152F8 // r0 is going to be cleared in the sub, anyway
	bx	r0
locret_call_sub_514152F8:
	ldmia	sp!, {pc}

call_sub_514029B0:
	stmdb   sp!, {lr}
	adr	lr, locret_call_sub_514029B0
	ldr	r0, sub_514029B0 // r0 is going to be cleared in the sub, anyway
	bx	r0
locret_call_sub_514029B0:
	ldmia	sp!, {pc}

call_sub_51401C3C:
	stmdb   sp!, {lr}
	adr	lr, locret_call_sub_51401C3C
	ldr	r0, sub_51401C3C // r0 is going to be cleared in the sub, anyway
	bx	r0
locret_call_sub_51401C3C:
	ldmia	sp!, {pc}

call_sub_51438160:
	stmdb   sp!, {lr}
	adr	lr, locret_call_sub_51438160
	ldr	r1, sub_51438160 // r1 is going to be cleared in the sub, anyway
	bx	r1
locret_call_sub_51438160:
	ldmia	sp!, {pc}

call_sub_51430F80:
	stmdb   sp!, {lr}
	adr	lr, locret_call_sub_51430F80
	ldr	r2, sub_51430F80 // r2 is going to be cleared in the sub, anyway
	bx	r2
locret_call_sub_51430F80:
	ldmia	sp!, {pc}

call_sub_51419D0C:
	stmdb   sp!, {lr}
	adr	lr, locret_call_sub_51419D0C
	ldr	r2, sub_51419D0C // r2 is going to be cleared in the sub, anyway
	bx	r2
locret_call_sub_51419D0C:
	ldmia	sp!, {pc}

call_sub_5141AF20:
	stmdb   sp!, {lr}
	adr	lr, locret_call_sub_5141AF20
	ldr	r2, sub_5141AF20 // r2 is going to be cleared in the sub, anyway
	bx	r2
locret_call_sub_5141AF20:
	ldmia	sp!, {pc}
	
call_sub_51417FA0:
	stmdb   sp!, {lr}
	adr	lr, locret_call_sub_51417FA0
	ldr	r0, sub_51417FA0 // r0 is going to be cleared in the sub, anyway
	bx	r0
locret_call_sub_51417FA0:
	ldmia	sp!, {pc}

call_sub_51417F24:
	stmdb   sp!, {lr}
	adr	lr, locret_call_sub_51417F24
	ldr	r1, sub_51417F24 // r1 is going to be cleared in the sub, anyway
	bx	r1
locret_call_sub_51417F24:
	ldmia	sp!, {pc}
	
LCD_InitWin:
	stmdb   sp!, {lr}
	adr	lr, locret_LCD_InitWin
	ldr	r1, sub_51401B28 // r1 is going to be cleared in the sub, anyway
	bx	r1
locret_LCD_InitWin:
	ldmia	sp!, {pc}
	
I2C_something:
	stmdb   sp!, {lr}
	adr	lr, locret_I2C_something
	ldr	r2, sub_5141AB40 // r2 is going to be cleared in the sub, anyway. CHECKED
	bx	r2
locret_I2C_something:
	ldmia	sp!, {pc}

LCD_printf:
	stmdb   sp!, {lr}
	adr	lr, locret_LCD_printf
	ldr	r3, sub_514182D4 // r3 is going to be cleared in the sub, anyway
	bx	r3
locret_LCD_printf:
	ldmia	sp!, {pc}

/* 
 * Auxiliary Subroutines
 */

sub_5142FD38:
	mov     r3, #0
	mov     r12, r2,lsr#2
loc_5142FD40:
	cmp     R3, R12
	bcs     locret_5142FD58
	ldr     R2, [R1,R3,LSL#2]
	str     R2, [R0,R3,LSL#2]
	add     R3, R3, #1
	b       loc_5142FD40
locret_5142FD58: 
	bx      lr


real_sub_5142fd5c:	
	mov	r3, #0	// 0x0
	mov	r2, r2, lsr #2
loc_5142fd64:
	cmp	r3, r2
	bcs	locret_5142fd78 // <__oldboot_ram_start+0x2fd78>
	str	r1, [r0, r3, lsl #2]
	add	r3, r3, #1	// 0x1
	b	loc_5142fd64 	// <__oldboot_ram_start+0x2fd64>
locret_5142fd78:
	bx	lr


sub_51433b64:
	mrc     p15, 0, R0,c1,c0
	bic     R0, R0, #0x1000000
	mcr     p15, 0, R0,c1,c0
	bx      lr


sub_51433b74:
	mrs     R0, CPSR
	bic     R0, R0, #0x80
	msr     CPSR_cxsf, R0
	bx      lr


sub_51433bb4:
	mrc     p15, 0, R0,c1,c0
	orr     R0, R0, #0x800
	mcr     p15, 0, R0,c1,c0
	bx      lr


/*
 * INIT 2
 */

_init2:
	stmdb   sp!, {r3-r5,lr}
	MOV     R1, #1
	MOV     R0, #0x16
	BL      call_sub_514380F8
	MOV     R1, #1
	MOV     R0, #0x16
	BL      call_sub_51438078
	MOV     R1, #1
	MOV     R0, #0x16
	BL      call_sub_514380F8
	MOV     R1, #1
	MOV     R0, #0xB0 // '¦'
	BL      call_sub_514380F8
	MOV     R1, #1
	MOV     R0, #0xB0 // '¦'
	BL      call_sub_51438078
	MOV     R1, #1
	MOV     R0, #0xB0 // '¦'
	BL      call_sub_514380F8
	MOV     R1, #2
	MOV     R0, #0x69 // 'i'
	BL      call_sub_514381C4
	MOV     R1, #0
	MOV     R0, #0x69 // 'i'
	BL      call_sub_51438078
	ldr     r0, var_adr_51403204
	ldr	r0, [r0]
	ldr     r1, var_adr_51403208
	ldr     r1, [r1]
	cmp     R0, R1
	BEQ     loc_51403000

	add     r1, r0, #0
	ldr     r0, var_adr_51403208
	ldr	r0, [r0]
	ldr     r2, var_adr_5140320c
	ldr	r2, [r2]
	BL      sub_5142FD38	// okay

loc_51403000:
	ldr     r2, var_adr_51403210 // =0x207F9C
	ldr	r2, [r2]
	ldr     r0, var_adr_51403214 // =0x51446DA0 ???
	ldr	r0, [r0]
	mov     r1, #0

	ldr	r3,_oldstart
	mov	pc, r3

	BL      real_sub_5142fd5c
	BL      call_sub_514152F8
//	BL      load_0x5A0B0004_to_R0
	LDR     R0, var_51415448	// =0x5A0B0004

	MOV     R4, R0
	BL      call_sub_514029B0
	STR     R0, [R4,#0x30]
	BL      call_sub_51401C3C
	LDR     R1, [R4,#0x30]
//	ADR     R0, aBoothwcheckD__ // "BootHWCheck: %d...\n"
//	BL      SimpleDebugPrint
	MOV     R0, #0x69 // 'i'
	BL      call_sub_51438160
	CMP     R0, #0
	BEQ     loc_51403064

	LDR     R0, [R4,#0x30]
	CMP     R0, #2
	BCC     loc_51403064

	MOV     R1, SP
	MOV     R0, #0xF
	BL      call_sub_51419D0C
//	ADR     R0, aNoBattery  ; "NO battery\n"
//	BL      SimpleDebugPrint

loc_51403064:
//	BL      SelectBootingMode
	MOV     R0, #1
	BL      call_sub_5141AF20
	MOV     R0, #0x7D0
	BL      call_sub_51430F80
	BL      LCD_InitWin // 0x51401B28
	MOV     R0, #0
	STR     R0, [R4,#0x24]
	ldr	r0, var_51402258 // =0x514449A8
	ldrb    r0, [r0]
	CMP     R0, #0x10
	BEQ     loc_514031B0

loc_514031B0:
	MOV     R1, #0
	MOV     R0, #2
	BL      I2C_something //0x5141AB40
	bl	Download_Mode_MSG
//	BL      sub_514131A0
//	B       loc_514030E8

//	MOV     R0, #8
//	B       sub_5141804C

//	BL      sub_514185F4
//	BL      Baseband_Init

_continue_with_start_qi:
	b	_continue_with_start_qi
//	ldr	pc, _start_oldboot
//	ldr	pc, _start_armboot

asc_spacer:
	.ascii	"--------------------------------"
	.byte	0

asc_jetdroid:
	.ascii	"   \t    JetDroid mode  \t      "
	.byte	0

Download_Mode_MSG: //0x514184B8
	STMFD   SP!, {R4,LR}
	MOV     R0, #0x7D0
	BL      call_sub_51430F80
	BL      call_sub_51417FA0
	MOV     R0, #0
	BL      call_sub_51417F24
	MOV     R3, #0
	MOV     R2, #0xF800
	MOV     R1, #4
	ADR     R0, asc_spacer // "--------------------------------"
	BL      LCD_printf	// 0x514182D4
	MOV     R3, #0
	MOV     R2, #0xF800
	MOV     R1, #5
	ADR     R0, asc_jetdroid // "   \t    JetDroid mode  \t      "
	BL      LCD_printf
	MOV     R3, #0
	MOV     R2, #0xF800
	MOV     R1, #8
	ADR     R0, asc_spacer  // "--------------------------------"
	BL      LCD_printf
	LDMFD   SP!, {R4,LR}

_wait_10s:
	mov	r0, #0x20000000			// approx 10 sec wait
_waitloop:
	subs	r0, r0, #1
	cmp	r0, #0
	bne	_waitloop
	bx	lr

_start_armboot:
	.word 	start_qi
_start_oldboot:
	.word 	0x51400000
