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
_pre_start_6:
	b	_pre_start_6
_pre_start_7:
	b	_pre_start_7

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
	ldr	r0, var_5140011c
	mvn	r1, #0	// 0x0
	str	r1, [r0]
	ldr	r0, var_51400120
	mvn	r1, #0	// 0x0
	str	r1, [r0]
	ldr	r0, var_51400124
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
	ldr	sp, var_51400128
	bic	r0, r0, #223	// 0xdf
	orr	r1, r0, #19	// 0x13
	msr	CPSR_fsxc, r1
	ldr	sp, var_5140012c
	mov	r8, #80	// 0x50
	ldr	r9, var_51400130
	ldmia	r9!, {r0, r1, r2, r3, r4, r5, r6, r7}
	stmia	r8!, {r0, r1, r2, r3, r4, r5, r6, r7}
	mov	r8, #0	// 0x0
	ldr	r9, var_51400134
	ldmia	r9!, {r0, r1, r2, r3, r4, r5, r6, r7}
	stmia	r8!, {r0, r1, r2, r3, r4, r5, r6, r7}
	b	_init2
_init1_end:
	b	_init1_end


/*
 *   Variables
 */
var_5140011c:	.word	0x71200014
var_51400120:	.word	0x71300014
var_51400124:	.word	0x7e004000
var_51400128:	.word	0x518fff00
var_5140012c:	.word	0x518ff900
var_51400130:	.word	0x514400d4
var_51400134:	.word	0x514400b4


/*
 *  51401000
 */

