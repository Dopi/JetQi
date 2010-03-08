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
	bl	sub_51401578 
	bl	sub_51433b74
	mov	r0, #58	// 0x3a
	bl	sub_514014f4 
_51401804:
	ldmia	sp!, {r4, r5, r6, lr}
	mov	r0, #0
	b	sub_514014f4 	// 0x5140180c
 


sub_514018b8:
	stmdb	sp!, {r4, lr}
	add	r0, pc, #504	// 0x1f8	// !!!! PC relative 0x514018bc + 0x1f8
	bl	sub_51403564
_514018c4:
	b	_514018c4



sub_514019f4:
	stmdb	sp!, {r4, lr}
	mov	r4, r0
	cmp	r4, #0
	beq	_51401a0c
	add	r1, pc, #200	// 0xc8	// !!!! PC relative !!!! 0x51401a004 + 0xc8
	b	_51401a10
_51401a0c:
	add	r1, pc, #196	// 0xc4	// !!!! PC relative !!!! 0x51401a00c + 0xc4
_51401a10:
	add	r0, pc, #196	// 0xc4	// !!!! PC relative !!!! 0x51401a010 + 0xc4
	bl	sub_51403564
	mov	r1, #1	
	mov	r0, #115	// 0x73
	bl	sub_51438078 
	cmp	r4, #0	
	beq	_51401a44
	mov	r1, #1	
	mov	r0, #115	// 0x73
	bl	sub_514380f8
	ldmia	sp!, {r4, lr}
	mov	r0, #1	
	b	sub_51415668 
_51401a44:
	mov	r1, #0
	mov	r0, #115	// 0x73
	bl	sub_514380f8
ret_51401a50:
	ldmia	sp!, {r4, lr}

sub_51401a54:
	mov	r0, #0
	b	sub_51415668

sub_51401a5c:
	stmdb	sp!, {r4, lr}
	mov	r4, r0
	cmp	r4, #0
	beq	_51401a74
	add	r1, pc, #96	// 0x60	// !!!! PC relative !!!! 0x51401a6c + 0x60
	b	_51401a78
_51401a74:
	add	r1, pc, #92	// 0x5c	// !!!! PC relative !!!! 0x51401a74 + 0x5c
_51401a78:
	add	r0, pc, #112	// 0x70	// !!!! PC relative !!!! 0x51401a78 + 0x70
	bl	sub_51403564 
	mov	r1, #1	
	mov	r0, #180	// 0xb4	// !!!! PC relative !!!! 0x51401a84 + 0xb4
	bl	sub_51438078 
	cmp	r4, #0
	beq	ret_51401aac
	add	r0, pc, #104	// 0x68	// !!!! PC relative !!!! 0x51401a94 + 0x68
	bl	sub_51403564
	ldmia	sp!, {r4, lr}
	mov	r1, #0
	mov	r0, #180	// 0xb4
	b	sub_514380f8 
ret_51401aac:
	ldmia	sp!, {r4, lr}