sub_5140146c:
	mov	r1, #0x7c000000
	ldr	r0, [r1, #2052]	
	orr	r0, r0, #2
	str	r0, [r1, #2052]	
ret_5140147c:
	bx	lr


sub_514014f4:
	ldr	r1, var_5140188c
	cmp	r0, #32	// 0x20
	mov	r2, #1
	bcs	_51401514
	ldr	r1, [r1]
	mov	r0, r2, lsl r0
	str	r0, [r1, #16]
ret_51401510:
	bx	lr
_51401514:
	ldr	r1, [r1, #4]
	sub	r0, r0, #32	// 0x20
	mov	r0, r2, lsl r0
	str	r0, [r1, #16]
	b	ret_51401510 
	ldr	r1, var_5140188c
	cmp	r0, #32	// 0x20
	mov	r2, #1
	bcs	_51401548 
	ldr	r1, [r1]
	mov	r0, r2, lsl r0
	str	r0, [r1, #20]
ret_51401544:
	bx	lr
_51401548:
	ldr	r1, [r1, #4]
	sub	r0, r0, #32	// 0x20
	mov	r0, r2, lsl r0
	str	r0, [r1, #20]
	b	ret_51401544	// 0x51401558


sub_51401578:
	ldr	r2, var_5140188c
	mov	r1, #0	// 0x0
	ldr	r0, [r2]
	str	r1, [r0, #256]
	mov	r1, #1	// 0x1
	str	r1, [r0, #260]
	mov	r1, #2	// 0x2
	str	r1, [r0, #264]
	mov	r1, #3	// 0x3
	str	r1, [r0, #268]
	mov	r1, #4	// 0x4
	str	r1, [r0, #272]
	mov	r1, #5	// 0x5
	str	r1, [r0, #276]
	mov	r1, #6	// 0x6
	str	r1, [r0, #280]
	mov	r1, #7	// 0x7
	str	r1, [r0, #284]
	mov	r1, #8	// 0x8
	str	r1, [r0, #288]
	mov	r1, #9	// 0x9
	str	r1, [r0, #292]
	mov	r1, #10	// 0xa
	str	r1, [r0, #296]
	mov	r1, #11	// 0xb
	str	r1, [r0, #300]
	mov	r1, #12	// 0xc
	str	r1, [r0, #304]
	mov	r1, #13	// 0xd
	str	r1, [r0, #308]
	mov	r1, #14	// 0xe
	str	r1, [r0, #312]
	mov	r1, #15	// 0xf
	str	r1, [r0, #316]
	mov	r1, #16	// 0x10
	str	r1, [r0, #320]
	mov	r1, #17	// 0x11
	str	r1, [r0, #324]
	mov	r1, #18	// 0x12
	str	r1, [r0, #328]
	mov	r1, #19	// 0x13
	str	r1, [r0, #332]
	mov	r1, #20	// 0x14
	str	r1, [r0, #336]
	mov	r1, #21	// 0x15
	str	r1, [r0, #340]
	mov	r1, #22	// 0x16
	str	r1, [r0, #344]
	mov	r1, #23	// 0x17
	str	r1, [r0, #348]
	mov	r1, #24	// 0x18
	str	r1, [r0, #352]
	mov	r1, #25	// 0x19
	str	r1, [r0, #356]
	mov	r1, #26	// 0x1a
	str	r1, [r0, #360]
	mov	r1, #27	// 0x1b
	str	r1, [r0, #364]
	mov	r1, #28	// 0x1c
	str	r1, [r0, #368]
	mov	r1, #29	// 0x1d
	str	r1, [r0, #372]
	mov	r1, #30	// 0x1e
	str	r1, [r0, #376]
	mov	r1, #31	// 0x1f
	str	r1, [r0, #380]
	ldr	r1, [r2, #4]
	mov	r0, #32	// 0x20
	str	r0, [r1, #256]
	mov	r0, #33	// 0x21
	str	r0, [r1, #260]
	mov	r0, #34	// 0x22
	str	r0, [r1, #264]
	mov	r0, #35	// 0x23
	str	r0, [r1, #268]
	mov	r0, #36	// 0x24
	str	r0, [r1, #272]
	mov	r0, #37	// 0x25
	str	r0, [r1, #276]
	mov	r0, #38	// 0x26
	str	r0, [r1, #280]
	mov	r0, #39	// 0x27
	str	r0, [r1, #284]
	mov	r0, #40	// 0x28
	str	r0, [r1, #288]
	mov	r0, #41	// 0x29
	str	r0, [r1, #292]
	mov	r0, #42	// 0x2a
	str	r0, [r1, #296]
	mov	r0, #43	// 0x2b
	str	r0, [r1, #300]
	mov	r0, #44	// 0x2c
	str	r0, [r1, #304]
	mov	r0, #45	// 0x2d
	str	r0, [r1, #308]
	mov	r0, #46	// 0x2e
	str	r0, [r1, #312]
	mov	r0, #47	// 0x2f
	str	r0, [r1, #316]
	mov	r0, #48	// 0x30
	str	r0, [r1, #320]
	mov	r0, #49	// 0x31
	str	r0, [r1, #324]
	mov	r0, #50	// 0x32
	str	r0, [r1, #328]
	mov	r0, #51	// 0x33
	str	r0, [r1, #332]
	mov	r0, #52	// 0x34
	str	r0, [r1, #336]
	mov	r0, #53	// 0x35
	str	r0, [r1, #340]
	mov	r0, #54	// 0x36
	str	r0, [r1, #344]
	mov	r0, #55	// 0x37
	str	r0, [r1, #348]
	mov	r0, #56	// 0x38
	str	r0, [r1, #352]
	mov	r0, #57	// 0x39
	str	r0, [r1, #356]
	mov	r0, #58	// 0x3a
	str	r0, [r1, #360]
	mov	r0, #59	// 0x3b
	str	r0, [r1, #364]
	mov	r0, #60	// 0x3c
	str	r0, [r1, #368]
	mov	r0, #61	// 0x3d
	str	r0, [r1, #372]
	mov	r0, #62	// 0x3e
	str	r0, [r1, #376]
	mov	r0, #63	// 0x3f
	str	r0, [r1, #380]
ret_51401784:
	bx	lr

sub_51401788:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r0, #0
	ldr	r1, var_51401890
	mov	r5, #0
_51401798:
	str	r5, [r1, r0, lsl #2]
	add	r0, r0, #1
	cmp	r0, #64	// 0x40
	blt	_51401798
	ldr	r4, var_5140188c 
	ldr	r0, var_51401894
	str	r0, [r4]
	add	r0, r0, #0x100000
	str	r0, [r4, #4]
	bl	sub_51433b64
	bl	sub_51433b84 
	bl	sub_51433ba4 
	ldr	r0, [r4]
	mvn	r1, #0	
	str	r1, [r0, #20]
	ldr	r2, [r4, #4]
	str	r1, [r2, #20]
	str	r1, [r0, #28]
	str	r1, [r2, #28]
	str	r5, [r0, #12]
	str	r5, [r2, #12]
	str	r5, [r0, #3840]
	str	r5, [r2, #3840]
	bl	51401578 
	bl	sub_51433b74
	mov	r0, #58	// 0x3a
	bl	sub_514014f4 
_51401804:
	ldmia	sp!, {r4, r5, r6, lr}
	mov	r0, #0
	b	sub_514014f4 	// 0x5140180c
 
sub_51401c3c:	stmdb	sp!, {r2, r3, r4, r5, r6, r7, r8, lr}
	bl	sub_51431168
	bl	sub_51401788
	bl	sub_51430594
	bl	sub_51438b94
	bl	sub_5140146c
	bl	sub_51403dc8
	bl	5141b088
	bl	5141a61c
	mov	r1, #1
	mov	r0, #175	// 0xaf
	bl	sub_51438078
	mov	r1, #0
	mov	r0, #175	// 0xaf
	bl	sub_514380f8
	mov	r0, #0	
	bl	51401a5c 
	mov	r0, #0	
	bl	514019f4
	mov	r0, #1	
	bl	5141ade0
_51401c90:
	add	r0, pc, #252	// 0xfc		// !!!!!
	bl	sub_51403564
	mov	r0, #24	// 0x18
	bl	5141b008
_51401ca0:
	add	r0, pc, #260	// 0x104	// !!!!!
	bl	sub_51403564
	mov	r1, #0
	mov	r0, #4
	bl	514362b4
	bl	sub_51431168
_51401cb8:
	add	r0, pc, #260	// 0x104	// !!!!!
	bl	sub_51403564
	ldr	r0, var_51401de8
	ldr	r0, [r0]
	ldr	r1, [r0, #2308]		// !!!!
_51401ccc:
	add	r0, pc, #280	// 0x118	// !!!!! 
	bl	sub_51403564
	mov	r0, #67	// 0x43
	bl	sub_514376ec
	mov	r4, r0
	mov	r0, #66	// 0x42
	bl	sub_514376ec
	mov	r5, r0
	mov	r0, #65	// 0x41
	bl	sub_514376ec
	mov	r6, r0
	mov	r0, #63	// 0x3f
	bl	sub_514376ec
	mov	r7, r0
	mov	r0, #4
	bl	sub_514376ec
	mov	r1, r0
_51401d10:
	add	r0, pc, #256	// 0x100	// !!!!!
	mov	r3, r6
	mov	r2, r7
	str	r4, [sp, #4]
	str	r5, [sp]
	bl	sub_51403564 
	bl	51401bd8
	cmp	r0, #0	
	bne	ret_51401d40
_51401d34:
	add	r0, pc, #284	// 0x11c	// !!!!!
	bl	sub_51403564
	bl	514018b8
ret_51401d40:
	ldmia	sp!, {r2, r3, r4, r5, r6, r7, r8, pc}	// 0x51401d40


/*
 *  51402000
 */

var_51402258:	.word	0x514449A8

/*
 *
 */

sub_514029b0:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r1, #0
	mov	r0, #161	// 0xa1
	bl	sub_51438078
	mov	r1, #0	
	mov	r0, #162	// 0xa2
	bl	sub_51438078 
	mov	r1, #0
	mov	r0, #186	// 0xba
	bl	sub_51438078
	mov	r0, #161	// 0xa1
	bl	sub_51438160
	mov	r4, r0
	mov	r0, #162	// 0xa2
	bl	sub_51438160
	mov	r5, r0
	mov	r0, #186	// 0xba
	bl	sub_51438160 
	orrs	r1, r4, r5
	bne	_51402a10
	cmp	r0, #1	
	bne	_51402a10
	mov	r0, #1	
ret_51402a0c:
	ldmia	sp!, {r4, r5, r6, pc}
_51402a10:
	cmp	r4, #0
	bne	_51402a30
	cmp	r5, #1	
	bne	_51402a30
	cmp	r0, #0	
	bne	_51402a30
	mov	r0, #2	
	b	ret_51402a0c
_51402a30:
	orrs	r1, r1, r0
	bne	_51402a40
	mov	r0, #3	
	b	ret_51402a0c
_51402a40:
	cmp	r4, #0
	bne	_51402a60
	cmp	r5, #1	
	bne	_51402a60
	cmp	r0, #1	
	bne	_51402a60
	mov	r0, #4	
	b	ret_51402a0c 
_51402a60:
	cmp	r4, #1
	bne	_51402a80
	cmp	r5, #0	
	bne	_51402a80
	cmp	r0, #0	
	bne	_51402a80
	mov	r0, #5	
	b	ret_51402a0c
_51402a80:
	cmp	r4, #1
	bne	_51402aa0
	cmp	r5, #0	
	bne	_51402aa0
	cmp	r0, #1	
 	bne	_51402aa0
	mov	r0, #6	
	b	ret_51402a0c
_51402aa0:
	cmp	r4, #1
	bne	_51402ac0
	cmp	r5, #1	
	bne	_51402ac0
	cmp	r0, #0	
	bne	_51402ac0
	mov	r0, #7	
	b	ret_51402a0c
_51402ac0:
	mov	r0, #0	
	b	ret_51402a0c



/*
 * INIT 2
 *
 * 51402f7c
 */

_init2:
	stmdb   sp!, {r3-r5,lr}
	MOV     R1, #1
	MOV     R0, #0x16
	BL      sub_514380f8
	MOV     R1, #1
	MOV     R0, #0x16
	BL      sub_51438078
	MOV     R1, #1
	MOV     R0, #0x16
	BL      sub_514380f8
	MOV     R1, #1
	MOV     R0, #0xB0 // '¦'
	BL      sub_514380f8
	MOV     R1, #1
	MOV     R0, #0xB0 // '¦'
	BL      sub_51438078
	MOV     R1, #1
	MOV     R0, #0xB0 // '¦'
	BL      sub_514380f8
	MOV     R1, #2
	MOV     R0, #0x69 // 'i'
	BL	sub_514381c4
	MOV	R1, #0
	MOV	R0, #0x69 // 'i'
	BL	sub_51438078
	ldr	r0, var_51403204
	ldr	r1, var_51403208
	cmp	R0, R1
	BEQ	loc_51403000

	add	r1, r0, #0
	ldr	r0, var_51403208
	ldr	r2, var_5140320c
	bl	sub_5142fd38	// okay

loc_51403000:
	ldr	r2, var_51403210 // =0x207F9C
	ldr	r0, var_51403214 // =0x51446DA0 ???
	mov	r1, #0
	bl	sub_5142fd5c

//	ldr	r4,_oldstart
//	mov	pc, r4

	bl	sub_514152f8
	bl	sub_51415374	// load_0x5A0B0004_to_R0
	mov	r4, r0
	bl	sub_514029b0
	str	r0, [R4,#0x30]
	BL      sub_51401c3c
	LDR     R1, [R4,#0x30]
//	ADR     R0, aBoothwcheckD__ // "BootHWCheck: %d...\n"
//	BL      SimpleDebugPrint
	MOV     R0, #0x69 // 'i'
	BL      sub_51438160
	CMP     R0, #0
	BEQ     loc_51403064

	LDR     R0, [R4,#0x30]
	CMP     R0, #2
	BCC     loc_51403064

	MOV     R1, SP
	MOV     R0, #0xF
	BL      sub_51419D0C
//	ADR     R0, aNoBattery  ; "NO battery\n"
//	BL      SimpleDebugPrint

loc_51403064:
//	BL      SelectBootingMode
	MOV     R0, #1
	BL      sub_5141AF20
	MOV     R0, #0x7D0
	BL      sub_51430f80
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

_oldstart:	.word	0x51403010 //0x51402FE0 //0x51402f7c // 0x51400000

/*
 *  
 */

var_51403204:	.word	0x51446da0
var_51403208:	.word	0x51446da0
var_5140320c:	.word	0x00000000
var_51403210:	.word	0x00207f9c
var_51403214:	.word	0x51446da0


sub_51403294:
	ldr	r2, var_51403a40 
_51403298:	
	ldr	r1, [r2]
	cmp	r1, #0
	beq	_514032b4 
	strb	r0, [r1]
	add	r0, r1, #1
	str	r0, [r2]
ret_514032b0:
	bx	lr
_514032b4:
	b	sub_51403eb8 
sub_514032b8:
	stmdb	sp!, {r4, lr}
	mov	r4, r0
	b	_514032dc
_514032c4:
	cmp	r0, #10	// 0xa
	bne	_514032d4
	mov	r0, #13	// 0xd
	bl	sub_51403eb8 
_514032d4:
	ldrb	r0, [r4], #1
	bl	sub_51403eb8 
_514032dc:
	ldrb	r0, [r4]
	cmp	r0, #0	
	bne	_514032c4 
ret_514032e8:
	ldmia	sp!, {r4, pc}
sub_514032ec:
	stmdb	sp!, {r4, lr}
	cmp	r0, #10		// 0xa
	bcc	_5140330c
	mov	r1, #10		// 0xa
	bl	sub_5143fee8
	mov	r4, r1
	bl	sub_514032ec
	mov	r0, r4
_5140330c:
	add	r0, r0, #48	// 0x30
	ldmia	sp!, {r4, lr}
	and	r0, r0, #255	// 0xff
	b	sub_51403294
sub_5140331c:
	stmdb	sp!, {r4, lr}
	mov	r4, r0
	cmp	r1, #0	// 0x0
	beq	_51403330 
	sub	r1, r1, #1	// 0x1
_51403330:
	bic	r0, r4, #15	// 0xf
	orrs	r0, r0, r1
	beq	_51403348 
	mov	r0, r4, lsr #4
	bl	sub_5140331c
	and	r4, r4, #15	// 0xf
_51403348:
	cmp	r4, #10	// 0xa
	bcs	_51403360 
	add	r0, r4, #48	// 0x30
	ldmia	sp!, {r4, lr}
	and	r0, r0, #255	// 0xff
	b	sub_51403294 
_51403360:
	add	r0, r4, #55	// 0x37
	ldmia	sp!, {r4, lr}
	and	r0, r0, #255	// 0xff
	b	sub_51403294 	// 0x5140336c

sub_51403564:
	stmdb	sp!, {r0, r1, r2, r3}
	stmdb	sp!, {r3, r4, r5, lr}
	add	r0, sp, #20	// 0x14
	str	r0, [sp]
	b	_51403730	// 0x51403574

_51403578:
	add	r0, r0, #1
	str	r0, [sp, #16]
	cmp	r4, #10	// 0xa
	beq	_51403720 
	cmp	r4, #13	// 0xd
	beq	_51403708 
	cmp	r4, #37	// 0x25
	bne	_51403728 
	ldrb	r1, [r0], #1
	str	r0, [sp, #16]
	cmp	r1, #99	// 0x63
	beq	_514036dc 
	bgt	_514035ec 
	cmp	r1, #37	// 0x25
	beq	_514036d0 
	cmp	r1, #66	// 0x42
	beq	_5140362c 
	cmp	r1, #72	// 0x48
	beq	_5140364c 
	cmp	r1, #88	// 0x58
	bne	_514036fc 
	ldr	r0, [sp]
	ldr	r1, [sp]
	ldr	r0, [r0]
	add	r1, r1, #4	// 0x4
	str	r1, [sp]
	mov	r1, #8	// 0x8
	bl	5140331c 
	b	_51403730 
_514035ec:
	cmp	r1, #100	// 0x64
	beq	_5140366c 
	cmp	r1, #115	// 0x73
	beq	_514036b4
	cmp	r1, #117	// 0x75
	beq	_51403698
	cmp	r1, #120	// 0x78
	bne	_514036fc
	ldr	r0, [sp]
	ldr	r1, [sp]
	ldr	r0, [r0]
	add	r1, r1, #4	// 0x4
	str	r1, [sp]
	mov	r1, #0	// 0x0
	bl	5140331c
	b	_51403730
_5140362c:
	ldr	r0, [sp]
	ldr	r1, [sp]
	ldr	r0, [r0]
	add	r1, r1, #4
	str	r1, [sp]
	mov	r1, #2	
	bl	5140331c 
	b	_51403730
_5140364c:
	ldr	r0, [sp]
	ldr	r1, [sp]
	ldr	r0, [r0]
	add	r1, r1, #4	// 0x4
	str	r1, [sp]
	mov	r1, #4	// 0x4
	bl	5140331c 
	b	_51403730
_5140366c:
	ldr	r0, [sp]
	ldr	r4, [r0], #4
	str	r0, [sp]
	cmp	r4, #0	
	bge	_5140368c
	mov	r0, #45	// 0x2d
	bl	51403294 
	rsb	r4, r4, #0
_5140368c:
	mov	r0, r4
	bl	514032ec
	b	_51403730
_51403698:
	ldr	r0, [sp]
	ldr	r1, [sp]
	ldr	r0, [r0]
	add	r1, r1, #4
	str	r1, [sp]
	bl	514032ec
	b	_51403730
_514036b4:
	ldr	r0, [sp]
	ldr	r1, [sp]
	ldr	r0, [r0]
	add	r1, r1, #4
	str	r1, [sp]
	bl	514032b8 
	b	_51403730 
_514036d0:
	mov	r0, #37	// 0x25
	bl	51403294
	b	_51403730
_514036dc:
	ldr	r0, [sp]
	ldr	r1, [sp]
	ldr	r0, [r0]
	add	r1, r1, #4	// 0x4
	str	r1, [sp]
	and	r0, r0, #255	// 0xff
	bl	51403294 
	b	_51403730 
_514036fc:
	mov	r0, #32	// 0x20
	bl	51403294
	b	_51403730 
_51403708:
	ldrb	r1, [r0]
	cmp	r1, #10	// 0xa
	bne	_5140371c 
	add	r0, r0, #1	// 0x1
	str	r0, [sp, #16]
_5140371c:
	mov	r4, #10	// 0xa
_51403720:
	mov	r0, #13	// 0xd
	bl	51403294
_51403728:
	mov	r0, r4
	bl	51403294	// 0x5140372c

_51403730:	ldr	r0, [sp, #16]
	ldrb	r4, [r0]
	cmp	r4, #0
	bne	_51403578
	ldmia	sp!, {r3, r4, r5}
ret_51403744:
	ldr	pc, [sp], #20


var_51403c70:	.word	0x514449bc
//var_51403c74:	.word	0x444c4e4f
//var_51403c78:	.word	0x6b68435f
//var_51403c7c:	.word	0x74696e49
//var_51403c80:	.word	0x42646142
//var_51403c84:	.word	0x203a6b6c
//var_51403c88:	.word	0x20646162
//var_51403c8c:	.word	0x636f6c62
//var_51403c90:	.word	0x3028206b
//var_51403c94:	.word	0x29782578
//var_51403c98:	.word	0x000a0d2e
//var_51403c9c:	.word	0x51454810
//var_51403ca0:	.word	0x65520a0d
//var_51403ca4:	.word	0x6e696461
//var_51403ca8:	.word	0x61662067
//var_51403cac:	.word	0x64656c69
//var_51403cb0:	.word	0x00000a0d
//var_51403cb4:	.word	0x3d3d3d0a
//var_51403cb8:	.word	0x3d3d3d3d
//var_51403cbc:	.word	0x3d3d3d3d
//var_51403cc0:	.word	0x3d3d3d3d
//var_51403cc4:	.word	0x3d3d3d3d
//var_51403cc8:	.word	0x3d3d3d3d
//var_51403ccc:	.word	0x3d3d3d3d
//var_51403cd0:	.word	0x3d3d3d3d
//var_51403cd4:	.word	0x000a3d3d
//var_51403cd8:	.word	0x6f42200a
//var_51403cdc:	.word	0x6544746f
//var_51403ce0:	.word	0x42677562
//var_51403ce4:	.word	0x4e666675
//var_51403ce8:	.word	0x57646e61
//var_51403cec:	.word	0x65746972
//var_51403cf0:	.word	0x00000a20
//var_51403cf4:	.word	0xb007a61c
//var_51403cf8:	.word	0x0001ff00
//var_51403cfc:	.word	0x51474810
//var_51403d00:	.word	0x444c4e4f
//var_51403d04:	.word	0x6172455f
//var_51403d08:	.word	0x203a6573
//var_51403d0c:	.word	0x6c696166
//var_51403d10:	.word	0x74206465
//var_51403d14:	.word	0x7265206f
//var_51403d18:	.word	0x20657361
//var_51403d1c:	.word	0x636f6c62
//var_51403d20:	.word	0x3028206b
//var_51403d24:	.word	0x29782578
//var_51403d28:	.word	0x000a0d2e
//var_51403d2c:	.word	0x444c4e4f
//var_51403d30:	.word	0x6972575f
//var_51403d34:	.word	0x203a6574
//var_51403d38:	.word	0x6c696166
//var_51403d3c:	.word	0x74206465
//var_51403d40:	.word	0x7277206f
//var_51403d44:	.word	0x20657469
//var_51403d48:	.word	0x636f6c62
//var_51403d4c:	.word	0x3028206b
//var_51403d50:	.word	0x29782578
//var_51403d54:	.word	0x000a0d2e

sub_51403d58:	missing

sub_51403dc8:
	fstmdbd	sp!, {d8}
	ldr	r0, var_51403c70
	ldr	r1, [r0]
	cmp	r1, #0	
	bne	_51403de4
	ldr	r1, var_51403f08 
	str	r1, [r0]
_51403de4:
	ldr	r1, [r0, #4]
	cmp	r1, #0	
	bne	_51403df8 
	ldr	r1, var_51403f0c 
	str	r1, [r0, #4]
_51403df8:
	ldr	r1, [r0, #8]
	cmp	r1, #0	;
	bne	_51403e0c 
	ldr	r1, var_51403f10 
	str	r1, [r0, #8]
_51403e0c:
	mov	r1, r0
	ldr	r0, [r0, #8]
	ldr	r2, [r0, #52]
	orr	r2, r2, #8
	str	r2, [r0, #52]
	ldr	r2, [r0, #56]
	orr	r2, r2, #32	// 0x20
	str	r2, [r0, #56]
	ldr	r0, [r1, #4]
	ldr	r2, [r0, #32]
	bic	r2, r2, #255	// 0xff
	orr	r2, r2, #34	// 0x22
	str	r2, [r0, #32]
	ldr	r2, [r0, #40]
	bic	r2, r2, #15	// 0xf
	orr	r2, r2, #1	
	str	r2, [r0, #40]
	ldr	r0, [r1]
	mov	r2, #3	
	str	r2, [r0]
	ldr	r1, var_51403f14
	str	r1, [r0, #4]
	mov	r1, #0	
	str	r1, [r0, #8]
	str	r1, [r0, #12]
	flds	s0, [pc, #160]
	ftosizs	s16, s0
	flds	s2, [pc, #156]
	fmrs	r1, s16
	fmsr	s1, r1
	fsitos	s1, s1
	fsubs	s1, s0, s1
	fmuls	s1, s1, s2
	ftouizs	s16, s1
	fmrs	r1, s16
	ftouizs	s16, s0
	fmrs	r2, s16
	str	r2, [r0, #40]
	ldr	r2, var_51403f20
	ldr	r1, [r2, r1, lsl #2]
	str	r1, [r0, #44]
	fldmiad	sp!, {d8}
_51403eb4:
	b	51403a58

sub_51403eb8:
	stmdb	sp!, {r4, lr}
	mov	r4, r0
	mov	r0, r4
	bl	sub_51403d58
	ldr	r0, var_51403c70
	ldr	r0, [r0]
_51403ed0:
	ldr	r1, [r0, #16]
	tst	r1, #2	
	beq	_51403ed0 
	str	r4, [r0, #32]
ret_51403ee0:
	ldmia	sp!, {r4, pc}


var_51403f08:	.word	0x7f005800
var_51403f0c:	.word	0x7f008000
var_51403f10:	.word	0x7e00f000
var_51403f14:	.word	0x00000305
//var_51403f18:	.word	0x41885072
//var_51403f1c:	.word	0x41800000
var_51403f20:	.word	0x51440244
//_51403f24:	bx	lr
//_51403f28:	bx	lr


/*
 *  51415000
 */

sub_514152f8:	
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r0, #1
	ldr	r4, var_5141543c
	ldr	r5, var_51415440 
	ldr	r1, [r4]
	cmp	r1, r5
	beq	_51415318
	mov	r0, #0
_51415318:
	ldr	r1, [r4, #4]
	ldr	r6, var_51415444 
	cmp	r1, r6
	beq	_5141532c
	mov	r0, #0
_5141532c:
	cmp	r0, #0
	bne	_51415348
	ldr	r0, var_5141543c
	mov	r1, #60	// 0x3c
	bl	sub_5143f124
	str	r5, [r4]
	str	r6, [r4, #4]
_51415348:
	ldmia	sp!, {r4, r5, r6, pc}


sub_51415374:
	ldr	r0, var_51415448
	bx	lr	// 0x51415378

/* 
 *  51415000
 */

var_5141543c:	.word	0x5a0b0000
var_51415440:	.word	0xb0078aed
var_51415444:	.word	0xb00717e3
var_51415448:	.word	0x5a0b0004


/*
 *   51418000
 */

asc_spacer:
	.ascii	"--------------------------------"
	.byte	0

asc_jetdroid:
	.ascii	"   \t    JetDroid mode  \t      "
	.byte	0

Download_Mode_MSG: //0x514184B8
	STMFD   SP!, {R4,LR}
	MOV     R0, #0x7D0
	BL      sub_51430f80
	BL      sub_51417fa0
	MOV     R0, #0
	BL      sub_51417f24
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


/* 
 *  5142F000
 */

sub_5142fd38:
	mov     r3, #0
	mov     ip, r2,lsr#2
_5142fd40:
	cmp     r3, ip
	bcs     ret_5142fd58
	ldr     r2, [r1,r3,lsl#2]
	str     r2, [r0,r3,lsl#2]
	add     r3, r3, #1
	b       _5142fd40
ret_5142fd58: 
	bx      lr


sub_5142fd5c:	
	mov	r3, #0
	mov	r2, r2, lsr #2
_5142fd64:
	cmp	r3, r2
	bcs	ret_5142fd78 
	str	r1, [r0, r3, lsl #2]
	add	r3, r3, #1
	b	_5142fd64 
ret_5142fd78:
	bx	lr


/*
 *  51430000
 */

var_51430314:	.word	0x516491b0

sub_51430594:
	mov	r0, #0	
	ldr	r2, var_51430314
	mov	r1, #0	
_514305a0:
	add	r3, r0, r0, lsl #1
	strb	r1, [r2, r3, lsl #2]
	add	r0, r0, #1	
	cmp	r0, #6	
	blt	_514305a0
ret_514305b4:
	bx	lr



/*
 *  51431000
 */
 
sub_51431168:
	ldr	r0, var_514311a4
	mov	r3, #0
	str	r3, [r0]
	mov	r0, #0
	ldr	r2, var_514311a0
	mvn	r1, #0
_51431180:
	str	r1, [r2, r0, lsl #3]
	add	ip, r2, r0, lsl #3
	str	r3, [ip, #4]
	add	r0, r0, #1
	cmp	r0, #8
	bcc	_51431180
	mov	r0, #0	// 0x0
	b	_514310b8

var_514311a0:	.word	0x516491f8
var_514311a4:	.word	0x51446140
var_514311a8:	.word	0x7f006000

//sub_514311ac:	.word	0xe92d4ff0 	//stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
//_514311b0:	.word	0xe59f280c 	//ldr	r2, var_514319c4
//_514311b4:	.word	0xe7922200 	//ldr	r2, [r2, r0, lsl #4]

_514311b8:
	cmp	r2, #0x20000000
	bne	_514311c8
	ldr	r2, var_514319c8
	b	_514311dc
_514311c8:
	cmp	r2, #0x28000000
	bne	_514311d8
	ldr	r2, var_514319cc
	b	_514311dc
_514311d8:
	mov	r2, #0
_514311dc:
	ldrh	r1, [r1]
	and	r3, r1, #240	// 0xf0
	mov	fp, r3, lsr #4
	and	r1, r1, #8
	mov	lr, r1, lsr #3
	ldr	r3, var_514319d0
	cmp	fp, #5	// 0x5
	mov	r4, #63	// 0x3f
	mov	r8, #1	// 0x1
	mov	r9, #2	// 0x2
	mov	sl, #3	// 0x3
	mov	r5, #4	// 0x4
	mov	r6, #0	// 0x0
	mov	r7, #6	// 0x6
	mov	ip, #12	// 0xc
	add	r1, r3, r0, lsl #5
	addls	pc, pc, fp, lsl #2
_51431220:
	b	ret_5143126c
_51431224:
	b	_5143123c
_51431228:
	b	_51431270
_5143122c:
	b	_514312a4
_51431230:
	b	_514312d8
_51431234:
	b	_5143132c
_51431238:
	b	_51431380
_5143123c:
	mov	lr, #8
	str	lr, [r2, #208]
	str	r7, [r2, #224]
	str	r8, [r2, #240]
	str	r6, [r2, #352]
	str	ip, [r3, r0, lsl #5]
	str	r7, [r1, #4]
	str	r5, [r1, #8]
	mov	r0, #255	// 0xff
	str	r0, [r1, #16]
	str	r4, [r1, #20]
	str	r8, [r1, #24]
ret_5143126c:
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}	// return
	
_51431270:
	mov	lr, #9
	str	lr, [r2, #208]
	str	r7, [r2, #224]
	str	r8, [r2, #240]
	str	r6, [r2, #352]
	str	ip, [r3, r0, lsl #5]
	str	r7, [r1, #4]
	str	r5, [r1, #8]
	ldr	r0, var_514319d4
	str	r0, [r1, #16]
	str	r4, [r1, #20]
	str	r8, [r1, #24]
	b	ret_5143126c 	// return
_514312a4:
	mov	lr, #9
	str	lr, [r2, #208]
	str	r7, [r2, #224]
	str	r9, [r2, #240]
	str	r6, [r2, #352]
	str	ip, [r3, r0, lsl #5]
	str	r7, [r1, #4]
	str	r5, [r1, #8]
	ldr	r0, var_514319d4
	str	r0, [r1, #16]
	str	r4, [r1, #20]
	str	sl, [r1, #24]
	b	ret_5143126c 	// return
_514312d8:
	str	r7, [r2, #224]
	str	r9, [r2, #240]
	cmp	lr, #0	
	beq	_514312fc
	mov	lr, #9	
	str	lr, [r2, #208]
	str	r8, [r2, #352]
	str	r8, [r1, #28]
	b	_5143130c
_514312fc:
	mov	lr, #10	// 0xa
	str	lr, [r2, #208]
	str	r6, [r2, #352]
	str	r6, [r1, #28]
_5143130c:
	str	ip, [r3, r0, lsl #5]
	str	r7, [r1, #4]
	str	r5, [r1, #8]
	ldr	r0, var_514319d8>
	str	r0, [r1, #16]
	str	r4, [r1, #20]
	str	sl, [r1, #24]
	b	ret_5143126c
	str	r7, [r2, #224]
	str	r9, [r2, #240]
	cmp	lr, #0
	beq	_51431350 
	mov	lr, #10	// 0xa
	str	lr, [r2, #208]
	str	r8, [r2, #352]
	str	r8, [r1, #28]
	b	_51431360
_51431350:
	mov	lr, #11	// 0xb
	str	lr, [r2, #208]
	str	r6, [r2, #352]
	str	r6, [r1, #28]
_51431360:
	str	ip, [r3, r0, lsl #5]
	str	r7, [r1, #4]
	str	r5, [r1, #8]
	ldr	r0, var_514319dc
	str	r0, [r1, #16]
	str	r4, [r1, #20]
	str	sl, [r1, #24]
	b	ret_5143126c 
_51431380:
	str	r7, [r2, #224]
	str	r9, [r2, #240]
	cmp	lr, #0	
	beq	_514313a4
	mov	lr, #11	// 0xb
	str	lr, [r2, #208]
	str	r8, [r2, #352]
	str	r8, [r1, #28]
	b	_514313b0
_514313a4:
	str	ip, [r2, #208]
	str	r6, [r2, #352]
	str	r6, [r1, #28]
_514313b0:
	str	ip, [r3, r0, lsl #5]
	str	r7, [r1, #4]
	str	r5, [r1, #8]
	ldr	r0, var_514319e0 
	str	r0, [r1, #16]
	str	r4, [r1, #20]
	str	sl, [r1, #24]
	b	ret_5143126c	// 0x514313cc

var_514319c8:	.word	0x70100000
var_514319cc:	.word	0x70180000 
var_514319d0:	.word	0x51649338 
var_514319d4:	.word	0x000001ff 
var_514319d8:	.word	0x000003ff 
var_514319dc:	.word	0x000007ff 
var_514319e0:	.word	0x00000fff


/*
 *  51433000
 */ 

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

sub_51433b84:
	mrs	r0, CPSR
	orr	r0, r0, #0x80
	msr	CPSR_fsxc, r0
	bx	lr

sub_51433b94:
	mrs	r0, CPSR
	bic	r0, r0, #0x40
	msr	CPSR_fsxc, r0
	bx	lr
	
sub_51433ba4:
	mrs	r0, CPSR
	orr	r0, r0, #0x40
	msr	CPSR_fsxc, r0
	bx	lr

sub_51433bb4:
	mrc     p15, 0, R0,c1,c0
	orr     R0, R0, #0x800
	mcr     p15, 0, R0,c1,c0
	bx      lr

/*
 *  51437000
 */

sub_514376ec:
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	mov	r4, r0
	mov	r9, #0
	ldr	r8, var_514379ec 
	ldr	r7, var_514379f0
	ldr	r5, var_514373dc 
	cmp	r4, #67	// 0x43
	mov	r6, #1
	addls	pc, pc, r4, lsl #2
_51437710:
	b	51437f4c 		// JUMPTABLE !!!!!
	b	51437f4c 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437e9c 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437824 
	b	514378c0 
	b	5143795c 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437afc 
	b	51437b98 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437c34 
	b	51437f64 
	b	51437dd8 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437afc 
	b	51437b98 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437e1c 
	b	51437e1c 
	b	51437e1c 
	b	51437e1c 
	b	51437f64 
	b	51437f64 
	b	51437f64 
	b	51437f4c 
	b	51437ecc 
	b	51437edc 
	b	51437eec 
	b	51437efc 
	b	51437f0c 
	b	51437f2c 	// 0x51437820
 


/*
 *  51438000
 */

sub_51438078:	
	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
	mov	r8, r1
	mov	r4, #0	
	ldr	r1, var_51438340
	ldr	r2, [r1, r0, lsl #3]
	and	r5, r2, #15	// 0xf
	mov	r2, r2, lsl #24
	mov	r7, r2, lsr #28
	add	r0, r1, r0, lsl #3
	ldr	r6, [r0, #4]
	mul	r0, r7, r5
	cmp	r0, #32	// 0x20
	bcc	_514380c0
	mov	r1, r7
	mov	r0, #32	// 0x20
	bl	sub_5143fee8
	sub	r5, r5, r0
	add	r6, r6, #4	// 0x4
_514380c0:
	mov	r0, #0	// 0x0
_514380c4:
	cmp	r0, r7
	bcs	_514380dc
	mov	r1, r4, lsl #1
	orr	r4, r1, #1	// 0x1
	add	r0, r0, #1	// 0x1
	b	_514380c4
_514380dc:	
	mul	r0, r7, r5
	mov	r2, r4, lsl r0
	ldr	r1, [r6]
	bic	r1, r1, r2
	orr	r0, r1, r8, lsl r0
	str	r0, [r6]
	ldmia	sp!, {r4, r5, r6, r7, r8, pc}	// 0x514380f4


sub_514380f8:	
	stmdb	sp!, {r4, lr}
	mov	r2, #0
	ldr	r4, var_51438340 
	ldr	ip, [r4, r0, lsl #3]
	and	lr, ip, #15	// 0xf
	mov	r3, ip, lsl #22
	mov	r3, r3, lsr #30
	add	r0, r4, r0, lsl #3
	ldr	r0, [r0, #4]
	mov	r4, #60	// 0x3c
	and	ip, r4, ip, lsr #14
	add	ip, ip, r0
	mov	r0, #0	// 0x0
_5143812c:	
	cmp	r0, r3
	bcs	_51438144
	mov	r2, r2, lsl #1
	orr	r2, r2, #1	// 0x1
	add	r0, r0, #1	// 0x1
	b	_5143812c 
_51438144:	
	mul	r0, r3, lr
	mov	r3, r2, lsl r0
	ldr	r2, [ip]
	bic	r2, r2, r3
	orr	r0, r2, r1, lsl r0
	str	r0, [ip]
	ldmia	sp!, {r4, pc}	// 0x5143815c


sub_51438160:
	str	lr, [sp, #-4]!
	mov	r1, #0	// 0x0
	ldr	lr, var_51438340
	ldr	ip, [lr, r0, lsl #3]
	and	r3, ip, #15	// 0xf
	mov	r2, ip, lsl #22
	mov	r2, r2, lsr #30
	add	r0, lr, r0, lsl #3
	ldr	r0, [r0, #4]
	mov	lr, #60	// 0x3c
	and	ip, lr, ip, lsr #14
	add	ip, ip, r0
	mov	r0, #0
_51438194:	
	cmp	r0, r2
	bcs	_514381ac
	mov	r1, r1, lsl #1
	orr	r1, r1, #1
	add	r0, r0, #1
´	b	_51438194
_514381ac:
	mul	r0, r2, r3
	mov	r1, r1, lsl r0
	ldr	r2, [ip]
	and	r1, r2, r1
	mov	r0, r1, lsr r0
	ldr	pc, [sp], #4 	// 0x514381c0


sub_514381c4:
	stmdb	sp!, {r4, lr}
	mov	r2, #0
	ldr	r4, var_51438340
	ldr	ip, [r4, r0, lsl #3]
	and	lr, ip, #15	// 0xf
	mov	r3, ip, lsl #20
	mov	r3, r3, lsr #30
	add	r0, r4, r0, lsl #3
	ldr	r0, [r0, #4]
	mov	r4, #60	// 0x3c
	and	ip, r4, ip, lsr #18
	add	ip, ip, r0
	mov	r0, #0
_514381f8:
	cmp	r0, r3
	bcs	_51438210
	mov	r2, r2, lsl #1
	orr	r2, r2, #1
	add	r0, r0, #1
	b	_514381f8
_51438210:
	mul	r0, r3, lr
	mov	r3, r2, lsl r0
	ldr	r2, [ip]
	bic	r2, r2, r3
	orr	r0, r2, r1, lsl r0
	str	r0, [ip]
	ldmia	sp!, {r4, pc}	// 0x51438228


var_51438340:	.word 	0x514431e8
_51438344:	.word 	0x5c637273 
_51438348:	.word 	0x6f697067
_5143834c:	.word 	0x6972645f
_51438350:	.word 	0x5f726576
_51438354:	.word 	0x74726f70
_51438358:	.word 	0x0000632e 
_5143835c:	.word 	0x49504728
_51438360:	.word 	0x49505f4f
_51438364:	.word 	0x554e5f4e 
_51438368:	.word 	0x203c204d 
_5143836c:	.word 	0x4f495047 
_51438370:	.word 	0x305f4b5f 
_51438374:	.word 	0x7c7c2029 
_51438378:	.word 	0x50472820 
_5143837c:	.word 	0x505f4f49 
_51438380:	.word 	0x4e5f4e49 
_51438384:	.word 	0x3e204d55 
_51438388:	.word 	0x49504720 
_5143838c:	.word 	0x5f4e5f4f 
_51438390:	.word 	0x00293531
_51438394:	.word 	0x000001eb 

/*
 *
 */
_5143f0b8:
	subs	r2, r2, #32	// 0x20
	stmdb	sp!, {r4, lr}
	bcc	_5143f0dc
_5143f0c4:
	ldmcsia	r1!, {r3, r4, ip, lr}
	stmcsia	r0!, {r3, r4, ip, lr}
	ldmcsia	r1!, {r3, r4, ip, lr}
	stmcsia	r0!, {r3, r4, ip, lr}
	subcss	r2, r2, #32	// 0x20
	bcs	_5143f0c4
_5143f0dc:
	movs	ip, r2, lsl #28
	ldmcsia	r1!, {r3, r4, ip, lr}
	stmcsia	r0!, {r3, r4, ip, lr}
	ldmmiia	r1!, {r3, r4}
	stmmiia	r0!, {r3, r4}
	movs	ip, r2, lsl #30
	ldmia	sp!, {r4, lr}
	ldrcs	r3, [r1], #4
	strcs	r3, [r0], #4
	moveq	pc, lr
_5143f104:
	movs	r2, r2, lsl #31
	ldrmib	r2, [r1], #1
	ldrcsb	r3, [r1], #1
	ldrcsb	ip, [r1], #1
	strmib	r2, [r0], #1
	strcsb	r3, [r0], #1
	strcsb	ip, [r0], #1
	mov	pc, lr

sub_5143f124:
	mov	r2, #0
_5143f128:
	subs	r1, r1, #32	// 0x20
	stmdb	sp!, {lr}
	mov	lr, r2
	mov	r3, r2
	mov	ip, r2
_5143f13c:
	stmcsia	r0!, {r2, r3, ip, lr}
	stmcsia	r0!, {r2, r3, ip, lr}
	subcss	r1, r1, #32	// 0x20
	bcs	_5143f13c
	movs	r1, r1, lsl #28
	stmcsia	r0!, {r2, r3, ip, lr}
	stmmiia	r0!, {r2, r3}
	movs	r1, r1, lsl #2
	ldmia	sp!, {lr}
	strcs	r2, [r0], #4
	moveq	pc, lr
	strmib	r2, [r0], #1
	strmib	r2, [r0], #1
	tst	r1, #0x40000000
	strneb	r2, [r0], #1
	mov	pc, lr
_5143f17c:
	mov	r2, #0
	cmp	r1, #4	
	bcc	_5143f1ac
	ands	ip, r0, #3
	beq	_5143f128
	rsb	ip, ip, #4
	strb	r2, [r0], #1
	cmp	ip, #2
	strgeb	r2, [r0], #1
	sub	r1, r1, ip
	strgtb	r2, [r0], #1
	b	_5143f128 
_5143f1ac:
	movs	ip, r1, lsl #31
	strcsb	r2, [r0], #1
	strcsb	r2, [r0], #1
	strmib	r2, [r0], #1
	mov	pc, lr
	cmp	r2, #3
	bls	_5143f104
	ands	ip, r0, #3
	beq	_5143f1f4
	ldrb	r3, [r1], #1
	cmp	ip, #2
	add	r2, r2, ip
	ldrlsb	ip, [r1], #1
	strb	r3, [r0], #1
	ldrccb	r3, [r1], #1
	strlsb	ip, [r0], #1
	sub	r2, r2, #4
	strccb	r3, [r0], #1
_5143f1f4:
	ands	r3, r1, #3
	beq	_5143f0b8
_5143f1fc:
	subs	r2, r2, #8
	bcc	_5143f218
	ldr	r3, [r1], #4
	ldr	ip, [r1], #4
	str	r3, [r0], #4
	str	ip, [r0], #4
	b	_5143f1fc
_5143f218:
	adds	r2, r2, #4
	ldrpl	r3, [r1], #4
	strpl	r3, [r0], #4
	b	_5143f104	// 0x5143f224


_5143f488:
	mov	r1, r1, lsl #8
	rsbs	ip, r1, r0, lsr #16
	orr	r2, r2, #0xff000000
	orrcs	r2, r2, #0xff0000
	movcs	r1, r1, lsl #8
	rsbs	ip, r1, r0, lsr #12
	bcc	_5143f4e0
	rsbs	ip, r1, #0
	bcs	_5143f668
_5143f4ac:
	movcs	r1, r1, lsr #8
_5143f4b0:
	rsbs	ip, r1, r0, lsr #15
	subcs	r0, r0, r1, lsl #15
	adc	r2, r2, r2
	rsbs	ip, r1, r0, lsr #14
	subcs	r0, r0, r1, lsl #14
	adc	r2, r2, r2
	rsbs	ip, r1, r0, lsr #13
	subcs	r0, r0, r1, lsl #13
	adc	r2, r2, r2
	rsbs	ip, r1, r0, lsr #12
	subcs	r0, r0, r1, lsl #12
	adc	r2, r2, r2
_5143f4e0:
	rsbs	ip, r1, r0, lsr #11
	subcs	r0, r0, r1, lsl #11
	adc	r2, r2, r2
	rsbs	ip, r1, r0, lsr #10
	subcs	r0, r0, r1, lsl #10
	adc	r2, r2, r2
	rsbs	ip, r1, r0, lsr #9
	subcs	r0, r0, r1, lsl #9
	adc	r2, r2, r2
	rsbs	ip, r1, r0, lsr #8
	subcs	r0, r0, r1, lsl #8
	adcs	r2, r2, r2
	bcs	_5143f4ac
_5143f514:
	rsbs	ip, r1, r0, lsr #7
	subcs	r0, r0, r1, lsl #7
	adc	r2, r2, r2
	rsbs	ip, r1, r0, lsr #6
	subcs	r0, r0, r1, lsl #6
	adc	r2, r2, r2
	rsbs	ip, r1, r0, lsr #5
	subcs	r0, r0, r1, lsl #5
	adc	r2, r2, r2
	rsbs	ip, r1, r0, lsr #4
	subcs	r0, r0, r1, lsl #4
	adc	r2, r2, r2
_5143f544:
	rsbs	ip, r1, r0, lsr #3
	subcs	r0, r0, r1, lsl #3
	adc	r2, r2, r2
	rsbs	ip, r1, r0, lsr #2
	subcs	r0, r0, r1, lsl #2
	adcs	r2, r2, r2
	rsbs	ip, r1, r0, lsr #1
	subcs	r0, r0, r1, lsl #1
	adc	r2, r2, r2
	subs	r1, r0, r1
	movcc	r1, r0
	adc	r0, r2, r2
	bx	lr		// 0x5143f574

_5143f668:	
	b	_5143f820
_5143f66c:
	stmdb	sp!, {r7, r8, r9, sl, lr}
	mov	r9, r1
	stmdb	sp!, {r4, r5, r6}
	ldr	r1, [r0, #24]
	mov	r4, r0
	ldr	r8, [sp, #32]
	tst	r1, #32	// 0x20
_5143f688:
	ldrne	r0, [r4, #56]
	bicne	r1, r1, #16	// 0x10
	moveq	r0, #1
	mov	r5, r2
	strne	r1, [r4, #24]
	cmp	r0, r5
	subgt	r7, r0, r5
	ldr	r0, [r4, #52]
	movle	r7, #0
	add	r1, r7, r5
	add	r1, r1, r8
	sub	r0, r0, r1
	str	r0, [r4, #52]
	ldr	r0, [r4, #24]
	mov	sl, r3
	tst	r0, #16	// 0x10
	bne	_5143f6d4
	mov	r0, r4
	nop
_5143f6d4:
	mov	r6, #0
	b	_5143f700 
_5143f6dc:	
	ldr	r2, [r4, #28]
	ldr	r1, [r4, #36]
	ldrb	r0, [sl, r6]
	mov	lr, pc
	mov	pc, r2
_5143f700:
	cmp	r6, r8
	blt	_5143f6dc
	ldr	r0, [r4, #24]
	tst	r0, #16	// 0x10
	beq	_5143f740 
	mov	r0, r4
	nop	
	b	_5143f740 
_5143f720:
	ldr	r2, [r4, #28]
	ldr	r1, [r4, #36]
	mov	r0, #48	// 0x30
	mov	lr, pc
	mov	pc, r2
	ldr	r0, [r4, #60]
	add	r0, r0, #1
	str	r0, [r4, #60]
_5143f740:
	subs	r0, r7, #0
	sub	r7, r7, #1
	bgt	_5143f720
	b	_5143f770	// 0x5143f74c
_5143f750:
	ldr	r2, [r4, #28]
	ldr	r1, [r4, #36]
	ldrb	r0, [r9, r5]
	mov	lr, pc
	mov	pc, r2		// jump to ??
	ldr	r0, [r4, #60]
	add	r0, r0, #1
	str	r0, [r4, #60]
_5143f770:
	subs	r0, r5, #0
	sub	r5, r5, #1
	bgt	_5143f750
	mov	r0, r4
	nop
	ldmia	sp!, {r4, r5, r6, r7, r8}
	ldmia	sp!, {r9, sl, pc}	// 0x5143f788


_5143f820:
	mov	r0, #2
	mov	r1, #2
	b	sub_5143fd04		// 0x5143f828


sub_5143fd04:
	stmdb	sp!, {r4, lr}
	bl	sub_5143fd34
	cmp	r0, #0
	ldmeqia	sp!, {r4, pc}		// 0x5143fd10

sub_5143fd34:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r5, r1
	mov	r1, r0
	mov	r4, r0
	mvn	r0, #0
	nop
	cmn	r0, #1
	mov	r2, r0
	moveq	r0, r4
	moveq	r1, r5
	ldmeqia	sp!, {r4, r5, r6, lr}


sub_5143fee8:
	rsbs	ip, r1, r0, lsr #4
	mov	r2, #0
	bcc	_5143f544 
	rsbs	ip, r1, r0, lsr #8
	bcc	_5143f514
	rsbs	ip, r1, r0, lsr #12
	bcc	_5143f4e0
	rsbs	ip, r1, r0, lsr #16
	bcc	_5143f4b0
	b	_5143f488

/*
 *
 */

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