LCD_InitWin:			// sub_51401b28
	stmdb	sp!, {r4, lr}
	sub	sp, sp, #40	// 0x28
	bl	sub_51415374 
	ldr	r0, [r0, #48]
	cmp	r0, #2
	bcc	_51401b54
	mov	r1, #0
	mov	r0, #183	// 0xb7
	bl	sub_51438078
	mov	r0, #183	// 0xb7
	bl	51438160
_51401b54:
	mov	r1, #0
	mov	r0, #3
	bl	51438cec 
	ldr	r4, sub_51401d44
	bl	5143dd4c 
	mov	r0, #0	
	str	r0, [sp, #4]
	add	r0, sp, #24	// 0x18
	mov	r1, #0	
	mov	r3, #0	
	mov	r2, #0	
	str	r1, [sp, #20]
	stmia	r0, {r1, r2, r3}
	mov	r0, #6	
	str	r3, [sp, #16]
	mov	r3, #800	// vresolution
	str	r3, [sp]
	str	r1, [sp, #8]
	mov	r1, #480	// hresolution
	mov	r3, #480	// hresolution
	mov	r2, #800	// vresolution
	str	r4, [sp, #12]
	bl	51439b54 
	cmp	r0, #0	
	beq	_51401bc8 
	add	r0, pc, #392	// 0x188
	bl	sub_51403564
_51401bc0:
	add	sp, sp, #40	// 0x28
	ldmia	sp!, {r4, pc}
_51401bc8:
	mov	r1, #1
	mov	r0, #0
	bl	5143c5e8
	b	_51401bc0	// 0x51401bd4

sub_51401bd8:
	stmdb	sp!, {r4, lr}
	bl	sub_5142fc84 
	bl	sub_5143234c 
	cmp	r0, #0
	beq	_51401bfc 
	add	r0, pc, #376	// 0x178
	bl	sub_51403564 
	mov	r0, #0	
ret_51401bf8:
	ldmia	sp!, {r4, pc}
_51401bfc:
	mov	r0, #0
	bl	sub_514323f4
	cmp	r0, #0	
	beq	_51401c1c
	add	r0, pc, #364	// 0x16c
	bl	sub_51403564 
	mov	r0, #0	
	b	ret_51401bf8 
_51401c1c:
	mov	r0, #0
	bl	sub_51433ad4
	mov	r2, r0
	mov	r0, #0
	mov	r1, #0
	bl	sub_51431694 
	mov	r0, #1
	b	ret_51401bf8 	// 0x51401c38

sub_51401c3c:	stmdb	sp!, {r2, r3, r4, r5, r6, r7, r8, lr}
	bl	sub_51431168
	bl	sub_51401788
	bl	sub_51430594
	bl	sub_51438b94
	bl	sub_5140146c
	bl	sub_51403dc8
	bl	sub_5141b088
	bl	sub_5141a61c
	mov	r1, #1
	mov	r0, #175	// 0xaf
	bl	sub_51438078
	mov	r1, #0
	mov	r0, #175	// 0xaf
	bl	sub_514380f8
	mov	r0, #0	
	bl	sub_51401a5c 
	mov	r0, #0	
	bl	sub_514019f4
	mov	r0, #1	
	bl	sub_5141ade0
_51401c90:
	add	r0, pc, #252	// 0xfc		// !!!!!
	bl	sub_51403564
	mov	r0, #24	// 0x18
	bl	sub_5141b008
_51401ca0:
	add	r0, pc, #260	// 0x104	// !!!!!
	bl	sub_51403564
	mov	r1, #0
	mov	r0, #4
	bl	sub_514362b4
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
	bl	sub_51401bd8
	cmp	r0, #0	
	bne	ret_51401d40
_51401d34:
	add	r0, pc, #284	// 0x11c	// !!!!!
	bl	sub_51403564
	bl	sub_514018b8
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
	ldr	r1, var_51403208	/// correct????
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
	bl	sub_51438160
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
	bl	sub_5140331c 
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
	bl	sub_5140331c
	b	_51403730
_5140362c:
	ldr	r0, [sp]
	ldr	r1, [sp]
	ldr	r0, [r0]
	add	r1, r1, #4
	str	r1, [sp]
	mov	r1, #2	
	bl	sub_5140331c 
	b	_51403730
_5140364c:
	ldr	r0, [sp]
	ldr	r1, [sp]
	ldr	r0, [r0]
	add	r1, r1, #4	// 0x4
	str	r1, [sp]
	mov	r1, #4	// 0x4
	bl	sub_5140331c 
	b	_51403730
_5140366c:
	ldr	r0, [sp]
	ldr	r4, [r0], #4
	str	r0, [sp]
	cmp	r4, #0	
	bge	_5140368c
	mov	r0, #45	// 0x2d
	bl	sub_51403294 
	rsb	r4, r4, #0
_5140368c:
	mov	r0, r4
	bl	sub_514032ec
	b	_51403730
_51403698:
	ldr	r0, [sp]
	ldr	r1, [sp]
	ldr	r0, [r0]
	add	r1, r1, #4
	str	r1, [sp]
	bl	sub_514032ec
	b	_51403730
_514036b4:
	ldr	r0, [sp]
	ldr	r1, [sp]
	ldr	r0, [r0]
	add	r1, r1, #4
	str	r1, [sp]
	bl	sub_514032b8 
	b	_51403730 
_514036d0:
	mov	r0, #37	// 0x25
	bl	sub_51403294
	b	_51403730
_514036dc:
	ldr	r0, [sp]
	ldr	r1, [sp]
	ldr	r0, [r0]
	add	r1, r1, #4	// 0x4
	str	r1, [sp]
	and	r0, r0, #255	// 0xff
	bl	sub_51403294 
	b	_51403730 
_514036fc:
	mov	r0, #32	// 0x20
	bl	sub_51403294
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
	bl	sub_51403294
_51403728:
	mov	r0, r4
	bl	sub_51403294	// 0x5140372c

_51403730:	ldr	r0, [sp, #16]
	ldrb	r4, [r0]
	cmp	r4, #0
	bne	_51403578
	ldmia	sp!, {r3, r4, r5}
ret_51403744:
	ldr	pc, [sp], #20



sub_51403a58:
	bx	lr



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

sub_51403d58:
	mov	r1, r0
	ldr	r2, var_51403c70
	ldr	r0, [r2, #12]
	add	r3, r0, #1
	str	r3, [r2, #12]
	ldr	r2, var_51403cfc
	strb	r1, [r2, r0]
	bx	lr	// 0x51403d74


sub_51403dc8:
	.word	0xed2d8b02	//	fstmdbd	sp!, {d8}
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
	.word	0xed9f0a28	//	flds	s0, [pc, #160]
	.word	0xeebd8ac0	//	ftosizs	s16, s0
	.word	0xed9f1a27	//	flds	s2, [pc, #156]
	.word	0xee181a10	//	fmrs	r1, s16
	.word	0xee001a90	//	fmsr	s1, r1
	.word	0xeef80ae0	//	fsitos	s1, s1
	.word	0xee700a60	//	fsubs	s1, s0, s1
	.word	0xee600a81	//	fmuls	s1, s1, s2
	.word	0xeebc8ae0	//	ftouizs	s16, s1
	.word	0xee181a10	//	fmrs	r1, s16
	.word	0xeebc8ac0	//	ftouizs	s16, s0
	.word	0xee182a10	//	fmrs	r2, s16
	str	r2, [r0, #40]
	ldr	r2, var_51403f20
	ldr	r1, [r2, r1, lsl #2]
	str	r1, [r0, #44]
	.word	0xecbd8b02	//	fldmiad	sp!, {d8}
_51403eb4:
	b	sub_51403a58

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




sub_51415668:
	stmdb	sp!, {r4, lr}
	mov	r4, r0
	ldr	r3, var_51415900 
	mov	r2, #101	// 0x65
	mov	r1, #100	// 0x64
	mov	r0, #3	
	bl	sub_5142fd7c
	ldr	r0, var_51415904
	cmp	r4, #0	
	beq	_514156cc 
	mov	r4, r0
	bl	sub_51430f80
	mov	r3, #26	// 0x1a
	mov	r2, #2	// 0x2
	mov	r1, #74	// 0x4a
	mov	r0, #3	// 0x3
	bl	sub_5142fef8 
	mov	r0, r4
	bl	sub_51430f80
	mov	r3, #144	// 0x90
	mov	r2, #19	// 0x13
	mov	r1, #74	// 0x4a
	mov	r0, #3	// 0x3
	bl	sub_5142fef8
	b	ret_514156e4
_514156cc:
	bl	sub_51430f80
	mov	r3, #30	// 0x1e
	mov	r2, #2	// 0x2
	mov	r1, #74	// 0x4a
	mov	r0, #3	// 0x3
	bl	sub_5142fef8 
ret_514156e4:
	ldmia	sp!, {r4, lr}

_514156e8:
	mov	r0, #3	
	b	sub_5142fd80 	// 0x514156ec

sub_514153bc:
	ldr	r0, var_51415448
	ldr	r0, [r0, #48]
	bx	lr	// 0x514153c4

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
 *  51419000
 */

sub_51419978:
	stmdb	sp!, {r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	mov	r7, r0
	mov	r8, r1
	mov	r9, r2
	mov	sl, r3
	mov	r4, #0	
	ldr	r6, var_51419bd0 
_51419994:
	mov	r3, r6
	mov	r2, #141	// 0x8d
	mov	r1, #140	// 0x8c
	mov	r0, #0	
	bl	sub_5142fd7c 
	mov	r5, r0
	mov	r2, #0
	stmib	sp, {r2, sl}
	mov	r2, r8
	mov	r3, #0	
	mov	r1, r7
	mov	r0, #0	
	str	r9, [sp]
	bl	sub_5142ff1c 
	orr	r5, r0, r5
	mov	r0, #0	
	bl	sub_5142fd80 
	orr	r0, r0, r5
	cmp	r0, #0	
	bne	_514199ec
	mov	r0, #0	
ret_514199e8:
	ldmia	sp!, {r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, pc}
_514199ec:
	mov	r3, r4
	mov	r2, r8
	mov	r1, r7
	add	r0, pc, #468	// 0x1d4	// !!!! PC relative 0x514199f8 + 0x1d4
	bl	sub_51403564
	add	r4, r4, #1
	cmp	r4, #10	// 0xa
	blt	_51419994
	mov	r0, #1
	b	ret_514199e8	// 0x51419a10

sub_51419a14:
	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	mov	r7, r0
	mov	r8, r1
	mov	r9, r2
	mov	sl, r3
	mov	r4, #0
	ldr	r6, var_51419bd0
_51419a30:
	mov	r3, r6
	mov	r2, #141	// 0x8d
	mov	r1, #140	// 0x8c
	mov	r0, #0	
	bl	sub_5142fd7c 
	mov	r5, r0
	mov	r3, r9
	mov	r2, r8
	mov	r1, r7
	mov	r0, #0	
	str	sl, [sp]
	bl	sub_5142ff88
	orr	r5, r0, r5
	mov	r0, #0	
	bl	sub_5142fd80
	orr	r0, r0, r5
	cmp	r0, #0	
	bne	_51419a80 
	mov	r0, #0	
ret_51419a7c:
	ldmia	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, pc}
_51419a80:
	mov	r3, r4
	mov	r2, r8
	mov	r1, r7
	add	r0, pc, #376	// 0x178	// !!!!!
	bl	sub_51403564
	add	r4, r4, #1
	cmp	r4, #10	// 0xa
	blt	_51419a30 
	mov	r0, #1	
	b	ret_51419a7c	// 0x51419aa4




sub_51419c90:
	stmdb	sp!, {r3, r4, r5, r6, r7, lr}
	mov	r7, r1
	ldr	r6, var_5141aa8c
	add	r5, r0, r0, lsl #2
	mov	r3, #1	
	add	r4, r5, r6
	ldrb	r0, [r6, r5]
	ldrb	r1, [r4, #1]
	mov	r2, sp
	bl	sub_51419978 
	cmp	r0, #0	
	beq	_51419cc8
	mov	r0, #0	
ret_51419cc4:
	ldmia	sp!, {r3, r4, r5, r6, r7, pc}
_51419cc8:
	ldrb	r0, [r4, #3]
	ldrb	r1, [sp]
	and	r0, r0, r1
	ldrb	r1, [r4, #4]
	orr	r0, r0, r7, lsl r1
	str	r0, [sp]
	ldrb	r1, [r4, #1]
	ldrb	r0, [r6, r5]
	mov	r3, #1	
	mov	r2, sp
	bl	sub_51419a14 
	cmp	r0, #0
	beq	_51419d04
	mov	r0, #0	
	b	ret_51419cc4 
_51419d04:
	mov	r0, #1	
	b	ret_51419cc4 	// 0x51419d08




sub_51419d64:
	stmdb	sp!, {r4, lr}
	mov	ip, r1
	ldr	r3, var_5141aa90
	add	r1, r3, r0, lsl #1
	ldrb	r0, [r3, r0, lsl #1]
	mov	r3, r2
	ldrb	r1, [r1, #1]
	mov	r2, ip
	bl	sub_51419a14
	cmp	r0, #0
	beq	_51419d98
	mov	r0, #0
ret_51419d94:
	ldmia	sp!, {r4, pc}
_51419d98:
	mov	r0, #1
	b	ret_51419d94

/*
 *  5141A000
 */

sub_5141a61c:
	stmdb	sp!, {r3, lr}
	bl	sub_514153bc 
	cmp	r0, #6	
	bcs	_5141a648 
	mov	r1, #21	// 0x15
	mov	r0, #155	// 0x9b
	bl	sub_51419c90 
	mov	r1, #1	
	mov	r0, #152	// 0x98
	bl	sub_51419c90 
ret_5141a644:
	ldmia	sp!, {ip, pc}
_5141a648:
	mov	r0, #14	// 0xe
	str	r0, [sp]
	mov	r2, #1	
	mov	r1, sp
	mov	r0, #58	// 0x3a
	bl	sub_51419d64
	b	ret_5141a644	// 0x5141a660


sub_5141ade0:
	stmdb	sp!, {r3, r4, r5, lr}
	mov	r4, r0
	mov	r0, #2
	orr	r0, r0, r4, lsl #4
	str	r0, [sp]
	mov	r2, #1	
	mov	r1, sp
	mov	r0, #23	// 0x17
	bl	sub_51419d64 
	ldr	r5, var_5141aaa0
	ldrb	r1, [r5, #1]
	cmp	r1, #4	
	bne	_5141ae20 
	mov	r0, #150	// 0x96
	bl	sub_51430f80 
	b	_5141af18 
_5141ae20:
	cmp	r4, #0	
	beq	_5141ae6c 
	cmp	r4, #1	
	beq	_5141aeb0 
	cmp	r4, #2	
	beq	_5141ae40 
	cmp	r4, #3	
	bne	_5141af0c 
_5141ae40:
	cmp	r1, #0	
	beq	_5141aef4
	cmp	r1, #1	
	beq	_5141af00
	cmp	r1, #2	
	beq	_5141af18 
	cmp	r1, #3	
	beq	_5141af18 
	add	r0, pc, #332	// 0x14c	// !!!! PC relative !!!! 0x5141ae60 + 0x14c
	bl	sub_51403564
	b	_5141af18 
_5141ae6c:
	cmp	r1, #0	
	beq	_5141af18
	cmp	r1, #1	
	beq	_5141ae98 
	cmp	r1, #2	
	beq	_5141ae8c
	cmp	r1, #3
	bne	_5141aea4 
_5141ae8c:
	mov	r0, #100	// 0x64
	bl	sub_51430f80
	b	_5141af18 
_5141ae98:
	mov	r0, #60	// 0x3c
	bl	sub_51430f80
	b	_5141af18 
_5141aea4:
	add	r0, pc, #264	// 0x108	// !!!! PC relative !!!! 0x5141aea4 + 0x108
	bl	sub_51403564 
	b	_5141af18 
_5141aeb0:
	cmp	r1, #0
	beq	_5141aedc 
	cmp	r1, #1	
	beq	_5141af18 
	cmp	r1, #2	
	beq	_5141aed0 
	cmp	r1, #3
	bne	_5141aee8 
_5141aed0:
	mov	r0, #40	// 0x28
	bl	sub_51430f80 
	b	_5141af18 
_5141aedc:
	mov	r0, #60	// 0x3c
	bl	sub_51430f80 
	b	_5141af18 
_5141aee8:
	add	r0, pc, #196	// 0xc4		// !!!! PC relative !!!! 0x5141aee8 + 0xc4
	bl	sub_51403564 
	b	_5141af18 
_5141aef4:
	mov	r0, #100	// 0x64
	bl	sub_51430f80 
	b	_5141af18 
_5141af00:
	mov	r0, #40	// 0x28
	bl	sub_51430f80 
	b	_5141af18 
_5141af0c:
	mov	r1, r4
	add	r0, pc, #156	// 0x9c		// !!!! PC relative !!!! 0x5141af10 + 0x9c
	bl	sub_51403564 
_5141af18:
	strb	r4, [r5, #1]
	ldmia	sp!, {r3, r4, r5, pc}	// 0x5141af1c

 

/*
 *  5141B000
 */
sub_5141b008:
	stmdb	sp!, {r3, r4, r5, lr}
	mov	r4, r0
	str	r4, [sp]
	mov	r2, #1
	mov	r1, sp
	mov	r0, #17	// 0x11
	bl	sub_51419d64
	mov	r0, #1
	str	r0, [sp]
	mov	r2, #1
	mov	r1, sp
	mov	r0, #20	// 0x14
	bl	sub_51419d64 
	ldr	r5, var_5141aaa0
	ldrb	r0, [r5, #2]
	cmp	r0, #61	// 0x3d
	bne	_5141b058
	mov	r0, #150	// 0x96
	bl	sub_51430f80 
	b	_5141b080
_5141b058:
	cmp	r0, r4
	mov	r1, #12	// 0xc
	bcc	_5141b074 
	sub	r0, r0, r4
	mul	r0, r1, r0
	bl	sub_51430f80
	b	_5141b080 
_5141b074:
	sub	r0, r4, r0
	mul	r0, r1, r0
	bl	sub_51430f80 
_5141b080:
	strb	r4, [r5, #2]
	ldmia	sp!, {r3, r4, r5, pc}	// 0x5141b084

sub_5141b088:
	stmdb	sp!, {r3, r4, r5, lr}
	mov	r4, #15	// 0xf
	str	r4, [sp]
	mov	r2, #1	// 0x1
	mov	r1, sp
	mov	r0, #76	// 0x4c
	bl	sub_51419d64
	mov	r1, #1	// 0x1
	mov	r0, #40	// 0x28
	bl	sub_51419c90
	mov	r1, #45	// 0x2d
	mov	r0, #172	// 0xac
	bl	sub_51419c90 
	str	r4, [sp]
	mov	r2, #1	// 0x1
	mov	r1, sp
	mov	r0, #66	// 0x42
	bl	sub_51419d64 
	mov	r1, #45	// 0x2d
	mov	r0, #178	// 0xb2
	bl	sub_51419c90 
	mov	r1, #9	// 0x9
	mov	r0, #137	// 0x89
	bl	sub_51419c90 
	bl	sub_514153bc 
	cmp	r0, #4	// 0x4
	bcs	_5141b100 
	mov	r1, #7	// 0x7
	mov	r0, #158	// 0x9e
	bl	sub_51419c90 
_5141b100:
	mov	r0, #19	// 0x13
	str	r0, [sp]
	mov	r2, #1	// 0x1
	mov	r1, sp
	mov	r0, #63	// 0x3f
	bl	sub_51419d64 
	mov	r2, #1	// 0x1
	mov	r1, sp
	mov	r0, #64	// 0x40
	bl	sub_51419d64 
	bl	sub_514153bc 
	cmp	r0, #4	// 0x4
	bcs	_5141b140
	mov	r1, #7	// 0x7
	mov	r0, #180	// 0xb4
	bl	sub_51419c90 
_5141b140:
	mov	r1, #46	// 0x2e
	mov	r0, #131	// 0x83
	bl	sub_51419c90 
	mov	r1, #7	// 0x7
	mov	r0, #127	// 0x7f
	bl	sub_51419c90 
	mov	r1, #9	// 0x9
	mov	r0, #143	// 0x8f
	bl	sub_51419c90 
	str	r4, [sp]
	mov	r2, #1	// 0x1
	mov	r1, sp
	mov	r0, #52	// 0x34
	bl	sub_51419d64 
	mov	r1, #21	// 0x15
	mov	r0, #52	// 0x34
	bl	sub_51419c90 
	mov	r0, #6	// 0x6
	str	r0, [sp]
	mov	r2, #1	// 0x1
	mov	r1, sp
	mov	r0, #95	// 0x5f
	bl	sub_51419d64 
	ldr	r0, var_5141b1a8 
	bl	sub_51430f80
ret_5141b1a4:	
	ldmia	sp!, {r3, r4, r5, pc}

var_5141b1a8:	
	.word	0x00000bb8


/* 
 *  5142F000
 */
sub_5142fb28:
	mov	r1, #1
	str	r1, [r0]
sub_5142fb30:
	mov	r0, #1
	bx	lr
sub_5142fb38:
	mov	r0, #1
	bx	lr
sub_5142fb40:
	mov	r0, #1
	bx	lr
sub_5142fb48:
	mov	r0, #1
_5142fb4c:
	bx	lr
sub_5142fb50:
	bx	lr
_5142fb54:
	bx	lr
_5142fb58:
	bx	lr
_5142fb5c:
	bx	lr
_5142fb60:
	bx	lr
_5142fb64:
	bx	lr


sub_5142fbd8:
	bx	lr
sub_5142fbdc:
	mov	r0, #1
	bx	lr
sub_5142fbe4:
	cmppl	r4, ip, lsr #2
	cmppl	sp, r0, ror r9
	bx	lr	// 0x5142fbec



sub_5142fc84:
	ldr	r0, var_5142fd34
	mov	r1, #0x20000000
	str	r1, [r0]
	mvn	r1, #0	
	str	r1, [r0, #4]
	str	r1, [r0, #8]
	str	r1, [r0, #12]
	mov	r2, #2	
	strh	r2, [r0, #16]
	strh	r2, [r0, #18]
	mov	r3, #1	
	str	r3, [r0, #20]
	str	r3, [r0, #24]
	mov	r2, #0	
	str	r2, [r0, #28]
	str	r1, [r0, #32]
	str	r1, [r0, #36]
	str	r1, [r0, #40]
	str	r1, [r0, #44]
	strh	r2, [r0, #48]
	strh	r2, [r0, #50]
	str	r3, [r0, #52]
	str	r2, [r0, #56]
	str	r2, [r0, #60]
	bx	lr	// 0x5142fce4

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

sub_5142fd7c:
	b	sub_514300a8

sub_5142fd80:
	b	sub_514301e0 

sub_5142fd84:
	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	mov	r9, r2
	ldr	r7, [sp, #40]
	ldr	r6, [sp, #44]
	mov	r8, r1
	mov	fp, r0
	mov	sl, r3
	mov	r5, #0
	cmp	r7, #0
	beq	_5142fe38
	mov	r0, fp
	bl	sub_514305b8
	and	r1, r8, #254	// 0xfe
	mov	r0, fp
	bl	sub_51430d78 
	mov	r1, sp
	mov	r0, fp
	bl	sub_51430a78 
	ldrb	r0, [sp]
	cmp	r0, #0	
	beq	_5142fdec 
	mov	r1, r8
	add	r0, pc, #520	// 0x208
	bl	sub_51403564
	mvn	r5, #0	
	b	_5142fec0
_5142fdec:
	mov	r4, #0	
	b	_5142fe30
_5142fdf4:
	ldrb	r1, [r9, r4]
	mov	r0, fp
	bl	sub_51430d78
	mov	r1, sp
	mov	r0, fp
	bl	sub_51430a78 
	ldrb	r0, [sp]
	cmp	r0, #0	
	beq	_5142fe2c 
	mov	r1, r4
	add	r0, pc, #508	// 0x1fc
	bl	sub_51403564 
	mvn	r5, #0	
	b	_5142fec0 
_5142fe2c:
	add	r4, r4, #1
_5142fe30:
	cmp	r4, r7
	bcc	_5142fdf4 
_5142fe38:
	cmp	r6, #0	
	beq	_5142fec0 
	mov	r0, fp
	bl	sub_514305b8
	orr	r1, r8, #1
	mov	r0, fp
	bl	sub_51430d78 
	mov	r1, sp
	mov	r0, fp
	bl	sub_51430a78
	ldrb	r0, [sp]
	cmp	r0, #0	
	beq	_5142fe80 
	mov	r1, r8
	add	r0, pc, #472	// 0x1d8
	bl	sub_51403564
	mvn	r5, #0
	b	_5142fec0 
_5142fe80:
	mov	r4, #0	
	sub	r7, r6, #1	
	b	_5142feb8 
_5142fe8c:
	add	r1, sl, r4
	mov	r0, fp
	bl	sub_51430e00 
	cmp	r4, r7
	beq	_5142feac 
	mov	r0, fp
	bl	sub_51430b8c 
	b	_5142feb4 
_5142feac:
	mov	r0, fp
	bl	sub_51430c30 
_5142feb4:
	add	r4, r4, #1	
_5142feb8:
	cmp	r4, r6
	bcc	_5142fe8c 
_5142fec0:
	mov	r0, fp
	bl	sub_5143079c 
	mov	r0, r5
ret_5142fecc:
	ldmia	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, pc}




sub_5142fef8:
	stmdb	sp!, {r1, r2, r3, lr}
	strb	r2, [sp, #8]
	strb	r3, [sp, #9]
	mov	r3, #0	
	mov	r2, #2	
	strd	r2, [sp]
	add	r2, sp, #8	
	bl	sub_5142fd84 
ret_5142ff18:
	ldmia	sp!, {r2, r3, ip, pc}




sub_5142ff1c:
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	sub	sp, sp, #32	// 0x20
	mov	r6, r0
	mov	r5, r2
	ldr	r4, [sp, #68]
	ldr	sl, [sp, #72]
	ldr	r9, [sp, #64]
	mov	r8, r3
	mov	r7, r1
	cmp	r4, #16	// 0x10
	bls	_5142ff50 
	add	r0, pc, #308	// 0x134	// !!!! PC relative 0x5142ff48 + 0x134
	bl	sub_51403564
_5142ff50:
	strb	r5, [sp, #12]
	mov	r2, r4
	mov	r1, r8
	add	r0, sp, #13	// 0xd
	bl	sub_5143f1c0
	add	r2, r4, #1
	stmia	sp, {r2, sl}
	add	r2, sp, #12	// 0xc
	mov	r3, r9
	mov	r1, r7
	mov	r0, r6
	bl	sub_5142fd84
	add	sp, sp, #32	// 0x20
ret_5142ff84:
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}

sub_5142ff88:
	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
	sub	sp, sp, #32	// 0x20
	mov	r6, r0
	ldr	r4, [sp, #56]
	mov	r5, r2
	mov	r8, r3
	mov	r7, r1
	cmp	r4, #16	// 0x10
	bls	_5142ffb4
	add	r0, pc, #208	// 0xd0		// !!!! PC relative !!!!
	bl	sub_51403564
_5142ffb4:
	strb	r5, [sp, #12]
	mov	r2, r4
	mov	r1, r8
	add	r0, sp, #13	// 0xd
	bl	sub_5143f1c0
	mov	r3, #0	
	add	r2, r4, #1
	strd	r2, [sp]
	add	r2, sp, #12	// 0xc
	mov	r1, r7
	mov	r0, r6
	bl	sub_5142fd84
	add	sp, sp, #32	// 0x20
ret_5142ffe8:
	ldmia	sp!, {r4, r5, r6, r7, r8, pc}


/*
 *  51430000
 */

sub_514300a8:
	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
	.word	0xed2d8b02	//	fstmdbd	sp!, {d8}
	mov	r5, r0
	mov	r6, r1
	mov	r7, r2
	mov	r4, r3
	cmp	r5, #6	
	bcc	_514300d8 
	mov	r2, #67	// 0x43
	add	r1, pc, #520	// 0x208	// !!!! PC relative 0x514300cc + 0x208
	add	r0, pc, #536	// 0x218	// !!!! PC relative 0x514300d0 + 0x218
	bl	sub_51403564
_514300d8:
	ldr	r3, var_51430314
	add	r1, r5, r5, lsl #1
	add	r0, r3, #0	
	ldrb	r2, [r3, r1, lsl #2]
	add	r0, r0, r1, lsl #2
	cmp	r2, #0	
	beq	_51430150 
	ldrb	ip, [r0, #1]
	cmp	ip, r6
	bne	_5143013c 
	ldrb	ip, [r0, #2]
	cmp	ip, r7
	bne	_5143013c
	ldr	r0, [r0, #4]
	cmp	r0, r4
	bne	_5143013c
	add	r0, r2, #1
	and	r2, r0, #255	// 0xff
	strb	r2, [r3, r1, lsl #2]
	mov	r1, r5
	add	r0, pc, #488	// 0x1e8	// !!!! PC relative 0x51430128 + 0x1e8
	bl	sub_51403564
	mov	r0, #0
_51430134:
	.word	0xecbd8b02	//	fldmiad	sp!, {d8}
	ldmia	sp!, {r4, r5, r6, r7, r8, pc}
_5143013c:
	mov	r1, r5
	add	r0, pc, #512	// 0x200	// !!!! PC relative 0x51430140 + 0x200
	bl	sub_51403564
	mvn	r0, #0	
	b	_51430134
_51430150:
	mov	r2, #1
	strb	r2, [r3, r1, lsl #2]
	strb	r6, [r0, #1]
	strb	r7, [r0, #2]
	str	r4, [r0, #4]

	.word	0xee004a10	//	fmsr	s0, r4
	.word	0xeddf0a85 	//	flds	s1, [pc, #532]
	.word	0xeeb80a40 	//	fuitos	s0, s0
	.word	0xee800a80 	//	fdivs	s0, s1, s0
	.word	0xeddf0a83 	//	flds	s1, [pc, #524]
	.word	0xee200a20 	//	fmuls	s0, s0, s1
	.word	0xeddf0a82 	//	flds	s1, [pc, #520]
	.word	0xee200a20 	//	fmuls	s0, s0, s1
	.word	0xeebc8ac0 	//	ftouizs	s16, s0
	.word	0xee181a10 	//	fmrs	r1, s16

	str	r1, [r0, #8]
	mov	r1, #0
	mov	r0, r6
	bl	sub_514381c4
	mov	r1, #0
	mov	r0, r7
	bl	sub_514381c4
	mov	r1, #1
	mov	r0, r6
	bl	sub_514380f8
	mov	r1, #1
	mov	r0, r7
	bl	sub_514380f8
	mov	r1, #1
	mov	r0, r6
	bl	sub_51438078
	mov	r1, #1
	mov	r0, r7
	bl	sub_51438078
	mov	r0, #0	
	b	_51430134	// 0x514301dc

sub_514301e0:
	stmdb	sp!, {r4, lr}
	mov	r4, r0
	cmp	r4, #6
	bcc	_51430200
	mov	r2, #117	// 0x75
	add	r1, pc, #224	// 0xe0
	add	r0, pc, #240	// 0xf0
	bl	sub_51403564
_51430200:
	ldr	r2, var_51430314
	add	r0, r4, r4, lsl #1
	ldrb	r1, [r2, r0, lsl #2]
	cmp	r1, #0	
	bne	_51430228 
	mov	r1, r4
	add	r0, pc, #368	// 0x170	// !!!! PC relative !!!! 
	bl	sub_51403564 
	mvn	r0, #0
ret_51430224:
	ldmia	sp!, {r4, pc}
_51430228:
	sub	r1, r1, #1
	and	r1, r1, #255	// 0xff
	strb	r1, [r2, r0, lsl #2]
	cmp	r1, #0
	bne	_51430288
	add	r4, r2, r0, lsl #2
	mov	r1, #0
	ldrb	r0, [r4, #1]
	bl	sub_514381c4 
	ldrb	r0, [r4, #2]
	mov	r1, #0
	bl	sub_514381c4
	ldrb	r0, [r4, #1]
	mov	r1, #0
	bl	sub_51438078 
	ldrb	r0, [r4, #2]
	mov	r1, #0
	bl	sub_51438078 
	ldrb	r0, [r4, #1]
	mov	r1, #0
	bl	sub_514380f8 
	ldrb	r0, [r4, #2]
	mov	r1, #0
	bl	sub_514380f8 
_51430288:
	mov	r0, #0
	b	ret_51430224 // 0x5143028c

sub_51430290:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r4, r0
	mov	r5, r1
	cmp	r4, #6
	bcc	_514302b4
	mov	r2, #156	// 0x9c
	add	r1, pc, #44	// 0x2c	// !!!! PC relative !!!! 0x514302a8 + 0x2c
	add	r0, pc, #60	// 0x3c	// !!!! PC relative !!!! 0x514302ac + 0x3c
	bl	sub_51403564
_514302b4:
	ldr	r1, var_51430314
	add	r0, r4, r4, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0	
	bne	_514303ec
	mov	r1, r4
	add	r0, pc, #232	// 0xe8	// !!!! PC relative !!!! 0x514302cc + 0xe8
	bl	sub_51403564
	mvn	r0, #0
ret_514302d8:
	ldmia	sp!, {r4, r5, r6, pc}

var_514302dc:	.word	0x5c637273
var_514302e0:	.word	0x5f633269
var_514302e4:	.word	0x6f697067
var_514302e8:	.word	0x6e696c5f
var_514302ec:	.word	0x00632e65
var_514302f0:	.word	0x6e616863
var_514302f4:	.word	0x206c656e
var_514302f8:	.word	0x5f45203c
var_514302fc:	.word	0x5f433249
var_51430300:	.word	0x4f495047
var_51430304:	.word	0x4148435f
var_51430308:	.word	0x4c454e4e
var_5143030c:	.word	0x58414d5f
var_51430310:	.word	0x00000000
var_51430314:	.word	0x516491b0
var_51430318:	.word	0x3249495b
var_5143031c:	.word	0x50475f43
var_51430320:	.word	0x4c5f4f49
var_51430324:	.word	0x5f656e69
var_51430328:	.word	0x6e65704f
var_5143032c:	.word	0x6843205d
var_51430330:	.word	0x29642528
var_51430334:	.word	0x64644120
var_51430338:	.word	0x696c4320
var_5143033c:	.word	0x28746e65
var_51430340:	.word	0x20296425
var_51430344:	.word	0x0000000a
var_51430348:	.word	0x4332495b
var_5143034c:	.word	0x4950475f
var_51430350:	.word	0x694c5f4f
var_51430354:	.word	0x4f5f656e
var_51430358:	.word	0x5d6e6570
var_5143035c:	.word	0x65704f20
var_51430360:	.word	0x6146206e
var_51430364:	.word	0x2d206c69
var_51430368:	.word	0x726c4120
var_5143036c:	.word	0x79646165
var_51430370:	.word	0x65704f20
var_51430374:	.word	0x3a64656e
var_51430378:	.word	0x28684320
var_5143037c:	.word	0x20296425
var_51430380:	.word	0x0000000a
var_51430384:	.word	0x3f800000
var_51430388:	.word	0x49742400
var_5143038c:	.word	0x3f000000
var_51430390:	.word	0x4332495b
var_51430394:	.word	0x4950475f
var_51430398:	.word	0x694c5f4f
var_5143039c:	.word	0x435f656e
var_514303a0:	.word	0x65736f6c
var_514303a4:	.word	0x6f4e205d
var_514303a8:	.word	0x704f2074
var_514303ac:	.word	0x64656e65
var_514303b0:	.word	0x6843203a
var_514303b4:	.word	0x29642528
var_514303b8:	.word	0x00000a20
var_514303bc:	.word	0x4332495b
var_514303c0:	.word	0x4950475f
var_514303c4:	.word	0x694c5f4f
var_514303c8:	.word	0x435f656e
var_514303cc:	.word	0x69666e6f
var_514303d0:	.word	0x41445367
var_514303d4:	.word	0x6f4e205d
var_514303d8:	.word	0x704f2074
var_514303dc:	.word	0x64656e65
var_514303e0:	.word	0x6843203a
var_514303e4:	.word	0x29642528
var_514303e8:	.word	0x00000a20

_514303ec:
	add	r0, r1, r0, lsl #2
	mov	r1, r5
	ldrb	r0, [r0, #2]
	bl	sub_51438078
	mov	r0, #0
	b	ret_514302d8	// 0x51430400

sub_51430404:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r4, r0
	mov	r5, r1
	cmp	r4, #6
	bcc	_51430428
	mov	r2, #181	// 0xb5
	sub	r1, pc, #328	// 0x148	// !!!! PC relative !!!!! 0x5143041c + 0x148
	sub	r0, pc, #312	// 0x138	// !!!! PC relative !!!!! 0x51430420 + 0x138
	bl	sub_51403564
_51430428:
	ldr	r1, var_51430314
	add	r0, r4, r4, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0	
	bne	_51430450 
	mov	r1, r4
	add	r0, pc, #616	// 0x268	// !!!! PC relative !!!!! 0x51430440 + 0x268
	bl	sub_51403564
	mvn	r0, #0	
ret_5143044c:
	ldmia	sp!, {r4, r5, r6, pc}
_51430450:
	add	r0, r1, r0, lsl #2
	mov	r1, r5
	ldrb	r0, [r0, #1]
	bl	sub_51438078
	mov	r0, #0	
_51430464:
	b	ret_5143044c 

sub_51430468:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r4, r0
	mov	r5, r1
	cmp	r4, #6	
	bcc	_5143048c 
	mov	r2, #206	// 0xce
	sub	r1, pc, #428	// 0x1ac	// !!!! PC relative !!!!! 0x51430480 +0x1ac
	sub	r0, pc, #412	// 0x19c	// !!!! PC relative !!!!! 0x51430484 +0x19c
	bl	sub_51403564
_5143048c:
	ldr	r1, var_51430314
	add	r0, r4, r4, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0
	bne	_514304b4 
	mov	r1, r4
	add	r0, pc, #564	// 0x234	// !!!! PC relative !!!!! 0x514304a4 +0x234
	bl	sub_51403564
	mvn	r0, #0	
ret_514304b0:
	ldmia	sp!, {r4, r5, r6, pc}
_514304b4:
	add	r0, r1, r0, lsl #2
	mov	r1, r5
	ldrb	r0, [r0, #2]
	bl	sub_514380f8 
	mov	r0, #0
	b	ret_514304b0 	// 0x514304c8

sub_514304cc:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r4, r0
	mov	r5, r1
	cmp	r4, #6
	bcc	_514304f0 
	mov	r2, #231	
	sub	r1, pc, #528	// 0x210	// !!!! PC relative !!!!! 0x514304e4 +0x210
	sub	r0, pc, #512	// 0x200	// !!!! PC relative !!!!! 0x514304e8 +0x200
	bl	sub_51403564
_514304f0:
	ldr	r1, var_51430314
	add	r0, r4, r4, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0
	bne	_51430518 
	mov	r1, r4
	add	r0, pc, #508	// 0x1fc	// !!!! PC relative !!!!! 0x51430508 +0x1fc
	bl	sub_51403564 
	mvn	r0, #0	
ret_51430514:	
	ldmia	sp!, {r4, r5, r6, pc}
_51430518:
	add	r0, r1, r0, lsl #2
	mov	r1, r5
	ldrb	r0, [r0, #1]
	bl	sub_514380f8 
	mov	r0, #0	
	b	ret_51430514 	// 0x5143052c

sub_51430530:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r4, r0
	mov	r5, r1
	cmp	r4, #6	
	bcc	_51430554
	mov	r2, #256	// 0x100
	sub	r1, pc, #628	// 0x274	// !!!! PC relative !!!! 0x51430548 + 0x274
	sub	r0, pc, #612	// 0x264	// !!!! PC relative !!!! 0x5143054c + 0x264
	bl	sub_51403564
_51430554:
	ldr	r1, var_51430314
	add	r0, r4, r4, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0	
	bne	_5143057c
	mov	r1, r4
	add	r0, pc, #452	// 0x1c4	// !!!! PC relative !!!! 0x5143056c + 0x452
	bl	sub_51403564
	mvn	r0, #0	
ret_51430578:
	ldmia	sp!, {r4, r5, r6, pc}
_5143057c:
	add	r0, r1, r0, lsl #2
	ldrb	r0, [r0, #2]
	bl	sub_51438160
	strb	r0, [r5]
	mov	r0, #0	
	b	ret_51430578	// 0x51430590

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

sub_514305b8:
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	mov	r8, r0
	mov	r4, #0
	cmp	r8, #6	
	bcc	_514305dc
	ldr	r2, var_51430764
	sub	r1, pc, #764	// 0x2fc	// !!!! PC relative !!!!! 0x514305d0 + 0x2fc
	sub	r0, pc, #748	// 0x2ec	// !!!! PC relative !!!!! 0x514305d4 + 0x2ec
	bl	sub_51403564
_514305dc:
	ldr	r1, var_51430314
	add	r0, r8, r8, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0
	bne	_51430604
	mov	r1, r8
	add	r0, pc, #364	// 0x16c	// !!!! PC relative !!!!! 0x514305f4 + 0x16c
	bl	sub_51403564 
	mvn	r0, #0	
ret_51430600:
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
_51430604:
	add	r7, r1, r0, lsl #2
	ldr	r5, [r7, #8]
	mov	r1, #1	
	mov	r0, r8
	bl	sub_51430468
	mov	r1, #0	
	mov	r0, r8
	bl	sub_51430404 
	ldr	r9, var_51430798
	mov	sl, r5, lsr #1
_5143062c:
	ldrb	r0, [r7, #1]
	bl	sub_51438160 
	and	r6, r0, #255	// 0xff
	mov	r0, sl
	bl	sub_51430f80 
	add	r4, r4, r5, lsr #1
	cmp	r6, #0	
	bne	_51430654 
	cmp	r4, r9
	bcc	_5143062c 
_51430654:
	mov	r1, #1	
	mov	r0, r8
	bl	sub_514304cc 
	mov	r1, #1	
	mov	r0, r8
	bl	sub_51430404 
	mov	r1, #1	
	mov	r0, r8
	bl	sub_514304cc 
	mov	r0, r5
	bl	sub_51430f80 
	mov	r1, #0	
	mov	r0, r8
	bl	sub_51430468 
	mov	r0, sl
	bl	sub_51430f80 
	mov	r1, #0	
	mov	r0, r8
	bl	sub_514304cc 
	mov	r0, sl
	bl	sub_51430f80 
	mov	r0, #0	
	b	ret_51430600	// 0x514306ac



sub_5143079c:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r4, r0
	cmp	r4, #6
	bcc	_514307bc
	ldr	r2, var_514309d0
	ldr	r1, var_514309d4 
	ldr	r0, var_514309d8
	bl	sub_51403564 
_514307bc:
	ldr	r1, var_51430314 
	add	r0, r4, r4, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0	
	bne	_514307e4
	mov	r1, r4
	add	r0, pc, #512	// 0x200	// !!!! PC relative !!!!! 0x514307d4 +0x200
	bl	sub_51403564
	mvn	r0, #0
ret_514307e0:
	ldmia	sp!, {r4, r5, r6, pc}
_514307e4:
	add	r0, r1, r0, lsl #2
	ldr	r5, [r0, #8]
	mov	r1, #0
	mov	r0, r4
	bl	sub_51430468
	mov	r5, r5, lsr #1
	mov	r0, r5
	bl	sub_51430f80 
	mov	r1, #1	
	mov	r0, r4
	bl	sub_514304cc
	mov	r0, r5
	bl	sub_51430f80 
	mov	r1, #1	
	mov	r0, r4
	bl	sub_51430468 
	mov	r0, r5
	bl	sub_51430f80 
	mov	r0, #0	
	b	ret_514307e0	// 0x51430830

sub_51430834:
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	mov	r7, r0
	mov	r6, r1
	mov	r4, #0	
	cmp	r7, #6	
	bcc	_5143085c 
	ldr	r1, var_514309d4 
	ldr	r0, var_514309d8
	mov	r2, #448	// 0x1c0
	bl	sub_51403564
_5143085c:
	ldr	r1, var_51430314
	add	r0, r7, r7, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0
	bne	_51430884 
	mov	r1, r7
	add	r0, pc, #400	// 0x190
	bl	sub_51403564
	mvn	r0, #0	
ret_51430880:
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
_51430884:
	add	r5, r1, r0, lsl #2
	ldr	r8, [r5, #8]
	mov	r1, r6
	mov	r0, r7
	bl	sub_51430468 
	mov	sl, r8, lsr #1
	mov	r0, sl
	bl	sub_51430f80 
	mov	r1, #0	
	mov	r0, r7
	bl	sub_51430404 
	ldr	r9, var_51430798 
_514308b4:
	ldrb	r0, [r5, #1]
	bl	sub_51438160 
	and	r6, r0, #255	// 0xff
	ldr	r0, [r5, #8]
	mov	r0, r0, lsr #2
	bl	sub_51430f80 
	ldr	r0, [r5, #8]
	add	r4, r4, r0, lsr #2
	cmp	r6, #0	
	bne	_514308e4 
	cmp	r4, r9
	bcc	_514308b4 
_514308e4:
	mov	r1, #1	
	mov	r0, r7
	bl	sub_514304cc 
	mov	r1, #1	
	mov	r0, r7
	bl	sub_51430404 
	mov	r1, #1	
	mov	r0, r7
	bl	sub_514304cc 
	mov	r0, r8
	bl	sub_51430f80 
	mov	r1, #0	
	mov	r0, r7
	bl	sub_514304cc 
	mov	r0, sl
	bl	sub_51430f80 
	mov	r0, #0	
	b	ret_51430880 	// 0x51430928

sub_5143092c:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r4, r0
	mov	r6, r1
	cmp	r4, #6
	bcc	_51430950
	ldr	r2, var_51430a40
	sub	r1, pc, #1648	// 0x670	// !!!! PC relative 0x51430944 - 0x670
	sub	r0, pc, #1632	// 0x660	// !!!! PC relative 0x51430948 - 0x660
	bl	sub_51403564
_51430950:
	ldr	r1, var_51430314
	add	r0, r4, r4, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0
	bne	_51430978
	mov	r1, r4
	add	r0, pc, #212	// 0xd4	// !!!! PC relative 0x51430968 + 0xd4
	bl	sub_51403564
	mvn	r0, #0
ret_51430974:
	ldmia	sp!, {r4, r5, r6, pc}
_51430978:
	add	r0, r1, r0, lsl #2
	ldr	r0, [r0, #8]
	mov	r5, r0, lsr #1
	mov	r0, r5
	bl	sub_51430f80
	mov	r1, #1
	mov	r0, r4
	bl	sub_514304cc
	mov	r0, r5
	bl	sub_51430f80
	mov	r1, r6
	mov	r0, r4
	bl	sub_51430530
	mov	r0, r5
	bl	sub_51430f80
	mov	r1, #0
	mov	r0, r4
	bl	sub_514304cc
	mov	r0, r5
	bl	sub_51430f80
	mov	r0, #0
	b	_51430974	// 0x514309cc


sub_51430a78:
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	mov	r8, r0
	mov	r5, r1
	mov	r4, #0
	cmp	r8, #6
	bcc	_51430aa0
	ldr	r2, var_51430cd4 
	sub	r1, pc, #1984	// 0x7c0	// !!!! PC relative !!!!! 0x51430a94 + 0x7c0
	sub	r0, pc, #1968	// 0x7b0	// !!!! PC relative !!!!! 0x51430a98 + 0x7b0
	bl	sub_51403564
_51430aa0:
	ldr	r1, var_51430314
	add	r0, r8, r8, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0
	bne	_51430ac8
	mov	r1, r8
	add	r0, pc, #536	// 0x218	// !!!! PC relative !!!!! 0x51430ab8 + 0x218
	bl	sub_51403564
	mvn	r0, #0	
ret_51430ac4:
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
_51430ac8:
	add	r7, r1, r0, lsl #2
	ldr	r6, [r7, #8]
	mov	r1, #0
	mov	r0, r8
	bl	sub_51430290 
	mov	r0, r6
	bl	sub_51430f80
	mov	r1, #0	
	mov	r0, r8
	bl	sub_51430404 
	ldr	r9, var_51430798
	mov	sl, r6, lsr #1
_51430af8:
	ldrb	r0, [r7, #1]
	bl	sub_51438160
	strb	r0, [r5]
	mov	r0, sl
	bl	sub_51430f80
	add	r4, r4, r6, lsr #1
	ldrb	r0, [r5]
	cmp	r0, #0	
	bne	_51430b24
	cmp	r4, r9
	bcc	_51430af8 
_51430b24:
	mov	r1, #1	
	mov	r0, r8
	bl	sub_514304cc
	mov	r1, #1	
	mov	r0, r8
	bl	sub_51430404 
	mov	r1, #1
	mov	r0, r8
	bl	sub_514304cc
	mov	r0, sl
	bl	sub_51430f80 
	mov	r1, r5
	mov	r0, r8
	bl	sub_51430530 
	mov	r0, sl
	bl	sub_51430f80
	mov	r1, #0
	mov	r0, r8
	bl	sub_514304cc 
	mov	r1, #1	
	mov	r0, r8
	bl	sub_51430290 
	mov	r0, sl
	bl	sub_51430f80 
	mov	r0, #0	
	b	ret_51430ac4 	// 0x51430b88

sub_51430b8c:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r5, r0
	cmp	r5, #6	
	bcc	_51430bac 
	ldr	r1, var_514309d4 
	ldr	r0, var_514309d8
	mov	r2, #644	// 0x284
	bl	sub_51403564 
_51430bac:
	ldr	r1, var_51430314
	add	r0, r5, r5, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0	
	bne	_51430bd4
	mov	r1, r5
	add	r0, pc, #320	// 0x140 // !!!! PC relative 0x15430bc4 + 0x140
	bl	sub_51403564
	mvn	r0, #0
ret_51430bd0:
	ldmia	sp!, {r4, r5, r6, pc}
_51430bd4:
	add	r0, r1, r0, lsl #2
	ldr	r4, [r0, #8]
	mov	r1, #1	
	mov	r0, r5
	bl	sub_51430290
	mov	r1, #0	
	mov	r0, r5
	bl	sub_51430468
	mov	r6, r4, lsr #1
	mov	r0, r6
	bl	sub_51430f80
	mov	r1, #1	
	mov	r0, r5
	bl	sub_514304cc
	mov	r0, r4
	bl	sub_51430f80
	mov	r1, #0
	mov	r0, r5
	bl	aub_514304cc
	mov	r0, r6
	bl	sub_51430f80 
	mov	r0, #0	
	b	ret_51430bd0 	// 0x51430c2c

sub_51430c30:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r5, r0
	cmp	r5, #6
	bcc	_51430c50 
	ldr	r2, var_51430d40 
	sub	r1, pc, #2416	// 0x970	// !!!! PC relative 0x15430c44 - 0x970
	sub	r0, pc, #2400	// 0x960	// !!!! PC relative 0x15430c48 - 0x960
	bl	sub_51403564 
_51430c50:
	ldr	r1, var_51430314
	add	r0, r5, r5, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0
	bne	_51430c78
	mov	r1, r5
	add	r0, pc, #212	// 0xd4		// !!!! PC relative 0x15430b68 + 0xd4
	bl	sub_51403564
	mvn	r0, #0	
ret_51430c74:
	ldmia	sp!, {r4, r5, r6, pc}
_51430c78:
	add	r0, r1, r0, lsl #2
	ldr	r4, [r0, #8]
	mov	r1, #1
	mov	r0, r5
	bl	sub_51430290
	mov	r1, #1	
	mov	r0, r5
	bl	sub_51430468
	mov	r6, r4, lsr #1
	mov	r0, r6
	bl	sub_51430f80 
	mov	r1, #1	
	mov	r0, r5
	bl	sub_514304cc
	mov	r0, r4
	bl	sub_51430f80
	mov	r1, #0	
	mov	r0, r5
	bl	sub_514304cc
	mov	r0, r6
	bl	sub_51430f80
	mov	r0, #0	
	b	ret_51430c74	// 0x51430cd0




sub_51430d78:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r5, r0
	mov	r6, r1
	cmp	r5, #6	
	bcc	_51430d9c 
	ldr	r1, var_514309d4 
	ldr	r0, var_514309d8 
	mov	r2, #728	// 0x2d8
	bl	sub_51403564 
_51430d9c:
	ldr	r1, var_51430314 
	add	r0, r5, r5, lsl #1
	ldrb	r0, [r1, r0, lsl #2]
	cmp	r0, #0
	bne	_51430dc4 
	mov	r1, r5
	add	r0, pc, #344	// 0x158		// !!!! PC relative !!!!!
	bl	sub_51403564
	mvn	r0, #0
ret_51430dc0:
	ldmia	sp!, {r4, r5, r6, pc}
_51430dc4:
	mov	r4, #0
_51430dc8:
	rsb	r0, r4, #7
	mov	r0, r6, lsr r0
	and	r1, r0, #1
	mov	r0, r5
	bl	sub_51430834
	add	r0, r4, #1
	and	r4, r0, #255	// 0xff
	cmp	r4, #8
	bcc	_51430dc8
	mov	r1, #0
	mov	r0, r5
	bl	sub_51430468 
	mov	r0, #0
	b	ret_51430dc0´	// 0x51430dfc

sub_51430e00:
	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov	r6, r0
	mov	r5, r1
	mov	r4, #0	
	cmp	r6, #6	
	bcc	_51430e28 
	ldr	r2, var_51430f48 
	ldr	r1, var_514309d4 
	ldr	r0, var_514309d8 
	bl	sub_51403564 
_51430e28:
	ldr	r8, var_51430314 
	add	r7, r6, r6, lsl #1
	ldrb	r0, [r8, r7, lsl #2]
	cmp	r0, #0	
	bne	_51430e50
	mov	r1, r6
	add	r0, pc, #260	// 0x104	// !!!! PC relative 0x51430e40 + 0x104
	bl	sub_51403564 
	mvn	r0, #0	
ret_51430e4c:
	ldmia	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_51430e50:
	mov	r1, #0	
	mov	r0, r6
	bl	sub_51430290 
	add	r7, r8, r7, lsl #2
	ldr	r0, [r7, #8]
	mov	r0, r0, lsr #2
	bl	sub_51430f80 
	mov	r1, #0
	mov	r0, r6
	bl	sub_51430404 
	ldr	r8, var_51430798 
_51430e7c:
	ldrb	r0, [r7, #1]
	bl	sub_51438160
	str	r0, [sp]
	ldr	r0, [r7, #8]
	mov	r0, r0, lsr #2
	bl	sub_51430f80
	ldr	r0, [r7, #8]
	add	r4, r4, r0, lsr #2
	ldrb	r0, [sp]
	cmp	r0, #0	
	bne	_51430eb0 
	cmp	r4, r8
	bcc	_51430e7c 
_51430eb0:
	mov	r1, #1	
	mov	r0, r6
	bl	sub_514304cc 
	mov	r1, #1	
	mov	r0, r6
	bl	sub_51430404
	mov	r0, #0	
	strb	r0, [r5]
	mov	r4, #0
_51430ed4:
	mov	r1, sp
	mov	r0, r6
	bl	sub_5143092c 
	ldrb	r2, [sp]
	ldrb	r0, [r5]
	rsb	r1, r4, #7	
	orr	r0, r0, r2, lsl r1
	strb	r0, [r5]
	add	r4, r4, #1	
	cmp	r4, #8	
	bcc	_51430ed4 
	mov	r1, #1
	mov	r0, r6
	bl	sub_51430290 
	mov	r0, #0	
	b	ret_51430e4c 	// 0x51430f10

var_51430f14:	.word	0x4332495b
var_51430f18:	.word	0x4950475f
var_51430f1c:	.word	0x6f435f4f
var_51430f20:	.word	0x7469646e
var_51430f24:	.word	0x5f6e6f69
var_51430f28:	.word	0x74697257
var_51430f2c:	.word	0x74794265
var_51430f30:	.word	0x4e205d65
var_51430f34:	.word	0x4f20746f
var_51430f38:	.word	0x656e6570
var_51430f3c:	.word	0x43203a64
var_51430f40:	.word	0x64252868
var_51430f44:	.word	0x000a2029
var_51430f48:	.word	0x000002fb
var_51430f4c:	.word	0x4332495b
var_51430f50:	.word	0x4950475f
var_51430f54:	.word	0x6f435f4f
var_51430f58:	.word	0x7469646e
var_51430f5c:	.word	0x5f6e6f69
var_51430f60:	.word	0x64616552
var_51430f64:	.word	0x65747942
var_51430f68:	.word	0x6f4e205d
var_51430f6c:	.word	0x704f2074
var_51430f70:	.word	0x64656e65
var_51430f74:	.word	0x6843203a
var_51430f78:	.word	0x29642528
var_51430f7c:	.word	0x00000a20

sub_51430f80:
	ldr	r2, var_514311a4
	ldr	r1, var_514311a0 
	ldr	r2, [r2]
	add	r1, r1, r2, lsl #3
	ldr	r2, [r1, #4]
	b	_51430fb0
_51430f98:
	mov	r1, #0
_51430f9c:
	cmp	r1, r2
	bcs	_51430fac
	add	r1, r1, #1
	b	_51430f9c 
_51430fac:
	sub	r0, r0, #1
_51430fb0:
	cmp	r0, #0
	bne	_51430f98 
	bx	lr	// 0x51430fb8

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

sub_514311ac:
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	ldr	r2, var_514319c4
	ldr	r2, [r2, r0, lsl #4]
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
	ldr	r0, var_514319d8
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

sub_514313d0:
	ldr	r2, var_514319c4
	ldr	r0, [r2, r0, lsl #4]
	cmp	r0, #0x20000000
	bne	_514313e8 
	ldr	r2, var_514319c8
	b	_514313fc 
_514313e8:
	cmp	r0, #0x28000000
	bne	_514313f8 
	ldr	r2, var_514319cc 
	b	_514313fc 
_514313f8:
	mov	r2, #0
_514313fc:
	ldr	r3, [r2]
	cmp	r1, #1	
	bne	_51431410 
	bic	r1, r3, #256	// 0x100
	b	_51431414 
_51431410:
	orr	r1, r3, #256	// 0x100
_51431414:
	str	r1, [r2]
	add	r0, r0, #0x3000000
	add	r0, r0, #245760	// 0x3c000
	ldr	r0, [r0, #2180]
ret_51431424:
	bx	lr

sub_51431428:
	ldr	r2, var_514319c4
	ldr	r0, [r2, r0, lsl #4]
	cmp	r0, #0x20000000
	bne	_51431440
	ldr	r2, var_514319c8
	b	_51431454
_51431440:
	cmp	r0, #0x28000000
	bne	_51431450
	ldr	r2, var_514319cc
	b	_51431454
_51431450:
	mov	r2, #0
_51431454:
	ldr	r3, [r2]
	bic	r3, r3, #224	// 0xe0
	orr	r1, r3, r1, lsl #5
	orr	r1, r1, #192	// 0xc0
	str	r1, [r2]
	add	r0, r0, #0x3000000
	add	r0, r0, #0x3c000
	ldr	r0, [r0, #2180]
ret_51431474:
	bx	lr

sub_51431478:
	ldr	r2, var_514319c4
	ldr	r0, [r2, r0, lsl #4]
	cmp	r0, #0x20000000
	bne	_51431490
	ldr	r2, var_514319c8
	b	_514314a4
_51431490:
	cmp	r0, #0x28000000
	bne	_514314a0
	ldr	r2, var_514319cc
	b	_514314a4 
_514314a0:
	mov	r2, #0
_514314a4:
	ldr	r3, [r2]
	bic	r3, r3, #0x7000
	orr	r1, r3, r1, lsl #12
	str	r1, [r2]
	add	r0, r0, #0x3000000
	add	r0, r0, #0x3c000
	ldr	r0, [r0, #2180]
ret_514314c0:
	bx	lr

sub_514314c4:
	ldr	r2, var_514319c4
	ldr	r3, [r2, r0, lsl #4]
	cmp	r3, #0x20000000
	bne	_514314dc
	ldr	r0, var_514319c8 
	b	_514314f0
_514314dc:
	cmp	r3, #0x28000000
	bne	_514314ec 
	ldr	r0, var_514319cc
	b	_514314f0 
_514314ec:
	mov	r0, #0	
_514314f0:
	ldr	r2, [r0]
	bic	r2, r2, #0x8e00
	bic	r2, r2, #2
	mov	ip, r1
	cmp	ip, #6
	mov	r1, #16	// 0x10
	addls	pc, pc, ip, lsl #2
_5143150c:	
	b	sub_514315ac
_51431510:	
	b	sub_514315ac
_51431514:	
	b	sub_5143152c
_51431518:	
	b	sub_51431540
_5143151c:	
	b	sub_51431558
_51431520:	
	b	sub_51431570
_51431524:	
	b	sub_51431584
_51431528:	
	b	sub_5143159c
sub_5143152c:
	orr	r2, r2, #0x8000
	orr	r2, r2, #2
	str	r1, [r0, #16]
	str	r2, [r0]
	b	_514315b8 
sub_51431540:
	orr	r1, r2, #0x8200
	orr	r1, r1, #2
	mov	r2, #4	
	str	r2, [r0, #16]
	str	r1, [r0]
	b	_514315b8
sub_51431558:
	orr	r1, r2, #0x8400
	orr	r1, r1, #2	
	mov	r2, #8	
	str	r2, [r0, #16]
	str	r1, [r0]
	b	_514315b8 
sub_51431570:
	orr	r2, r2, #0x8600
	orr	r2, r2, #2	
	str	r1, [r0, #16]
	str	r2, [r0]
	b	_514315b8
sub_51431584:
	orr	r1, r2, #0x8800
	orr	r1, r1, #2
	mov	r2, #32	// 0x20
	str	r2, [r0, #16]
	str	r1, [r0]
	b	_514315b8
sub_5143159c:
	orr	r2, r2, #0x8600
	str	r1, [r0, #16]
	str	r2, [r0]
	b	_514315b8
sub_514315ac:
	mov	r1, #0
	str	r1, [r0, #16]
	str	r2, [r0]
_514315b8:
	ldr	r0, var_514319e4 
	ldr	r0, [r0, r3]
	bx	lr		// 0x514315c0

sub_514315c4:
	ldr	r2, var_514319c4
	ldr	r0, [r2, r0, lsl #4]
	cmp	r0, #0x20000000
	bne	_514315dc
	ldr	r0, var_514319c8 
	b	_514315f0
_514315dc:
	cmp	r0, #0x28000000
	bne	_514315ec 
	ldr	r0, var_514319cc 
	b	_514315f0 
_514315ec:
	mov	r0, #0
_514315f0:
	and	r1, r1, #1
	str	r1, [r0, #416]
ret_514315f8:
	bx	lr

sub_514315fc:
	ldr	r2, var_514319c4
	ldr	r0, [r2, r0, lsl #4]
	cmp	r0, #0x20000000
	bne	_51431614 
	ldr	r0, var_514319c8
	b	_51431628 
_51431614:
	cmp	r0, #0x28000000
	bne	_51431624
	ldr	r0, var_514319cc
	b	_51431628 
_51431624:
	mov	r0, #0	
_51431628:
	and	r1, r1, #1
	str	r1, [r0, #320]
ret_51431630:
	bx	lr



sub_51431694:
	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
	ldr	r3, var_514319c4
	ldr	r3, [r3, r0, lsl #4]
	cmp	r3, #0x20000000
	bne	_514316b0 
	ldr	r4, var_514319c8
	b	_514316c4
_514316b0:
	cmp	r3, #0x28000000
	bne	_514316c0 
	ldr	r4, var_514319cc 
	b	_514316c4 
_514316c0:
	mov	r4, #0
_514316c4:
	mov	ip, #0
	str	ip, [r4, #48]
	ldr	lr, var_514319d0
	cmp	r2, #1	
	add	ip, lr, r0, lsl #5
	bls	_514316f8 
	ldr	r6, [ip, #16]
	ldr	r7, [lr, r0, lsl #5]
	and	r6, r6, r1
	mov	r5, #8
	add	r6, r3, r6, lsl r7
	add	r6, r6, #0x2000000
	str	r5, [r6]
_514316f8:
	add	r1, r1, r2
	ldr	r2, [ip, #16]
	ldr	r0, [lr, r0, lsl #5]
	sub	r1, r1, #1	
	and	r1, r1, r2
	mov	r5, #9	
	add	r0, r3, r1, lsl r0
	add	r0, r0, #0x2000000
	str	r5, [r0]
	mov	r5, #0x10000000
	ldr	r6, var_514319e8 
	b	_51431750 
_51431728:
	bl	sub_5142fbd8 
	subs	r5, r5, #1
	bne	_51431750 
	mov	r1, #0	
	add	r0, pc, #684	// 0x2ac	// !!!! PC relative 0x51431738 + 0x2ac
	bl	sub_51403564 
	ldr	r0, [r6]
	orr	r0, r0, #1	
	str	r0, [r6]
	b	_5143175c
_51431750:
	ldr	r0, [r4, #48]
	tst	r0, #1024	// 0x400
	beq	_51431728 
_5143175c:
	mov	r5, #0x10000000
	b	_5143178c 
_51431764:
	bl	sub_5142fbd8 
	subs	r5, r5, #1
	bne	_5143178c 
	mov	r1, #1	
	add	r0, pc, #624	// 0x270	// !!!! PC relative 0x51431774 + 0x270
	bl	sub_51403564 
	ldr	r0, [r6]
	orr	r0, r0, #2	
	str	r0, [r6]
	b	_51431798 
_5143178c:
	ldr	r0, [r4, #48]
	tst	r0, #256	// 0x100
	bne	_51431764 
_51431798:
	mov	r0, #0	
	ldmia	sp!, {r4, r5, r6, r7, r8, pc}	// 0x5143179c




var_514319c8:	.word	0x70100000
var_514319cc:	.word	0x70180000 
var_514319d0:	.word	0x51649338 
var_514319d4:	.word	0x000001ff 
var_514319d8:	.word	0x000003ff 
var_514319dc:	.word	0x000007ff 
var_514319e0:	.word	0x00000fff




sub_51431fb8:
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, lr}
	cmp	r2, #0	
	beq	_514320fc 
	cmp	r3, #0	
	beq	_514320fc 
	ldr	r5, var_51432a9c
	rsb	lr, r0, r0, lsl #3
	mov	r4, #2	
	strb	r4, [r5, lr, lsl #2]
	add	r1, r5, lr, lsl #2
	mov	r6, #3	
	strb	r6, [r1, #1]
	mov	ip, #8	
	strb	ip, [r1, #2]
	strb	r4, [r1, #3]
	mov	ip, #6	
	strb	ip, [r1, #4]
	mov	r7, #0	
	strb	r7, [r1, #5]
	strb	r6, [r1, #6]
	mov	r8, #4	
	strb	r8, [r1, #7]
	ldr	ip, var_51432aa4
	str	ip, [r1, #24]
	ldrh	ip, [r2]
	strh	ip, [r1, #8]
	ldrh	ip, [r2]
	and	r9, ip, #240	// 0xf0
	cmp	r9, #16		// 0x10
	beq	_51432038 
	tst	ip, #240	// 0xf0
	bne	_5143205c 
_51432038:
	mov	ip, #1	
	strb	ip, [r5, lr, lsl #2]
	strb	ip, [r1, #1]
	mov	lr, #7
	strb	lr, [r1, #2]
	strb	ip, [r1, #3]
	strb	ip, [r1, #5]
	strb	ip, [r1, #6]
	strb	r4, [r1, #7]
_5143205c:
	ldrh	ip, [r2]
	and	lr, ip, #3
	and	ip, ip, #240	// 0xf0
	cmp	ip, #32	// 0x20
	bne	_51432080
	ldrh	lr, [r3]
	tst	lr, #3840	// 0xf00
	beq	_51432080 
	and	lr, lr, #3840	// 0xf00
_51432080:
	cmp	ip, #48	// 0x30
	bne	_51432090 
	ldrh	lr, [r3]
	and	lr, lr, #3840	// 0xf00
_51432090:
	cmp	ip, #64		// 0x40
	bne	_514320b8 
	mov	ip, #5	
	strb	ip, [r1, #4]
	ldrh	r2, [r2]
	tst	r2, #8	
	beq	_514320d4 
	ldrh	r2, [r3]
	and	r2, r2, #3840	// 0xf00
	b	_514320d4 
_514320b8:
	cmp	ip, #80		// 0x50
	bne	_514320c8 
	strb	r8, [r1, #4]
	b	_514320d4 
_514320c8:
	cmp	ip, #96		// 0x60
	bne	_514320d4 
	strb	r6, [r1, #4]
_514320d4:
	ldr	r2, var_514319c4 
	add	r0, r2, r0, lsl #4
	ldr	r2, var_51432aa8
	ldr	r0, [r0, #12]
	ldrb	r0, [r0, #17]
	cmp	r0, #0	
	bne	_51432100 
	str	r2, [r1, #16]
	ldr	r0, var_51432aac 
	str	r0, [r1, #20]
ret_514320fc:
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, pc}
_51432100:
	cmp	r0, #1
	bne	_51432118
	str	r2, [r1, #16]
	ldr	r0, var_51432ab0 
	str	r0, [r1, #20]
	b	ret_514320fc 
_51432118:
	str	r7, [r1, #16]
	str	r7, [r1, #20]
	b	ret_514320fc 	// 0x51432120

/*
 *  51432000
 */
sub_51432124:
	stmdb	sp!, {r4, r5, lr}
	mov	r5, r0
	ldr	r0, var_514319c4 
	ldr	r0, [r0, r5, lsl #4]
	cmp	r0, #0x20000000
	bne	_51432144 
	ldr	r4, var_514319c8
	b	_51432158 
_51432144:
	cmp	r0, #0x28000000
	bne	_51432154 
	ldr	r4, var_514319cc
	b	_51432158 
_51432154:
	mov	r4, #0
_51432158:
	cmp	r1, #0	
	beq	ret_51432204 
	cmp	r2, #0	
	beq	ret_51432204 
	cmp	r3, #0	
	beq	ret_51432204
	ldr	ip, var_51432ab8
	ldr	r0, var_51432ab4
	ldr	ip, [ip]
	str	r0, [ip, #464]
	mov	r0, #1	
	str	r0, [r4, #768]
	mov	r0, #7	
	str	r0, [r4, #448]
	ldr	r0, [r4, #112]
	strh	r0, [r1]
	ldr	r0, [r4, #128]
	strh	r0, [r2]
	ldr	r0, [r4, #496]
	strh	r0, [r3]
	mov	r1, r2
	mov	r0, r5
	bl	sub_514311ac 
	mov	r1, #1	
	mov	r0, r5
	bl	sub_514313d0
	mov	r1, #1	
	mov	r0, r5
	bl	sub_51431428
	mov	r1, #4	
	mov	r0, r5
	bl	sub_51431478
	mov	r1, #4	
	mov	r0, r5
	bl	sub_514314c4 
	mov	r1, #0	
	mov	r0, r5
	bl	sub_514315c4
	mov	r1, #1	
	mov	r0, r5
	bl	sub_514315fc 
	ldr	r0, var_51432abc
	str	r0, [r4, #64]
ret_51432204:
	ldmia	sp!, {r4, r5, pc}


sub_5143234c:
	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	mov	sl, r0
	ldr	fp, var_514319e8
	ldr	r0, [fp, #12]
	cmp	r0, #1	
	bne	_5143236c 
	mov	r0, #0	
ret_51432368:
	ldmia	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, pc}
_5143236c:
	mov	r0, #0
	ldr	r3, var_51432ac0
	mov	r2, #0	
	add	r8, r3, #288	// 0x120
_5143237c:
	str	r2, [r3, r0, lsl #2]
	add	r1, r8, r0, lsl #4
	str	r2, [r1, #4]
	str	r2, [r1, #8]
	str	r2, [r1, #12]
	add	r0, r0, #1	
	cmp	r0, #8	
	bcc	_5143237c 
	mov	r5, #0	
_514323a0:
	mov	r4, #0	
	add	r7, sl, r5, lsl #5
	mvn	r9, #0	
_514323ac:
	add	r6, r4, r5, lsl #2
	ldr	r0, [r7, r4, lsl #2]
	cmn	r0, #1	
	beq	_514323c8 
	bl	sub_5142fb50
	str	r0, [r8, r6, lsl #4]
	b	_514323cc
_514323c8:
	str	r9, [r8, r6, lsl #4]
_514323cc:
	add	r4, r4, #1
	cmp	r4, #4	
	bcc	_514323ac 
	add	r5, r5, #1	
	cmp	r5, #2	
	bcc	_514323a0 
	mov	r0, #1	
	str	r0, [fp, #12]
	mov	r0, #0	
	b	ret_51432368 	// 0x514323f0

sub_514323f4:
	stmdb	sp!, {r1, r2, r3, r4, r5, r6, lr}
	mov	r4, r0
	ldr	r0, var_514319c4
	mov	r6, #1
	add	r5, r0, r4, lsl #4
	str	r6, [r5, #8]
	mov	r3, sp
	add	r2, sp, #4
	add	r1, sp, #8
	mov	r0, r4
	bl	sub_51432124 
	mov	r0, #0	
	ldr	lr, var_51432ac4 
	ldrh	r2, [sp, #4]
	ldrh	ip, [sp]
	b	_51432480
_51432434:
	ldrh	r3, [r1, #2]
	cmp	r3, r2
	bne	_5143247c
	ldrh	r1, [r1, #4]
	cmp	r1, ip, lsr #8
	bne	_5143247c 
	str	r6, [r5, #4]
	add	r0, r0, r0, lsl #3
	add	r0, lr, r0, lsl #2
	str	r0, [r5, #12]
	ldr	r1, var_51432a9c
	rsb	r3, r4, r4, lsl #3
	ldrh	r2, [r0, #6]
	add	r1, r1, r3, lsl #2
	strh	r2, [r1, #10]
	ldrh	r0, [r0, #10]
	strh	r0, [r1, #12]
	b	_51432494 
_5143247c:
	add	r0, r0, #1	
_51432480:
	add	r1, r0, r0, lsl #3
	add	r1, lr, r1, lsl #2
	ldrh	r3, [r1]
	cmp	r3, #0	
	bne	_51432434 
_51432494:
	mov	r3, sp
	add	r2, sp, #4
	add	r1, sp, #8
	mov	r0, r4
	bl	sub_51431fb8 
	ldr	r2, [r5, #4]
	ldr	r0, var_51432ac8
	mov	r1, #0
	cmp	r2, #1
	beq	_514324c4 
	str	r1, [r5, #8]
ret_514324c0:
	ldmia	sp!, {r1, r2, r3, r4, r5, r6, pc}
_514324c4:
	ldr	r3, var_51432ac0
	ldr	r2, [r3, r4, lsl #2]
	cmp	r2, #0
	bne	_514324e8 
	add	r2, r3, #416	// 0x1a0
	add	r2, r2, r4, lsl #1
	str	r2, [r3, r4, lsl #2]
	cmp	r2, #0
	beq	ret_514324c0
_514324e8:
	ldr	r0, [r3, r4, lsl #2]
	strh	r1, [r0]
	mov	r0, #0
	b	ret_514324c0	// 0x514324f4


/*
 *  51433000
 */ 

sub_51433ad4:
	ldr	r1, var_51433a90
	add	r0, r1, r0, lsl #4
	ldr	r0, [r0, #12]
	ldrh	r0, [r0, #6]
	bx	lr

sub_51433ae8:
	ldr	r1, var_51433b50
	rsb	r0, r0, r0, lsl #3
	add	r0, r1, r0, lsl #2
	ldrb	r0, [r0, #7]
	mov	r0, r0, lsl #6
	bx	lr		// 0x51433afc


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



sub_51433dbc:
	stmdb	sp!, {r4, lr}
	mov	r4, #0
	mov	r1, r0
	ldr	r0, var_514347c4
	cmp	r1, #60	// 0x3c
	addls	pc, pc, r1, lsl #2	// 0x51433dd0
_51433dd4:
	b	_514344dc
	b	_514344dc
	b	_51433ecc
	b	_51433ee0
	b	_51433ef4
	b	_514344dc
	b	_51433f08
	b	_51433f28
	b	_51433f48
	b	_51433f5c
	b	_51433f70
	b	_51433f84
	b	_51433f98
	b	_51433fac
	b	_51433fc0
	b	_51433fd4
	b	_51433fe8
	b	_51433ffc
	b	_51434028
	b	_51434054
	b	_51434080
	b	_51434094
	b	_514340a8
	b	_514340bc
	b	_514340d0
	b	_514340e4
	b	_51434104
	b	_51434118
	b	_51434138
	b	_5143414c
	b	_5143416c
	b	_51434180
	b	_514341ac
	b	_514341c0
	b	_514341ec
	b	_5143420c
	b	_5143422c
	b	_5143424c
	b	_51434260
	b	_51434274
	b	_514342a0
	b	_514342b4
	b	_514342c8
	b	_514342dc
	b	_51434308
	b	_5143431c
	b	_51434330
	b	_51434350
	b	_51434364
	b	_51434390
	b	_514343bc
	b	_514343dc
	b	_514343f0
	b	_5143441c
	b	_51434430
	b	_51434444
	b	_51434458
	b	_5143446c
	b	_51434480
	b	_51434494
	b	_514344b4
	b	_514344c8 	// 0x51433ec8

_51433ecc:
	ldr	r0, [r0, #48]
	tst	r0, #256	// 0x100
	beq	_514344f4
	mov	r4, #1	
	b	_514344f4 

_51433ee0:
	ldr	r0, [r0, #48]
	tst	r0, #0x80000000
	beq	_514344f4 
	mov	r4, #1	
	b	_514344f4 

_51433ef4:
	ldr	r0, [r0, #52]
	tst	r0, #16384	// 0x4000
	beq	_514344f4
	mov	r4, #1	
	b	_514344f4 

_51433f08:
	ldr	r1, [r0, #48]
	tst	r1, #1024	// 0x400
	bne	_51433f20
	ldr	r0, [r0, #56]
	tst	r0, #4
	beq	_514344f4
_51433f20:
	mov	r4, #1
	b	_514344f4

_51433f28:
	ldr	r1, [r0, #48]
	tst	r1, #0x200000
	beq	_514344f4
	ldr	r0, [r0, #60]
	tst	r0, #32	// 0x20
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_51433f48:
	ldr	r0, [r0, #52]
	tst	r0, #8388608	// 0x800000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_51433f5c:
	ldr	r0, [r0, #48]
	tst	r0, #16777216	// 0x1000000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_51433f70:
	ldr	r0, [r0, #48]
	tst	r0, #32768	// 0x8000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_51433f84:
	ldr	r0, [r0, #48]
	tst	r0, #4096	// 0x1000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_51433f98:
	ldr	r0, [r0, #48]
	tst	r0, #8192	// 0x2000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_51433fac:
	ldr	r0, [r0, #48]
	tst	r0, #4194304	// 0x400000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_51433fc0:
	ldr	r0, [r0, #52]
	tst	r0, #262144	// 0x40000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_51433fd4:
	ldr	r0, [r0, #52]
	tst	r0, #1048576	// 0x100000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_51433fe8:
	ldr	r0, [r0, #52]
	tst	r0, #524288	// 0x80000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_51433ffc:
	ldr	r1, [r0, #48]
	tst	r1, #131072	// 0x20000
	bne	_51434020
	ldr	r1, [r0, #56]
	tst	r1, #134217728	// 0x8000000
	bne	_51434020
	ldr	r0, [r0, #56]
	tst	r0, #16777216	// 0x1000000
	beq	_514344f4
_51434020:
	mov	r4, #1
	b	_514344f4

_51434028:
	ldr	r1, [r0, #48]
	tst	r1, #262144	// 0x40000
	bne	_5143404c 
	ldr	r1, [r0, #56]
	tst	r1, #268435456	// 0x10000000
	bne	_5143404c <__oldboot_ram_start+0x3404c>
	ldr	r0, [r0, #56]
	tst	r0, #33554432	// 0x2000000
	beq	_514344f4
_5143404c:
	mov	r4, #1
	b	_514344f4

_51434054:
	ldr	r1, [r0, #48]
	tst	r1, #524288	// 0x80000
	bne	_51434078
	ldr	r1, [r0, #56]
	tst	r1, #536870912	// 0x20000000
	bne	_51434078
	ldr	r0, [r0, #56]
	tst	r0, #67108864	// 0x4000000
	beq	_514344f4
_51434078:
	mov	r4, #1
	b	_514344f4

_51434080:
	ldr	r0, [r0, #48]
	tst	r0, #16384	// 0x4000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_51434094:
	ldr	r0, [r0, #52]
	tst	r0, #131072	// 0x20000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_514340a8:
	ldr	r0, [r0, #52]
	tst	r0, #134217728	// 0x8000000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_514340bc:
	ldr	r0, [r0, #52]
	tst	r0, #32768	// 0x8000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_514340d0:
	ldr	r0, [r0, #52]
	tst	r0, #65536	// 0x10000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_514340e4:
	ldr	r1, [r0, #52]
	tst	r1, #67108864	// 0x4000000
	bne	_514340fc
	ldr	r0, [r0, #56]
	tst	r0, #2048	// 0x800
	beq	_514344f4
_514340fc:
	mov	r4, #1
	b	_514344f4

_51434104:
	ldr	r0, [r0, #48]
	tst	r0, #2
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_51434118:
	ldr	r1, [r0, #52]
	tst	r1, #1024	// 0x400
	bne	_51434130
	ldr	r0, [r0, #56]
	tst	r0, #64	// 0x40
	beq	_514344f4
_51434130:
	mov	r4, #1
	b	_514344f4

_51434138:
	ldr	r0, [r0, #48]
	tst	r0, #33554432	// 0x2000000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_5143414c:
	ldr	r1, [r0, #48]
	tst	r1, #2048	// 0x800
	bne	_51434164
	ldr	r0, [r0, #56]
	tst	r0, #2
	beq	_514344f4
_51434164:
	mov	r4, #1
	b	_514344f4

_5143416c:
	ldr	r0, [r0, #52]
	tst	r0, #2048	// 0x800
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_51434180:
	ldr	r1, [r0, #48]
	tst	r1, #8
	bne	_514341a4 
	ldr	r1, [r0, #56]
	tst	r1, #16384	// 0x4000
	bne	_514341a4
	ldr	r0, [r0, #56]
	tst	r0, #32768	// 0x8000
	beq	_514344f4
_514341a4:
	mov	r4, #1
	b	_514344f4

_514341ac:
	ldr	r0, [r0, #48]
	tst	r0, #65536	// 0x10000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_514341c0:
	ldr	r1, [r0, #48]
	tst	r1, #1
	bne	_514341e4
	ldr	r1, [r0, #52]
	tst	r1, #1
	bne	_514341e4
	ldr	r0, [r0, #56]
	tst	r0, #8
	beq	_514344f4
_514341e4:
	mov	r4, #1
	b	_514344f4

_514341ec:
	ldr	r1, [r0, #48]
	tst	r1, #2097152	// 0x200000
	beq	_514344f4
	ldr	r0, [r0, #60]
	tst	r0, #4
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_5143420c:
	ldr	r1, [r0, #48]
	tst	r1, #2097152	// 0x200000
	beq	_514344f4
	ldr	r0, [r0, #60]
	tst	r0, #8
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_5143422c:
	ldr	r1, [r0, #48]
	tst	r1, #2097152	// 0x200000
	beq	_514344f4
	ldr	r0, [r0, #60]
	tst	r0, #16	// 0x10
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_5143424c:
	ldr	r0, [r0, #52]
	tst	r0, #256	// 0x100
	beq	_514344f4
	mov	r4, #1	
	b	_514344f4

_51434260:
	ldr	r0, [r0, #52]
	tst	r0, #512	// 0x200
	beq	_514344f4
	mov	r4, #1	
	b	_514344f4

_51434274:
	ldr	r1, [r0, #48]
	tst	r1, #32	// 0x20
	bne	_51434298
	ldr	r1, [r0, #56]
	tst	r1, #0x400
	bne	_51434298
	ldr	r0, [r0, #56]
	tst	r0, #0x1000
	beq	_514344f4
_51434298:
	mov	r4, #1
	b	_514344f4

_514342a0:
	ldr	r0, [r0, #52]
	tst	r0, #128	// 0x80
	beq	_514344f4
	mov	r4, #1	
	b	_514344f4

_514342b4:
	ldr	r0, [r0, #48]
	tst	r0, #16	// 0x10
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_514342c8:
	ldr	r0, [r0, #52]
	tst	r0, #64	// 0x40
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_514342dc:
	ldr	r1, [r0, #48]
	tst	r1, #0x200
	bne	_51434300
	ldr	r1, [r0, #56]
	tst	r1, #0x10000
	bne	_51434300
	ldr	r0, [r0, #56]
	tst	r0, #0x20000
	beq	_514344f4
_51434300:
	mov	r4, #1
	b	_514344f4

_51434308:
	ldr	r0, [r0, #48]
	tst	r0, #0x4000000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_5143431c:
	ldr	r0, [r0, #48]
	tst	r0, #0x8000000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_51434330:
	ldr	r1, [r0, #48]
	tst	r1, #0x10000000
	bne	_51434348
	ldr	r0, [r0, #56]
	tst	r0, #0x80
	beq	_514344f4
_51434348:
	mov	r4, #1	
	b	_514344f4

_51434350:
	ldr	r0, [r0, #52]
	tst	r0, #0x1000000
	beq	_514344f4
	mov	r4, #1	
	b	_514344f4

_51434364:
	ldr	r1, [r0, #52]
	tst	r1, #0x200000
	bne	_51434388
	ldr	r1, [r0, #56]
	tst	r1, #0x100000
	bne	_51434388
	ldr	r0, [r0, #56]
	tst	r0, #0x400000
	beq	_514344f4
_51434388:
	mov	r4, #1
	b	_514344f4

_51434390:
	ldr	r1, [r0, #52]
	tst	r1, #0x400000
	bne	_514343b4
	ldr	r1, [r0, #56]
	tst	r1, #0x200000
	bne	_514343b4
	ldr	r0, [r0, #56]
	tst	r0, #0x800000
	beq	_514344f4
_514343b4:
	mov	r4, #1	
	b	_514344f4

_514343bc:
	ldr	r1, [r0, #48]
	tst	r1, #0x200000
	beq	_514344f4
	ldr	r0, [r0, #60]
	tst	r0, #2	
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_514343dc:
	ldr	r0, [r0, #52]
	tst	r0, #0x1000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_514343f0:
	ldr	r1, [r0, #48]
	tst	r1, #128	// 0x80
	bne	_51434414
	ldr	r1, [r0, #56]
	tst	r1, #0x40000
	bne	_51434414
	ldr	r0, [r0, #56]
	tst	r0, #0x80000
	beq	_514344f4
_51434414:
	mov	r4, #1
	b	_514344f4

_5143441c:
	ldr	r0, [r0, #48]
	tst	r0, #4
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_51434430:
	ldr	r0, [r0, #52]
	tst	r0, #0x2000
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_51434444:
	ldr	r0, [r0, #52]
	tst	r0, #2
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_51434458:
	ldr	r0, [r0, #52]
	tst	r0, #4	
	beq	_514344f4
	mov	r4, #1	
	b	_514344f4

_5143446c:
	ldr	r0, [r0, #52]
	tst	r0, #8	
	beq	_514344f4
	mov	r4, #1	
	b	_514344f4

_51434480:
	ldr	r0, [r0, #52]
	tst	r0, #16	// 0x10
	beq	_514344f4
	mov	r4, #1
	b	_514344f4

_51434494:
	ldr	r1, [r0, #48]
	tst	r1, #0x20000000
	bne	_514344ac 
	ldr	r0, [r0, #56]
	tst	r0, #0x40000000
	beq	_514344f4
_514344ac:
	mov	r4, #1	
	b	_514344f4

_514344b4:
	ldr	r0, [r0, #48]
	tst	r0, #0x100000
	beq	_514344f4
	mov	r4, #1	
	b	_514344f4

_514344c8:
	ldr	r0, [r0, #52]
	tst	r0, #32	// 0x20
	beq	_514344f4
	mov	r4, #1	
	b	_514344f4

_514344dc:
	add	r0, pc, #740	// 0x2e4	// !!!! PC relative 0x514344dc + 0x2e4
	bl	sub_51403564
	ldr	r0, var_51434804
	ldr	r1, [r0]
	orr	r1, r1, #0x800000
	str	r1, [r0]
_514344f4:
	mov	r0, r4
	ldmia	sp!, {r4, pc}	// 0x514344f8

/*
 *  51435000
 */



sub_51435b48:
	stmdb	sp!, {r4, lr}
	mov	r4, r1
	sub	ip, r0, #8192	// 0x2000
	subs	ip, ip, #3808	// 0xee0
	beq	_51435b64 
	add	r0, pc, #424	// 0x1a8	// !!!! PC relative 0x51435b5c + 0x1a8
	bl	sub_51403564
_51435b64:
	mov	r0, #0	
	ldr	r1, var_51435d40
_51435b6c:
	add	r2, r0, r0, lsl #1
	add	r2, r1, r2, lsl #2
	ldr	r2, [r2, #8]
	cmp	r2, r4
	bne	_51435b90 
	add	r0, r0, r0, lsl #1
	add	r0, r1, r0, lsl #2
	ldr	r0, [r0, #4]
ret_51435b8c:
	ldmia	sp!, {r4, pc}
_51435b90:
	add	r0, r0, #1	
	and	r0, r0, #255	// 0xff
	cmp	r0, #17	// 0x11
	bcc	_51435b6c 
	ldr	r0, var_51435d44
	mov	r1, r4
	bl	sub_51403564
	ldr	r0, var_51435d48
	ldr	r1, [r0]
	orr	r1, r1, #0x80000000
	str	r1, [r0]
	mov	r0, #0	
	b	ret_51435b8c 

sub_51435bc4:
	stmdb	sp!, {r4, lr}
	sub	ip, r0, #0x2000
	subs	ip, ip, #0xee0
	beq	_51435bdc 
	add	r0, pc, #368	// 0x170	// !!!! PC relative 0x51435bd4 + 0x170
	bl	sub_51403564
_51435bdc:
	ldr	r0, var_51435d80
	ldr	r1, [r0, #20]
	ldr	r2, var_51435d84 
	bic	r1, r1, r2
	ldr	r0, [r0, #24]
	uxth r2,r0
	mov	r0, #0	
	ldr	lr, var_51435d88
_51435bfc:
	add	r3, lr, r0, lsl #4
	ldr	ip, [r3, #8]
	cmp	ip, r1
	bne	_51435c24
	ldr	r3, [r3, #12]
	cmp	r3, r2
	bne	_51435c24
	add	r0, lr, r0, lsl #4
	ldr	r0, [r0, #4]
ret_51435c20:
	ldmia	sp!, {r4, pc}
_51435c24:
	add	r0, r0, #1
	and	r0, r0, #255	// 0xff
	cmp	r0, #11	// 0xb
	bcc	_51435bfc 
	ldr	r0, var_51435d8c
	bl	sub_51403564 
	ldr	r0, var_51435d48 
	ldr	r1, [r0]
	orr	r1, r1, #0x40000000
	str	r1, [r0]
	mov	r0, #0
	b	ret_51435c20 	// 0x51435c50

sub_51435c54:
	stmdb	sp!, {r4, lr}
	mov	r4, #0
	ldr	r2, sub_51435d90
	ldr	r3, sub_51435d80 
	cmp	r1, #62	// 0x3e
	beq	_51435c88 
	cmp	r1, #63	// 0x3f
	beq	_51435c9c 
	cmp	r1, #64	// 0x40
	bne	_51435cb0 
	bl	sub_51435bc4 
	mov	r4, r0
	b	_51435cb8 
_51435c88:
	ldr	r1, [r3, #12]
	and	r1, r1, r2
	bl	sub_51435b48 
	mov	r4, r0
	b	_51435cb8
_51435c9c:
	ldr	r1, [r3, #16]
	and	r1, r1, r2
	bl	sub_51435b48
	mov	r4, r0
	b	_51435cb8 
_51435cb0:
	add	r0, pc, #220	// 0xdc	// !!!! PC relative	0x51435cb0 + 0xdc
	bl	sub_51403564 
_51435cb8:
	mov	r0, r4
	ldmia	sp!, {r4, pc}

var_51435cc0:	.word	0x00000a0a
var_51435cc4:	.word	0x51442fb0
var_51435cc8:	.word	0x51443000
var_51435ccc:	.word	0x5359535b
var_51435cd0:	.word	0x5d4e4f43
var_51435cd4:	.word	0x7272455b
var_51435cd8:	.word	0x3353205d
var_51435cdc:	.word	0x31343643
var_51435ce0:	.word	0x79535f30
var_51435ce4:	.word	0x6e6f4373
var_51435ce8:	.word	0x776f505f
var_51435cec:	.word	0x61477265
var_51435cf0:	.word	0x676e6974
var_51435cf4:	.word	0x70202d20
var_51435cf8:	.word	0x7265776f
var_51435cfc:	.word	0x6d6f645f
var_51435d00:	.word	0x3a6e6961
var_51435d04:	.word	0x20642520
var_51435d08:	.word	0x0000000a
var_51435d0c:	.word	0x5359535b
var_51435d10:	.word	0x5d4e4f43
var_51435d14:	.word	0x7272455b
var_51435d18:	.word	0x3353205d
var_51435d1c:	.word	0x31343643
var_51435d20:	.word	0x79535f30
var_51435d24:	.word	0x6e6f4373
var_51435d28:	.word	0x7465475f
var_51435d2c:	.word	0x6c504d41
var_51435d30:	.word	0x756f466c
var_51435d34:	.word	0x20292874
var_51435d38:	.word	0x4946202d
var_51435d3c:	.word	0x000a204e
var_51435d40:	.word	0x51442d8c
var_51435d44:	.word	0x51443054
var_51435d48:	.word	0x51446d48
var_51435d4c:	.word	0x5359535b
var_51435d50:	.word	0x5d4e4f43
var_51435d54:	.word	0x7272455b
var_51435d58:	.word	0x3353205d
var_51435d5c:	.word	0x31343643
var_51435d60:	.word	0x79535f30
var_51435d64:	.word	0x6e6f4373
var_51435d68:	.word	0x7465475f
var_51435d6c:	.word	0x6c6c5045
var_51435d70:	.word	0x74756f46
var_51435d74:	.word	0x2d202928
var_51435d78:	.word	0x4e494620
var_51435d7c:	.word	0x00000a20
var_51435d80:	.word	0x7e00f000
var_51435d84:	.word	0x7f00c0f8
var_51435d88:	.word	0x51442e58
var_51435d8c:	.word	0x514430a4
var_51435d90:	.word	0x83ff3f07
var_51435d94:	.word	0x5359535b
var_51435d98:	.word	0x5d4e4f43
var_51435d9c:	.word	0x7272455b
var_51435da0:	.word	0x3353205d
var_51435da4:	.word	0x31343643
var_51435da8:	.word	0x79535f30
var_51435dac:	.word	0x6e6f4373
var_51435db0:	.word	0x7465475f
var_51435db4:	.word	0x74756f46
var_51435db8:	.word	0x2d202928
var_51435dbc:	.word	0x4e494620
var_51435dc0:	.word	0x00000a20

sub_51435dc4:
	ldr	r1, var_51435d80
	ldr	r1, [r1, #28]
	tst	r1, #1	
	beq	ret_51435ddc 
	mov	r1, #62	// 0x3e
	b	sub_51435c54 
ret_51435ddc:
	bx	lr

sub_51435de0:
	ldr	r1, var_51435d80 
	ldr	r1, [r1, #28]
	tst	r1, #2	
	beq	ret_51435df8
	mov	r1, #63	// 0x3f
	b	sub_51435c54 
ret_51435df8:
	bx	lr

sub_51435dfc:
	stmdb	sp!, {r4, lr}
	bl	sub_51435de0
	ldr	r1, var_51435d80 
	ldr	r1, [r1, #32]
	and	r1, r1, #16	// 0x10
	mov	r2, #1
	ldmia	sp!, {r4, lr}	// 0x51435e14

sub_51435e18:
	add	r1, r2, r1, lsr #4
	b	sub_5143fee8

sub_51435e20:
	ldr	r1, var_51435d80
	ldr	r1, [r1, #28]
	tst	r1, #4
	beq	_51435e38
	mov	r1, #64	// 0x40
	b	sub_51435c54
ret_51435e38:
	bx	lr

sub_51435e3c:
	stmdb	sp!, {r4, lr}
	ldr	r4, var_51435d80
	ldr	r1, [r4, #2304]
	tst	r1, #64	// 0x40
	beq	_51435e58
	bl	sub_51435dc4
	b	_51435e5c
_51435e58:
	bl	sub_51435de0
_51435e5c:
	ldr	r1, [r4, #2100]
	tst	r1, #0x80000
	beq	_51435e70
	mov	r1, #5
	bl	sub_5143fee8
_51435e70:
	ldr	r1, [r4, #32]
	and	r1, r1, #0xe00
	mov	r2, #1
ret_51435e7c:
	ldmia	sp!, {r4, lr}





/*
 *  51436000
 */

sub_514362b4:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r4, r1
	ldr	r5, var_51435d80
	cmp	r0, #67	// 0x43
	addls	pc, pc, r0, lsl #2
_514362c8:	b	_5143675c
_514362cc:	b	_5143675c
_514362d0:	b	_51436408
_514362d4:	b	_51436408
_514362d8:	b	_51436408
_514362dc:	b	_5143669c
_514362e0:	b	_514363dc
_514362e4:	b	_51436408
_514362e8:	b	_51436408
_514362ec:	b	_51436408
_514362f0:	b	_51436408
_514362f4:	b	_51436408
_514362f8:	b	_51436408
_514362fc:	b	_51436408
_51436300:	b	_51436408
_51436304:	b	_51436408
_51436308:	b	_51436408
_5143630c:	b	_5143640c
_51436310:	b	_51436490
_51436314:	b	_514364c0
_51436318:	b	_51436408
_5143631c:	b	_51436408
_51436320:	b	_51436408
_51436324:	b	_514364f0
_51436328:	b	_51436520
_5143632c:	b	_51436408
_51436330:	b	_51436408
_51436334:	b	_51436408
_51436338:	b	_51436408
_5143633c:	b	_51436550
_51436340:	b	_51436408
_51436344:	b	_51436580
_51436348:	b	_51436408
_5143634c:	b	_514365b0
_51436350:	b	_51436408
_51436354:	b	_51436408
_51436358:	b	_51436408
_5143635c:	b	_514364f0
_51436360:	b	_51436520
_51436364:	b	_51436408
_51436368:	b	_51436408
_5143636c:	b	_51436408
_51436370:	b	_51436408
_51436374:	b	_514365dc
_51436378:	b	_51436408
_5143637c:	b	_51436408
_51436380:	b	_5143660c
_51436384:	b	_51436408
_51436388:	b	_51436408
_5143638c:	b	_51436408
_51436390:	b	_51436408
_51436394:	b	_51436408
_51436398:	b	_51436408
_5143639c:	b	_51436408
_514363a0:	b	_51436408
_514363a4:	b	_5143663c
_514363a8:	b	_5143663c
_514363ac:	b	_5143663c
_514363b0:	b	_5143663c
_514363b4:	b	_5143666c
_514363b8:	b	_51436408
_514363bc:	b	_51436408
_514363c0:	b	_5143675c
_514363c4:	b	_5143675c
_514363c8:	b	_514366cc
_514363cc:	b	_51436408
_514363d0:	b	_514366fc
_514363d4:	b	_51436408
_514363d8:	b	_5143672c


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
	b	_51437f4c 		// JUMPTABLE !!!!!
	b	_51437f4c 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437e9c 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437824 
	b	_514378c0 
	b	_5143795c 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437afc 
	b	_51437b98 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437c34 
	b	_51437f64 
	b	_51437dd8 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437afc 
	b	_51437b98 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437e1c 
	b	_51437e1c 
	b	_51437e1c 
	b	_51437e1c 
	b	_51437f64 
	b	_51437f64 
	b	_51437f64 
	b	_51437f4c 
	b	_51437ecc 
	b	_51437edc 
	b	_51437eec 
	b	_51437efc 
	b	_51437f0c 
	b	_51437f2c 	// 0x51437820
 
_51437824:
	mov	r0, r4
	bl	sub_51433dbc
	cmp	r0, #1
	bne	_514378b4
	mov	r4, #0
	ldr	r0, [r5, #28]
	and	r0, r0, #0xc0000
	movs	r0, r0, lsr #18
	beq	_51437868 
	cmp	r0, #1
	beq	_51437878 
	cmp	r0, #2
	beq	_51437888 
	cmp	r0, #3
	bne	_51437890 
	mov	r4, r8
	b	_51437898 
_51437868:
	mov	r0, r7
	bl	sub_51435e20
	mov	r4, r0
	b	_51437898 
_51437878:
	mov	r0, r7
	bl	sub_51435dfc 
	mov	r4, r0
	b	_51437898
_51437888:
	mov	r4, r7
	b	_51437898
_51437890:
	add	r0, pc, #348	// 0x15c	// !!!! PC relative 0x51437890 + 0x15c
	bl	sub_51403564
_51437898:
	ldr	r0, [r5, #36]
	and	r0, r0, #15	// 0xf
	add	r1, r0, #1
	mov	r0, r4
	bl	sub_5143fee8
	mov	r9, r0
	b	_51437f64
_514378b4:
	add	r0, pc, #372	// 0x174	// !!!! PC relative 0x514378b4 + 0x174
	bl	sub_51403564
	b	_51437f64

_514378c0:
	mov	r0, r4
	bl	sub_51433dbc
	cmp	r0, #1	
	bne	_51437950
	mov	r4, #0
	ldr	r0, [r5, #28]
	and	r0, r0, #0x300000
	movs	r0, r0, lsr #20
	beq	_51437904
	cmp	r0, #1
	beq	_51437914
	cmp	r0, #2
	beq	_51437924
	cmp	r0, #3
	bne	_5143792c 
	mov	r4, r8
	b	_51437934
_51437904:
	mov	r0, r7
	bl	sub_51435e20
	mov	r4, r0
	b	_51437934
_51437914:
	mov	r0, r7
	bl	sub_51435dfc
	mov	r4, r0
	b	_51437934
_51437924:
	mov	r4, r7
	b	_51437934
_5143792c:
	add	r0, pc, #288	// 0x120	// !!!! PC relative 0x5143792c + 0x120
	bl	sub_51403564
_51437934:
	ldr	r0, [r5, #36]
	and	r0, r0, #240	// 0xf0
	add	r1, r6, r0, lsr #4
	mov	r0, r4
	bl	sub_5143fee8
	mov	r9, r0
	b	_51437f64
_51437950:
	add	r0, pc, #312	// 0x138	// !!!! PC relative 0x51437950 + 0x138
	bl	sub_51403564
	b	_51437f64

_5143795c:
	mov	r0, r4
	bl	sub_51433dbc
	cmp	r0, #1
	bne	_51437af0
	mov	r4, #0
	ldr	r0, [r5, #28]
	and	r0, r0, #0xc00000
	movs	r0, r0, lsr #22
	beq	_514379a0
	cmp	r0, #1
	beq	_514379b0
	cmp	r0, #2
	beq	_514379c0 
	cmp	r0, #3
	bne	_514379c8
	mov	r4, r8
	b	_514379d0
_514379a0:
	mov	r0, r7
	bl	sub_51435e20 
	mov	r4, r0
	b	_514379d0
_514379b0:
	mov	r0, r7
	bl	sub_51435dfc
	mov	r4, r0
	b	_514379d0
_514379c0:
	mov	r4, r7
	b	_514379d0
_514379c8:
	add	r0, pc, #228	// 0xe4	// !!!! PC relative 0x514379c8 + 0xe4
	bl	sub_51403564
_514379d0:
	ldr	r0, [r5, #36]
	and	r0, r0, #3840	// 0xf00
	add	r1, r6, r0, lsr #8
	mov	r0, r4
	bl	sub_5143fee8
	mov	r9, r0
	b	_51437f64	// 0x514379e8

var_514379ec:	.word	0x00006978
var_514379f0:	.word	0x00002ee0
var_514379f4:	.word	0x5359535b
var_514379f8:	.word	0x5d4e4f43
var_514379fc:	.word	0x7272455b
var_51437a00:	.word	0x3353205d
var_51437a04:	.word	0x31343643
var_51437a08:	.word	0x79535f30
var_51437a0c:	.word	0x6e6f4373
var_51437a10:	.word	0x7672445f
var_51437a14:	.word	0x7465475f
var_51437a18:	.word	0x636f6c43
var_51437a1c:	.word	0x202d206b
var_51437a20:	.word	0x43535953
var_51437a24:	.word	0x485f4e4f
var_51437a28:	.word	0x434d4d53
var_51437a2c:	.word	0x000a2030
var_51437a30:	.word	0x5359535b
var_51437a34:	.word	0x5d4e4f43
var_51437a38:	.word	0x4742445b
var_51437a3c:	.word	0x5348205d
var_51437a40:	.word	0x30434d4d
var_51437a44:	.word	0x6f6c4320
var_51437a48:	.word	0x47206b63
var_51437a4c:	.word	0x6e697461
var_51437a50:	.word	0x000a2067
var_51437a54:	.word	0x5359535b
var_51437a58:	.word	0x5d4e4f43
var_51437a5c:	.word	0x7272455b
var_51437a60:	.word	0x3353205d
var_51437a64:	.word	0x31343643
var_51437a68:	.word	0x79535f30
var_51437a6c:	.word	0x6e6f4373
var_51437a70:	.word	0x7672445f
var_51437a74:	.word	0x7465475f
var_51437a78:	.word	0x636f6c43
var_51437a7c:	.word	0x202d206b
var_51437a80:	.word	0x43535953
var_51437a84:	.word	0x485f4e4f
var_51437a88:	.word	0x434d4d53
var_51437a8c:	.word	0x000a2031
var_51437a90:	.word	0x5359535b
var_51437a94:	.word	0x5d4e4f43
var_51437a98:	.word	0x4742445b
var_51437a9c:	.word	0x5348205d
var_51437aa0:	.word	0x31434d4d
var_51437aa4:	.word	0x6f6c4320
var_51437aa8:	.word	0x47206b63
var_51437aac:	.word	0x6e697461
var_51437ab0:	.word	0x000a2067
var_51437ab4:	.word	0x5359535b
var_51437ab8:	.word	0x5d4e4f43
var_51437abc:	.word	0x7272455b
var_51437ac0:	.word	0x3353205d
var_51437ac4:	.word	0x31343643
var_51437ac8:	.word	0x79535f30
var_51437acc:	.word	0x6e6f4373
var_51437ad0:	.word	0x7672445f
var_51437ad4:	.word	0x7465475f
var_51437ad8:	.word	0x636f6c43
var_51437adc:	.word	0x202d206b
var_51437ae0:	.word	0x43535953
var_51437ae4:	.word	0x485f4e4f
var_51437ae8:	.word	0x434d4d53
var_51437aec:	.word	0x000a2032

_51437af0:
	add	r0, pc, #404	// 0x194	// !!!! PC relative 0x5137af0 + 0x194
	bl	sub_51403564
	b	_51437f64	// 0x51437af8

_51437afc:
	mov	r0, r4
	bl	sub_51433dbc
	cmp	r0, #1
	bne	_51437b8c
	mov	r4, #0
	ldr	r0, [r5, #28]
	and	r0, r0, #896	// 0x380
	mov	r0, r0, lsr #7
	cmp	r0, #5
	addls	pc, pc, r0, lsl #2		// Jumptable
_51437b24:	
	b	_51437b68
_51437b28:	
	b	_51437b40
_51437b2c:	
	b	_51437b50
_51437b30:	
	b	_51437b60
_51437b34:	
	b	_51437b70
_51437b38:	
	b	_51437b70
_51437b3c:	
	b	_51437b70
_51437b40:
	mov	r0, r7
	bl	sub_51435e20
	mov	r4, r0
	b	_51437b70
_51437b50:
	mov	r0, r7
	bl	sub_51435dfc
	mov	r4, r0
	b	_51437b70
_51437b60:
	mov	r4, r7
	b	_51437b70
_51437b68:
	add	r0, pc, #320	// 0x140	// !!!! PC relative 0x5137b68 + 0x140
	bl	sub_51403564
_51437b70:
	ldr	r0, [r5, #40]
	and	r0, r0, #3840	// 0xf00
	add	r1, r6, r0, lsr #8
	mov	r0, r4
	bl	sub_5143fee8
	mov	r9, r0
	b	sub_51437f64
_51437b8c:
	add	r0, pc, #344	// 0x158	// !!!! PC relative 0x5137b8c + 0x158
	bl	sub_51403564
	b	_51437f64	// 0x51437b94

_51437b98:
	mov	r0, r4
	bl	sub_51433dbc
	cmp	r0, #1	
	bne	_51437c28 
	mov	r4, #0	
	ldr	r0, [r5, #28]
	and	r0, r0, #7168	// 0x1c00
	mov	r0, r0, lsr #10
	cmp	r0, #5
	addls	pc, pc, r0, lsl #2		// JUMPTABLE
_51437bc0:	
	b	_51437c04
_51437bc4:	
	b	_51437bdc
_51437bc8:	
	b	_51437bec
_51437bcc:	
	b	_51437bfc
_51437bd0:	
	b	_51437c0c
_51437bd4:	
	b	_51437c0c
_51437bd8:	
	b	_51437c0c

_51437bdc:
	mov	r0, r7
	bl	sub_51435e20
	mov	r4, r0
	b	_51437c0c
_51437bec:
	mov	r0, r7
	bl	sub_51435dfc
	mov	r4, r0
	b	_51437c0c
_51437bfc:
	mov	r4, r7
_51437c00:
	b	_51437c0c
_51437c04:
	add	r0, pc, #260	// 0x104	// !!!! PC relative 0x5137c04 + 0x104
	bl	sub_51403564
_51437c0c:
	ldr	r0, [r5, #40]
	and	r0, r0, #61440	// 0xf000
	add	r1, r6, r0, lsr #12
	mov	r0, r4
	bl	sub_5143fee8
	mov	r9, r0
	b	_51437f64
_51437c28:
	add	r0, pc, #284	// 0x11c	// !!!! PC relative 0x5137c28 + 0x11c
	bl	sub_51403564
	b	_51437f64	// 0x51437c30

_51437c34:
	mov	r0, r4
	bl	sub_51433dbc
	cmp	r0, #1	
	bne	_51437dcc
	ldr	r0, [r5, #28]
	and	r0, r0, #0xc000000
	movs	r0, r0, lsr #26
	beq	_51437dac 
	cmp	r0, #1
	beq	_51437dbc 
	cmp	r0, #2
	beq	_51437c70
	mov	r7, #0
	add	r0, pc, #256	// 0x100	// !!!! PC relative 0x5137c68 + 0x100
	bl	sub_51403564
_51437c70:
	ldr	r0, [r5, #36]
	and	r0, r0, #0xf000
	add	r1, r6, r0, lsr #12
	mov	r0, r7
	bl	sub_5143fee8
	mov	r9, r0
	b	_51437f64	// 0x51437c88

var_51437c8c:	.word	0x5359535b
var_51437c90:	.word	0x5d4e4f43
var_51437c94:	.word	0x4742445b
var_51437c98:	.word	0x5348205d
var_51437c9c:	.word	0x32434d4d
var_51437ca0:	.word	0x6f6c4320
var_51437ca4:	.word	0x47206b63
var_51437ca8:	.word	0x6e697461
var_51437cac:	.word	0x000a2067
var_51437cb0:	.word	0x5359535b
var_51437cb4:	.word	0x5d4e4f43
var_51437cb8:	.word	0x7272455b
var_51437cbc:	.word	0x3353205d
var_51437cc0:	.word	0x31343643
var_51437cc4:	.word	0x79535f30
var_51437cc8:	.word	0x6e6f4373
var_51437ccc:	.word	0x7672445f
var_51437cd0:	.word	0x7465475f
var_51437cd4:	.word	0x636f6c43
var_51437cd8:	.word	0x202d206b
var_51437cdc:	.word	0x43535953
var_51437ce0:	.word	0x415f4e4f
var_51437ce4:	.word	0x4f494455
var_51437ce8:	.word	0x000a2030
var_51437cec:	.word	0x5359535b
var_51437cf0:	.word	0x5d4e4f43
var_51437cf4:	.word	0x4742445b
var_51437cf8:	.word	0x5541205d
var_51437cfc:	.word	0x304f4944
var_51437d00:	.word	0x6f6c4320
var_51437d04:	.word	0x47206b63
var_51437d08:	.word	0x6e697461
var_51437d0c:	.word	0x000a2067
var_51437d10:	.word	0x5359535b
var_51437d14:	.word	0x5d4e4f43
var_51437d18:	.word	0x7272455b
var_51437d1c:	.word	0x3353205d
var_51437d20:	.word	0x31343643
var_51437d24:	.word	0x79535f30
var_51437d28:	.word	0x6e6f4373
var_51437d2c:	.word	0x7672445f
var_51437d30:	.word	0x7465475f
var_51437d34:	.word	0x636f6c43
var_51437d38:	.word	0x202d206b
var_51437d3c:	.word	0x43535953
var_51437d40:	.word	0x415f4e4f
var_51437d44:	.word	0x4f494455
var_51437d48:	.word	0x000a2031
var_51437d4c:	.word	0x5359535b
var_51437d50:	.word	0x5d4e4f43
var_51437d54:	.word	0x4742445b
var_51437d58:	.word	0x5541205d
var_51437d5c:	.word	0x314f4944
var_51437d60:	.word	0x6f6c4320
var_51437d64:	.word	0x47206b63
var_51437d68:	.word	0x6e697461
var_51437d6c:	.word	0x000a2067
var_51437d70:	.word	0x5359535b
var_51437d74:	.word	0x5d4e4f43
var_51437d78:	.word	0x7272455b
var_51437d7c:	.word	0x3353205d
var_51437d80:	.word	0x31343643
var_51437d84:	.word	0x79535f30
var_51437d88:	.word	0x6e6f4373
var_51437d8c:	.word	0x7672445f
var_51437d90:	.word	0x7465475f
var_51437d94:	.word	0x636f6c43
var_51437d98:	.word	0x202d206b
var_51437d9c:	.word	0x43535953
var_51437da0:	.word	0x4c5f4e4f
var_51437da4:	.word	0x0a204443
var_51437da8:	.word	0x00000000

_51437dac:
	mov	r0, r7
	bl	sub_51435e20
	mov	r7, r0
	b	_51437c70
_51437dbc:
	mov	r0, r7
	bl	sub_51435dfc 
	mov	r7, r0
	b	_51437c70 
_51437dcc:
	add	r0, pc, #424	// 0x1a8	// !!!! PC relative 0x51437dcc + 0x1a8
	bl	sub_51403564 
	b	_51437f64 
_51437dd8:
	mov	r0, r4
	bl	sub_51433dbc 
	cmp	r0, #1
	bne	_51437e10 
	ldr	r0, [r5, #28]
	tst	r0, #16	
	bne	_51437f64 
	mov	r0, r7
	bl	sub_51435e3c
	ldr	r1, [r5, #32]
	add	r1, r6, r1, lsr #28
	bl	sub_5143fee8 
	mov	r9, r0
	b	_51437f64
_51437e10:
	add	r0, pc, #392	// 0x188	// !!!! PC relative 0x51437e10 + 0x188
	bl	sub_51403564 
	b	_51437f64 
_51437e1c:
	mov	r0, r4
_51437e20:
	bl	sub_51433dbc 
	cmp	r0, #1	
	bne	_51437e8c 
	ldr	r0, [r5, #28]
	and	r0, r0, #0x2000
	movs	r0, r0, lsr #13
	beq	_51437e54 
	cmp	r0, #1
	bne	_51437e64 
	mov	r0, r7
	bl	sub_51435dfc 
	mov	r4, r0
	b	_51437e70 
_51437e54:
	mov	r0, r7
	bl	sub_51435e20 
	mov	r4, r0
	b	_51437e70 
_51437e64:
	mov	r4, #0
	add	r0, pc, #340	// 0x154	// !!!! PC relative 0x51437e68 + 0x154
	bl	sub_51403564
_51437e70:
	ldr	r0, [r5, #40]
	and	r0, r0, #0xf0000
	add	r1, r6, r0, lsr #16
	mov	r0, r4
	bl	sub_5143fee8
	mov	r9, r0
	b	_51437f64
_51437e8c:
	sub	r1, r4, #54	// 0x36
	add	r0, pc, #360	// 0x168
	bl	sub_51403564
	b	_51437f64
_51437e9c:
	mov	r0, r7
	bl	sub_51435dc4
	ldr	r1, [r5, #2100]
	tst	r1, #0x80000
	beq	_51437eb4
	mov	r0, r0, lsr #1
_51437eb4:
	ldr	r1, [r5, #32]
	and	r1, r1, #15	// 0xf
	add	r1, r1, #1
	bl	sub_5143fee8
	mov	r9, r0
	b	_51437f64
_51437ecc:
	mov	r0, r7
	bl	sub_51435dc4 
	mov	r9, r0
	b	_51437f64
_51437edc:
	mov	r0, r7
	bl	sub_51435dfc 
	mov	r9, r0
	b	_51437f64
_51437eec:
	mov	r0, r7
	bl	sub_51435e20
	mov	r9, r0
	b	_51437f64
_51437efc:
	mov	r0, r7
	bl	sub_51435e3c
	mov	r9, r0
	b	_51437f64
_51437f0c:
	mov	r0, r7
	bl	sub_51435e3c
	ldr	r1, [r5, #32]
	and	r1, r1, #256	// 0x100
	add	r1, r6, r1, lsr #8
	bl	sub_5143fee8
	mov	r9, r0
	b	_51437f64 
_51437f2c:
	mov	r0, r7
	bl	sub_51435e3c
	ldr	r1, [r5, #32]
	and	r1, r1, #0xf000
	add	r1, r6, r1, lsr #12
	bl	sub_5143fee8
	mov	r9, r0
	b	_51437f64
_51437f4c:
	add	r0, pc, #208	// 0xd0	// !!!! PC relative 0x51437f4c + 0xd0
	bl	sub_51403564 
	ldr	r0, var_5143736c
	ldr	r1, [r0]
	orr	r1, r1, #0x20000
	str	r1, [r0]
_51437f64:
	mov	r0, r9
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}	// 0x51437f68


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
	b	_51438194
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
 *  5143f000
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
_5143f1b8:
	strmib	r2, [r0], #1
	mov	pc, lr

sub_5143f1c0:
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
