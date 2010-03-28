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

#define TEST_OBOOT	0

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
#if TEST_OBOOT
	b	_init2
#else
	b	_init_start_qi
#endif
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
 



sub_51401880:
	ldr	r2, var_51401890
	str	r1, [r2, r0, lsl #2]
	bx	lr	// 0x51401888

var_5140188c:	.word	0x514449a0
var_51401890:	.word	0x514470fc
var_51401894:	.word	0x71200000
var_51401898:	.word	0x4f4f425b
var_5140189c:	.word	0x455b5d54
var_514018a0:	.word	0x205d7272
var_514018a4:	.word	0x6e6b6e55
var_514018a8:	.word	0x206e776f
var_514018ac:	.word	0x20515249
var_514018b0:	.word	0x29642528
var_514018b4:	.word	0x000d0a20

sub_514018b8:
	stmdb	sp!, {r4, lr}
	add	r0, pc, #504	// 0x1f8	// PC rel 0x514018bc + 0x1f8 = 0x51401ab4
	bl	SimpleDebugPrint
_514018c4:
	b	_514018c4

sub_514018c8:
	ldr	r1, var_51401ad0
	mov	r3, #0	
_514018d0:
	ldr	r2, [r1, #136]
	ldr	ip, [r1, #136]
	and	r2, r2, #15	// 0xf
	mov	ip, ip, lsr #4
	add	ip, ip, ip, lsl #2
	add	r2, r2, ip, lsl #1
	add	r2, r2, #2000	//0x7d0
	strh	r2, [r0]
	ldr	r2, [r1, #132]
	ldr	ip, [r1, #132]
	and	r2, r2, #15	// 0xf
	mov	ip, ip, lsl #27
	mov	ip, ip, lsr #31
	add	ip, ip, ip, lsl #2
	add	r2, r2, ip, lsl #1
	strh	r2, [r0, #2]
	ldr	r2, [r1, #124]
	ldr	ip, [r1, #124]
	and	r2, r2, #15	// 0xf
	mov	ip, ip, lsl #26
	mov	ip, ip, lsr #30
	add	ip, ip, ip, lsl #2
	add	r2, r2, ip, lsl #1
	strh	r2, [r0, #6]
	ldr	r2, [r1, #128]
	sub	r2, r2, #1	
	strh	r2, [r0, #4]
	ldr	r2, [r1, #120]
	ldr	ip, [r1, #120]
	and	r2, r2, #15	// 0xf
	mov	ip, ip, lsl #26
	mov	ip, ip, lsr #30
	add	ip, ip, ip, lsl #2
	add	r2, r2, ip, lsl #1
	strh	r2, [r0, #8]
	ldr	r2, [r1, #116]
	ldr	ip, [r1, #116]
	and	r2, r2, #15	// 0xf
	mov	ip, ip, lsl #25
	mov	ip, ip, lsr #29
	add	ip, ip, ip, lsl #2
	add	r2, r2, ip, lsl #1
	strh	r2, [r0, #10]
	ldr	r2, [r1, #112]
	ldr	ip, [r1, #112]
	and	r2, r2, #15	// 0xf
	mov	ip, ip, lsl #25
	mov	ip, ip, lsr #29
	add	ip, ip, ip, lsl #2
	add	r2, r2, ip, lsl #1
	strh	r2, [r0, #12]
	strh	r3, [r0, #14]
	cmp	r2, #0	
	beq	_514018d0
	mov	r0, #1
	bx	lr	// 0x514019ac

sub_514019b0:
	stmdb	sp!, {r0, r1, r2, r3, lr}
	mov	r0, sp
	bl	sub_514018c8
	ldrh	r0, [sp, #2]
	ldrh	r1, [sp, #6]
	rsb	r0, r0, r0, lsl #5
	add	r0, r0, r1
	ldrh	r1, [sp, #8]
	add	r0, r0, r0, lsl #1
	add	r0, r1, r0, lsl #3
	ldrh	r1, [sp, #10]
	rsb	r0, r0, r0, lsl #4
	add	r0, r1, r0, lsl #2
	ldrh	r1, [sp, #12]
	rsb	r0, r0, r0, lsl #4
	add	r0, r1, r0, lsl #2
	ldmia	sp!, {r1, r2, r3, ip, pc}	// 0x514019f0

sub_514019f4:
	stmdb	sp!, {r4, lr}
	mov	r4, r0
	cmp	r4, #0
	beq	_51401a0c
	add	r1, pc, #200	// 0xc8		// PC rel 0x51401a04 + 0xc8 = 0x51401acc
	b	_51401a10
_51401a0c:
	add	r1, pc, #196	// 0xc4		// PC rel 0x51401a0c + 0xc4 = 0x51401ad0
_51401a10:
	add	r0, pc, #196	// 0xc4		// PC rel 0x51401a10 + 0xc4 = 0x51401ad4
	bl	SimpleDebugPrint
	mov	r1, #1	
	mov	r0, #115	// 0x73
	bl	value_table_sub_A 
	cmp	r4, #0	
	beq	_51401a44
	mov	r1, #1	
	mov	r0, #115	// 0x73
	bl	value_table_sub_B
	ldmia	sp!, {r4, lr}
	mov	r0, #1	
	b	sub_51415668 
_51401a44:
	mov	r1, #0
	mov	r0, #115	// 0x73
	bl	value_table_sub_B
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
	add	r1, pc, #96	// 0x60	// PC rel 0x51401a6c + 0x60 = 0x51401acc
	b	_51401a78
_51401a74:
	add	r1, pc, #92	// 0x5c	// PC rel 0x51401a74 + 0x5c = 0x51401ad0
_51401a78:
	add	r0, pc, #112	// 0x70	// PC rel 0x51401a78 + 0x70 = 0x51401ae4
	bl	SimpleDebugPrint 
	mov	r1, #1	
	mov	r0, #180	// 0xb4
	bl	value_table_sub_A 
	cmp	r4, #0
	beq	ret_51401aac
	add	r0, pc, #104	// 0x68	// PC rel 0x51401a94 + 0x68 = 0x51401afc
	bl	SimpleDebugPrint
	ldmia	sp!, {r4, lr}
	mov	r1, #0
	mov	r0, #180	// 0xb4
	b	value_table_sub_B 
ret_51401aac:
	ldmia	sp!, {r4, lr}
	mov	r1, #1
	mov	r0, #180	// 0xb4
	b	value_table_sub_B 	// 0x51401ab8

var_51401abc:	.word	0x6e697053
var_51401ac0:	.word	0x65726f46
var_51401ac4:	.word	0x2e726576
var_51401ac8:	.word	0x0a0d2e2e
var_51401acc:	.word	0x00000000
var_51401ad0:	.word	0x7e005000
var_51401ad4:	.word	0x00005043
var_51401ad8:	.word	0x00005041
var_51401adc:	.word	0x53425355
var_51401ae0:	.word	0x63746977
var_51401ae4:	.word	0x203a2068
var_51401ae8:	.word	0x0a207325
var_51401aec:	.word	0x00000000
var_51401af0:	.word	0x54524155
var_51401af4:	.word	0x74697753
var_51401af8:	.word	0x3a206863
var_51401afc:	.word	0x20732520
var_51401b00:	.word	0x0000000a
var_51401b04:	.word	0x72726157
var_51401b08:	.word	0x20676e69
var_51401b0c:	.word	0x5041203a
var_51401b10:	.word	0x52415520
var_51401b14:	.word	0x69642054
var_51401b18:	.word	0x6c626173
var_51401b1c:	.word	0x21212065
var_51401b20:	.word	0x0a202021
var_51401b24:	.word	0x00000000

LCD_InitWin:
sub_51401b28:
	stmdb	sp!, {r4, lr}
	sub	sp, sp, #40	// 0x28
	bl	load_0x5A0B0004_to_R0 
	ldr	r0, [r0, #48]
	cmp	r0, #2
	bcc	_51401b54
	mov	r1, #0
	mov	r0, #183	// 0xb7
	bl	value_table_sub_A
	mov	r0, #183	// 0xb7
	bl	value_table_sub_C
_51401b54:
	mov	r1, #0
	mov	r0, #3
	bl	sub_51438cec 
	ldr	r4, var_51401d44
	bl	sub_5143dd4c 
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
	bl	sub_51439b54 
	cmp	r0, #0	
	beq	_51401bc8 
	add	r0, pc, #392	// 0x188	// !!!! PC relative 0x51401bb8 + 0x188
	bl	SimpleDebugPrint
_51401bc0:
	add	sp, sp, #40	// 0x28
	ldmia	sp!, {r4, pc}
_51401bc8:
	mov	r1, #1
	mov	r0, #0
	bl	sub_5143c5e8
	b	_51401bc0	// 0x51401bd4

sub_51401bd8:
	stmdb	sp!, {r4, lr}
	bl	sub_5142fc84 
	bl	sub_5143234c 
	cmp	r0, #0
	beq	_51401bfc 
	add	r0, pc, #376	// 0x178	// !!!! PC relative 0x51401bec + 0x178
	bl	SimpleDebugPrint 
	mov	r0, #0	
ret_51401bf8:
	ldmia	sp!, {r4, pc}
_51401bfc:
	mov	r0, #0
	bl	sub_514323f4
	cmp	r0, #0	
	beq	_51401c1c
	add	r0, pc, #364	// 0x16c	// !!!! PC relative 0x51401c0c + 0x16c
	bl	SimpleDebugPrint 
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

OneNAND_Init:	// sub_51401c3c:	
	stmdb	sp!, {r2, r3, r4, r5, r6, r7, r8, lr}
	bl	sub_51431168
	bl	sub_51401788
	bl	sub_51430594
	bl	sub_51438b94
	bl	sub_5140146c
	bl	sub_51403dc8
	bl	pmic_reading_writing_B
	bl	PMIC_set_reg_SIMLTEN
	mov	r1, #1
	mov	r0, #175	// 0xaf
	bl	value_table_sub_A
	mov	r1, #0
	mov	r0, #175	// 0xaf
	bl	value_table_sub_B
	mov	r0, #0	
	bl	sub_51401a5c 
	mov	r0, #0	
	bl	sub_514019f4
	mov	r0, #1	
	bl	sub_5141ade0
_51401c90:
	add	r0, pc, #252	// 0xfc		// !!!! PC relative 0x51401c90 + 0xfc
	bl	SimpleDebugPrint
	mov	r0, #24	// 0x18
	bl	sub_5141b008
_51401ca0:
	add	r0, pc, #260	// 0x104	// !!!! PC relative 0x51401ca0 + 0x104
	bl	SimpleDebugPrint
	mov	r1, #0
	mov	r0, #4
	bl	sub_514362b4
	bl	sub_51431168
_51401cb8:
	add	r0, pc, #260	// 0x104	// !!!! PC relative 0x51401cb8 + 0x104
	bl	SimpleDebugPrint
	ldr	r0, var_51401de8
	ldr	r0, [r0]
	ldr	r1, [r0, #2308]		// !!!!
_51401ccc:
	add	r0, pc, #280	// 0x118	// !!!! PC relative 0x51401ccc + 0x118
	bl	SimpleDebugPrint
	mov	r0, #67	// 0x43
	bl	SYSCON_related_a
	mov	r4, r0
	mov	r0, #66	// 0x42
	bl	SYSCON_related_a
	mov	r5, r0
	mov	r0, #65	// 0x41
	bl	SYSCON_related_a
	mov	r6, r0
	mov	r0, #63	// 0x3f
	bl	SYSCON_related_a
	mov	r7, r0
	mov	r0, #4
	bl	SYSCON_related_a
	mov	r1, r0
_51401d10:
	add	r0, pc, #256	// 0x100	// PC rel 0x51401d10 + 0x100 = 0x51401e10
	mov	r3, r6
	mov	r2, r7
	str	r4, [sp, #4]
	str	r5, [sp]
	bl	SimpleDebugPrint 
	bl	sub_51401bd8
	cmp	r0, #0	
	bne	ret_51401d40
_51401d34:
	add	r0, pc, #284	// 0x11c	// PC rel 0x51401d34 + 0x11c = 0x51401e50
	bl	SimpleDebugPrint
	bl	sub_514018b8
ret_51401d40:
	ldmia	sp!, {r2, r3, r4, r5, r6, r7, r8, pc}	// 0x51401d40

var_51401d44:	.word	0x5a100000
var_51401d48:	.word	0x4f4f425b
var_51401d4c:	.word	0x455b5d54
var_51401d50:	.word	0x205d7272
var_51401d54:	.word	0x36433353
var_51401d58:	.word	0x5f303134
var_51401d5c:	.word	0x5f44434c
var_51401d60:	.word	0x74696e49
var_51401d64:	.word	0x286e6957
var_51401d68:	.word	0x000a2029
var_51401d6c:	.word	0x4c4e4f0d
var_51401d70:	.word	0x6e495f44
var_51401d74:	.word	0x66207469
var_51401d78:	.word	0x656c6961
var_51401d7c:	.word	0x000a0d64
var_51401d80:	.word	0x4c4e4f0d
var_51401d84:	.word	0x704f5f44
var_51401d88:	.word	0x66206e65
var_51401d8c:	.word	0x656c6961
var_51401d90:	.word	0x000a0d64
var_51401d94:	.word	0x3342425b
var_51401d98:	.word	0x56205d31
var_51401d9c:	.word	0x49204444
var_51401da0:	.word	0x3120544e
var_51401da4:	.word	0x2056322e
var_51401da8:	.word	0x0000000a
var_51401dac:	.word	0x3342425b
var_51401db0:	.word	0x56205d31
var_51401db4:	.word	0x41204444
var_51401db8:	.word	0x31204d52
var_51401dbc:	.word	0x3532332e
var_51401dc0:	.word	0x000a2056
var_51401dc4:	.word	0x52410a0d
var_51401dc8:	.word	0x6c43204d
var_51401dcc:	.word	0x3a6b636f
var_51401dd0:	.word	0x30303420
var_51401dd4:	.word	0x207a484d
var_51401dd8:	.word	0x203e2d2d
var_51401ddc:	.word	0x4d303038
var_51401de0:	.word	0x0d207a48
var_51401de4:	.word	0x0000000a
var_51401de8:	.word	0x514431e0
var_51401dec:	.word	0x4f4f425b
var_51401df0:	.word	0x445b5d54
var_51401df4:	.word	0x205d4742
var_51401df8:	.word	0x5f545352
var_51401dfc:	.word	0x54415453
var_51401e00:	.word	0x37783020
var_51401e04:	.word	0x5f303045
var_51401e08:	.word	0x34303946
var_51401e0c:	.word	0x30203a20
var_51401e10:	.word	0x20582578
var_51401e14:	.word	0x0000000a
var_51401e18:	.word	0x4f4f425b
var_51401e1c:	.word	0x41205d54
var_51401e20:	.word	0x4c434d52
var_51401e24:	.word	0x25203a4b
var_51401e28:	.word	0x4d202c64
var_51401e2c:	.word	0x3a4c4c50
var_51401e30:	.word	0x2c642520
var_51401e34:	.word	0x4c434820
var_51401e38:	.word	0x3a32584b
var_51401e3c:	.word	0x2c642520
var_51401e40:	.word	0x4c434820
var_51401e44:	.word	0x25203a4b
var_51401e48:	.word	0x50202c64
var_51401e4c:	.word	0x3a4b4c43
var_51401e50:	.word	0x20642520
var_51401e54:	.word	0x00000a0d
var_51401e58:	.word	0x4e656e4f
var_51401e5c:	.word	0x5f444e41
var_51401e60:	.word	0x74696e49
var_51401e64:	.word	0x69616620
var_51401e68:	.word	0x0d64656c
var_51401e6c:	.word	0x0000000a

sub_51401e70:
	ldr	r0, var_51402258
	ldr	r0, [r0, #12]
	bx	lr	// 0x51401e78

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
	bl	value_table_sub_A
	mov	r1, #0	
	mov	r0, #162	// 0xa2
	bl	value_table_sub_A 
	mov	r1, #0
	mov	r0, #186	// 0xba
	bl	value_table_sub_A
	mov	r0, #161	// 0xa1
	bl	value_table_sub_C
	mov	r4, r0
	mov	r0, #162	// 0xa2
	bl	value_table_sub_C
	mov	r5, r0
	mov	r0, #186	// 0xba
	bl	value_table_sub_C 
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
	BL      value_table_sub_B
	MOV     R1, #1
	MOV     R0, #0x16
	BL      value_table_sub_A
	MOV     R1, #1
	MOV     R0, #0x16
	BL      value_table_sub_B
	MOV     R1, #1
	MOV     R0, #0xB0 // '¦'
	BL      value_table_sub_B
	MOV     R1, #1
	MOV     R0, #0xB0 // '¦'
	BL      value_table_sub_A
	MOV     R1, #1
	MOV     R0, #0xB0 // '¦'
	BL      value_table_sub_B
	MOV     R1, #2
	MOV     R0, #0x69 // 'i'
	BL	sub_514381c4
	MOV	R1, #0
	MOV	R0, #0x69 // 'i'
	BL	value_table_sub_A
	ldr	r0, var_51403204
	ldr	r1, var_51403208	/// correct????
	cmp	R0, R1
	beq	loc_51403000

	add	r1, r0, #0
	ldr	r0, var_51403208
	ldr	r2, var_5140320c
	bl	memcopy_R2bytes_fromR0_toR1	// okay

loc_51403000:
	ldr	r2, var_51403210 // =0x207F9C
	ldr	r0, var_51403214 // =0x51446DA0 ???
	mov	r1, #0
	bl	memclear_R2bytes_withR1_atR0
	bl	sub_514152f8
	bl	load_0x5A0B0004_to_R0	// load_0x5A0B0004_to_R0
	mov	r4, r0
	bl	sub_514029b0
	str	r0, [R4,#0x30]
	BL      OneNAND_Init
	LDR     R1, [R4,#0x30]
//	ADR     R0, aBoothwcheckD__ // "BootHWCheck: %d...\n"
//	BL      SimpleDebugPrint
	MOV     R0, #0x69 // 'i'
	bl	value_table_sub_C
	CMP     R0, #0
	BEQ     loc_51403064

	LDR     R0, [R4,#0x30]
	CMP     R0, #2
	BCC     loc_51403064

	MOV     R1, SP
	MOV     R0, #0xF
	bl      PMIC_LUT2_read	// read from CHG_IRQ2
//	ADR     R0, aNoBattery  // "NO battery\n"
//	BL      SimpleDebugPrint

loc_51403064:
//	BL      SelectBootingMode
	MOV     R0, #1
	bl      PMIC_set_reg_SRAMEN_MVTEN_LDOAEN
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
	bl      sub_5141ab40	// I2C_something
	bl	Download_Mode_MSG
//	BL      sub_514131A0
//	B       loc_514030E8

//	MOV     R0, #8
//	B       sub_5141804C

//	BL      sub_514185F4
//	BL      Baseband_Init

_continue_with_start_qi:
	b	_init_start_qi
//	b	_continue_with_start_qi

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

SimpleDebugPrint:
sub_51403564:
//
	bx	lr
//
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
	ldr	pc, [sp], #20	// 0x51403744



var_51403a40:	.word	0x514449b8
var_51403a44:	.word	0x51444c08
var_51403a48:	.word	0x252e7525
var_51403a4c:	.word	0x75252e75
var_51403a50:	.word	0x0075252e
var_51403a54:	.word	0x51454800

sub_51403a58:
	bx	lr



var_51403c70:	.word	0x514449bc
var_51403c74:	.word	0x444c4e4f
var_51403c78:	.word	0x6b68435f
var_51403c7c:	.word	0x74696e49
var_51403c80:	.word	0x42646142
var_51403c84:	.word	0x203a6b6c
var_51403c88:	.word	0x20646162
var_51403c8c:	.word	0x636f6c62
var_51403c90:	.word	0x3028206b
var_51403c94:	.word	0x29782578
var_51403c98:	.word	0x000a0d2e
var_51403c9c:	.word	0x51454810
var_51403ca0:	.word	0x65520a0d
var_51403ca4:	.word	0x6e696461
var_51403ca8:	.word	0x61662067
var_51403cac:	.word	0x64656c69
var_51403cb0:	.word	0x00000a0d
var_51403cb4:	.word	0x3d3d3d0a
var_51403cb8:	.word	0x3d3d3d3d
var_51403cbc:	.word	0x3d3d3d3d
var_51403cc0:	.word	0x3d3d3d3d
var_51403cc4:	.word	0x3d3d3d3d
var_51403cc8:	.word	0x3d3d3d3d
var_51403ccc:	.word	0x3d3d3d3d
var_51403cd0:	.word	0x3d3d3d3d
var_51403cd4:	.word	0x000a3d3d
var_51403cd8:	.word	0x6f42200a
var_51403cdc:	.word	0x6544746f
var_51403ce0:	.word	0x42677562
var_51403ce4:	.word	0x4e666675
var_51403ce8:	.word	0x57646e61
var_51403cec:	.word	0x65746972
var_51403cf0:	.word	0x00000a20
var_51403cf4:	.word	0xb007a61c
var_51403cf8:	.word	0x0001ff00
var_51403cfc:	.word	0x51474810
var_51403d00:	.word	0x444c4e4f
var_51403d04:	.word	0x6172455f
var_51403d08:	.word	0x203a6573
var_51403d0c:	.word	0x6c696166
var_51403d10:	.word	0x74206465
var_51403d14:	.word	0x7265206f
var_51403d18:	.word	0x20657361
var_51403d1c:	.word	0x636f6c62
var_51403d20:	.word	0x3028206b
var_51403d24:	.word	0x29782578
var_51403d28:	.word	0x000a0d2e
var_51403d2c:	.word	0x444c4e4f
var_51403d30:	.word	0x6972575f
var_51403d34:	.word	0x203a6574
var_51403d38:	.word	0x6c696166
var_51403d3c:	.word	0x74206465
var_51403d40:	.word	0x7277206f
var_51403d44:	.word	0x20657469
var_51403d48:	.word	0x636f6c62
var_51403d4c:	.word	0x3028206b
var_51403d50:	.word	0x29782578
var_51403d54:	.word	0x000a0d2e

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
	cmp	r1, #0	
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




sub_51403f40:
	stmdb	sp!, {r4, r5, r6, lr}
	sub	sp, sp, #64	// 0x40
	mov	r5, r0
	mov	r6, #0
	add	r0, sp, #48	// 0x30
	mov	r1, #0
	mov	r2, #0
	stmia	r0!, {r1, r2}
	stmia	r0, {r1, r2}
	add	r0, sp, #32	// 0x20
	mov	r1, #0
	mov	r2, #0
	stmia	r0!, {r1, r2}
	stmia	r0, {r1, r2}
	add	r0, sp, #16	// 0x10
	mov	r1, #0
	mov	r2, #0
	stmia	r0!, {r1, r2}
	stmia	r0, {r1, r2}
	mov	r0, sp
	mov	r1, #0
	mov	r2, #0
	stmia	r0!, {r1, r2}
	stmia	r0, {r1, r2}
	ldr	r0, var_5140428c
	ldr	r0, [r0]
	cmp	r0, #0
	beq	_51404280
	mov	r2, #8	
	add	r1, pc, #724	// 0x2d4
	ldr	r0, var_5140429c
	bl	sub_5142fadc 
	mov	r0, #0x11000
	ldr	r1, var_5140429c
	str	r0, [r1, #8]
	mov	r0, #4
	str	r0, [r1, #12]
	mov	r0, #3
	str	r0, [r1, #16]
	mov	r0, #34	// 0x22
	add	r1, r1, #16	// 0x10
	str	r0, [r1, #4]
	mov	r0, #8	
	str	r0, [r1, #8]
	mov	r0, #248	// 0xf8
	str	r0, [r1, #12]
	mov	r0, #0x10000000
	str	r0, [r1, #16]
	mov	r0, #1
	add	r1, r1, #16	// 0x10
	str	r0, [r1, #4]
	mov	r0, #256	// 0x100
	str	r0, [r1, #8]
	mov	r0, #824	// 0x338
	str	r0, [r1, #12]
	mov	r0, #8	
	sub	r1, r1, #16	// 0x10
	str	r0, [r1, #32]
	mov	r0, #1
	add	r1, r1, #32	// 0x20
	str	r0, [r1, #4]
	ldr	r0, var_514042a0
	str	r0, [r1, #8]
	sub	r0, r0, #174	// 0xae
	str	r0, [r1, #12]
	mov	r0, #0x10000001
	sub	r1, r1, #32	// 0x20
	str	r0, [r1, #48]
	mov	r0, #1
	add	r1, r1, #48	// 0x30
	str	r0, [r1, #4]
	ldr	r0, var_514042a4
	str	r0, [r1, #8]
	mov	r0, #16	// 0x10
	str	r0, [r1, #12]
	bl	sub_5141dc50 
	mov	r4, r0	// 0x51404070

/*
 *  51414000
 */

_51404074:
	cmp	r4, #0
	beq	_51404094
	add	ip, r4, #0x7f000000
	adds	ip, ip, #0xee0000
	beq	_51404094
	b	_51404090
_5140408c:
	add	r6, r6, #1
_51404090:
	b	_5140408c
_51404094:
	mov	r0, #0
	bl	sub_5141e174
	cmp	r0, #0
	bne	_514040ac
	cmp	r5, #0
	beq	_5140410c 
_514040ac:
	mov	r0, #1
	ldr	r1, var_514042a8
	str	r0, [r1]
	mov	r2, #0
	ldr	r1, var_5140429c
	mov	r0, #0
	bl	sub_5141df9c 
	mov	r4, r0
	mov	r0, #0
	ldr	r1, var_514042a8
	str	r0, [r1]
	cmp	r4, #0
	beq	_514040ec 
	b	_514040e8 
_514040e4:
	add	r6, r6, #1
_514040e8:
	b	_514040e4 
_514040ec:
	mov	r0, #0
	bl	sub_5141e174 
	mov	r4, r0
	cmp	r4, #0
	beq	_5140410c
	b	_51404108
_51404104:
	add	r6, r6, #1
_51404108:
	b	_51404104
_5140410c:
	add	r2, sp, #48	// 0x30
	mov	r1, #3
	mov	r0, #0
	bl	sub_51420b24 
	add	r2, sp, #16	// 0x10
	mov	r1, #0x10000000
	mov	r0, #0
	bl	sub_51420b24 
	add	r2, sp, #32	// 0x20
	mov	r1, #8
	mov	r0, #0
	bl	sub_51420b24 
	mov	r2, sp
	mov	r1, #0x10000001
	mov	r0, #0
	bl	sub_51420b24 
	ldr	r1, var_514042ac
	ldr	r0, [sp, #24]
	ldr	r1, [r1, #8]
	cmp	r0, r1
	beq	_514041bc
	mov	r0, #0
	bl	sub_5141e294 
	mov	r0, #1
	ldr	r1, var_514042a8
	str	r0, [r1]
	mov	r2, #0
	ldr	r1, var_5140429c
	mov	r0, #0
	bl	sub_5141df9c 
	mov	r4, r0
	mov	r0, #0
	ldr	r1, var_514042a8
	str	r0, [r1]
	cmp	r4, #0
	beq	_514041a4
	nop	
_514041a0:
	b	_514041a0	// infinite loop
_514041a4:
	mov	r0, #0
	bl	sub_5141e174 
	cmp	r0, #0
	beq	_51404254
	nop	
_514041b8:
	b	_514041b8	// infinite loop
_514041bc:
	ldr	r1, var_514042b0
	ldr	r0, [sp, #40]
	ldr	r1, [r1, #8]
	cmp	r0, r1
	bne	_514041f8
	ldr	r1, var_514042b0
	ldr	r0, [sp, #44]
	ldr	r1, [r1, #12]
	cmp	r0, r1
	bne	_514041f8
	ldr	r1, var_514042b4
	ldr	r0, [sp, #8]
	ldr	r1, [r1, #8]
	cmp	r0, r1
	beq	_51404254
_514041f8:
	mov	r0, #0
	bl	sub_5141e294 
	mov	r0, #1
	ldr	r1, var_514042a8
	str	r0, [r1]
	mov	r2, #1
	ldr	r1, var_5140429c
	mov	r0, #0
	bl	sub_5141df9c 
	mov	r4, r0
	mov	r0, #0
	ldr	r1, var_514042a8
	str	r0, [r1]
	cmp	r4, #0
	beq	_5140423c
	nop	
_51404238:
	b	_51404238	// infinite loop
_5140423c:
	mov	r0, #0
	bl	sub_5141e174 
	cmp	r0, #0
	beq	_51404254
	nop	
_51404250:
	b	_51404250	// infinite loop
_51404254:
	mov	r0, #0
	ldr	r1, var_5140428c
	str	r0, [r1]
	mov	r2, #255	// 0xff
	mov	r1, #1936	// 0x790
	ldr	r0, var_514042b8
	bl	sub_5143f0a8
	mov	r1, #0
	ldr	r0, var_514042b8
	bl	sub_514211e0
	mov	r4, r0
_51404280:
	mov	r0, #0
	add	sp, sp, #64	// 0x40
	ldmia	sp!, {r4, r5, r6, pc}	// 0x51404288

var_5140428c:	.word	0x514449e0
var_51404290:	.word	0x50525358
var_51404294:	.word	0x49545241
var_51404298:	.word	0x00000000
var_5140429c:	.word	0x51494810
var_514042a0:	.word	0x00000438
var_514042a4:	.word	0x000007c2
var_514042a8:	.word	0x514449dc
var_514042ac:	.word	0x51494830
var_514042b0:	.word	0x51494840
var_514042b4:	.word	0x51494850
var_514042b8:	.word	0x51495210

sub_514042bc:	// MISSING
	bx	lr

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


load_0x5A0B0004_to_R0:	// sub_51415374:
	ldr	r0, var_51415448
	bx	lr	// 0x51415378




sub_51415668:
	stmdb	sp!, {r4, lr}
	mov	r4, r0
	ldr	r3, var_51415900 
	mov	r2, #101	// 0x65
	mov	r1, #100	// 0x64
	mov	r0, #3	
	bl	j_I2C_GPIO_Line_Open
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
	b	j_I2C_GPIO_Line_Close 	// 0x514156ec

read_from_0x5a0b0034_to_R0:	// sub_514153bc:
	ldr	r0, var_51415448
	ldr	r0, [r0, #48]
	bx	lr	// 0x514153c4




var_5141543c:	.word	0x5a0b0000
var_51415440:	.word	0xb0078aed
var_51415444:	.word	0xb00717e3
var_51415448:	.word	0x5a0b0004



var_514158fc:	.word	0x51445180
var_51415900:	.word	0x000186a0
var_51415904:	.word	0x00002710
var_51415908:	.word	0x65736572
var_5141590c:	.word	0x53462074
var_51415910:	.word	0x38343941
var_51415914:	.word	0x00000a30
var_51415918:	.word	0x39415346
var_5141591c:	.word	0x20303834
var_51415920:	.word	0x33307830
var_51415924:	.word	0x67655220
var_51415928:	.word	0x65747369
var_5141592c:	.word	0x203d2072
var_51415930:	.word	0x0a0d7825
var_51415934:	.word	0x00000000
var_51415938:	.word	0x39415346
var_5141593c:	.word	0x20303834
var_51415940:	.word	0x41307830
var_51415944:	.word	0x67655220
var_51415948:	.word	0x65747369
var_5141594c:	.word	0x203d2072
var_51415950:	.word	0x0a0d7825
var_51415954:	.word	0x00000000
var_51415958:	.word	0x39415346
var_5141595c:	.word	0x20303834
var_51415960:	.word	0x42307830
var_51415964:	.word	0x67655220
var_51415968:	.word	0x65747369
var_5141596c:	.word	0x203d2072
var_51415970:	.word	0x0a0d7825
var_51415974:	.word	0x00000000
var_51415978:	.word	0x39415346
var_5141597c:	.word	0x20303834
var_51415980:	.word	0x37307830
var_51415984:	.word	0x67655220
var_51415988:	.word	0x65747369
var_5141598c:	.word	0x203d2072
var_51415990:	.word	0x0a0d7825
var_51415994:	.word	0x00000000

sub_51415998:	// MISSING
	bx	lr

sub_51415a68:
	stmdb	sp!, {r2, r3, r4, r5, r6, lr}
	mov	r5, #0
	str	r5, [sp, #4]
	bl	load_0x5A0B0004_to_R0
	mov	r4, r0
	mov	r1, #1	
	mov	r0, #181	// 0xb5
	bl	value_table_sub_A
	mov	r1, #1	
	mov	r0, #181	// 0xb5
	bl	value_table_sub_B
	ldr	r0, [r4, #48]
	ldr	r4, var_51415ca8
	ldr	r6, var_51415ca4
	cmp	r0, #2	
	bcc	_51415b24
	ldr	r0, [r4]
	ldr	r0, [r0, #320]
	ldr	r1, [r4]
	bic	r0, r0, #0xc000000
	orr	r0, r0, #0x4000000
	str	r0, [r1, #320]
	ldr	r0, [r4]
	ldr	r0, [r0, #328]
	ldr	r1, [r4]
	bic	r0, r0, #0xc000000
	str	r0, [r1, #328]
	ldr	r0, [r4]
	ldr	r0, [r0, #324]
	ldr	r1, [r4]
	orr	r0, r0, #0x2000
	str	r0, [r1, #324]
	mov	r0, r6
	bl	sub_51430f80
	ldr	r0, [r4]
	ldr	r0, [r0, #324]
	ldr	r1, [r4]
	bic	r0, r0, #0x2000
	str	r0, [r1, #324]
	mov	r0, r6
	bl	sub_51430f80
	ldr	r0, [r4]
	ldr	r0, [r0, #324]
	ldr	r1, [r4]
	orr	r0, r0, #0x2000
	str	r0, [r1, #324]
	b	_51415b9c
_51415b24:
	ldr	r0, [r4]
	ldr	r0, [r0, #288]
	ldr	r1, [r4]
	bic	r0, r0, #48	// 0x30
	orr	r0, r0, #16	// 0x10
	str	r0, [r1, #288]
	ldr	r0, [r4]
	ldr	r0, [r0, #296]
	ldr	r1, [r4]
	bic	r0, r0, #48	// 0x30
	str	r0, [r1, #296]
	ldr	r0, [r4]
	ldr	r0, [r0, #292]
	ldr	r1, [r4]
	orr	r0, r0, #4
	str	r0, [r1, #292]
	mov	r0, r6
	bl	sub_51430f80 
	ldr	r0, [r4]
	ldr	r0, [r0, #292]
	ldr	r1, [r4]
	bic	r0, r0, #4
	str	r0, [r1, #292]
	mov	r0, r6
	bl	sub_51430f80
	ldr	r0, [r4]
	ldr	r0, [r0, #292]
	ldr	r1, [r4]
	orr	r0, r0, #4
	str	r0, [r1, #292]
_51415b9c:
	ldr	r0, var_51415cac
	ldr	r0, [r0]
	cmp	r0, #0	
	beq	_51415bb4
	mov	r0, #1	
	bl	j_I2C_GPIO_Line_Close
_51415bb4:
	ldr	r3, var_51415cb0
	mov	r2, #156	// 0x9c
	mov	r1, #155	// 0x9b
	mov	r0, #1	
	bl	j_I2C_GPIO_Line_Open
	mov	r0, #208	// 0xd0
	strb	r0, [sp, #4]
	strb	r5, [sp, #5]
	mov	r3, #2	
	str	r3, [sp]
	add	r3, sp, #4
	mov	r2, #220	// 0xdc
	mov	r1, #112	// 0x70
	mov	r0, #1	
	bl	I2C_GPIO_tx2
	strb	r5, [sp, #4]
	mov	r0, #1	
	strb	r0, [sp, #5]
	mov	r3, #2	
	str	r3, [sp]
	add	r3, sp, #4	
	mov	r2, #221	// 0xdd
	mov	r1, #112	// 0x70
	bl	I2C_GPIO_tx2
	mov	r0, #1000	// 0x3e8
	bl	sub_51430f80
	mov	r1, #30	// 0x1e
	ldr	r0, var_51415cb4
	bl	sub_51415998
	mov	r0, #1	
	bl	j_I2C_GPIO_Line_Close
ret_51415c30:
	ldmia	sp!, {r2, r3, r4, r5, r6, pc}


/*
_51415c7c:	bx	lr
_51415c80:	bx	lr
_51415c84:	bx	lr
_51415c88:	bx	lr
_51415c8c:	bx	lr
_51415c90:	bx	lr
_51415c94:	bx	lr
_51415c98:	bx	lr
_51415c9c:	bx	lr
*/
var_51415ca0:	.word	0x51445184
var_51415ca4:	.word	0x00001388
var_51415ca8:	.word	0x514431e4
var_51415cac:	.word	0x51445328
var_51415cb0:	.word	0x0000c350
var_51415cb4:	.word	0x5144518c
var_51415cb8:	.word	0x000186a0
var_51415cbc:	.word	0x514452f4



/*
 *  51416000
 */

sub_51416498:
	stmdb	sp!, {r4, lr}
	bl	load_0x5A0B0004_to_R0 
	ldr	r1, [r0, #48]
	ldr	r0, var_51416c0c
	cmp	r1, #2
	bcc	_514165a0
	ldr	r1, [r0]
	ldr	r1, [r1, #320]
	ldr	r2, [r0]
	bic	r1, r1, #0x300000
	orr	r1, r1, #0x100000
	str	r1, [r2, #320]
	ldr	r1, [r0]
	ldr	r1, [r1, #320]
	ldr	r2, [r0]
	bic	r1, r1, #0x3000000
	orr	r1, r1, #0x1000000
	str	r1, [r2, #320]
	ldr	r1, [r0]
	ldr	r1, [r1, #320]
	ldr	r2, [r0]
	bic	r1, r1, #0x3000
	orr	r1, r1, #0x1000
	str	r1, [r2, #320]
	ldr	r1, [r0]
	ldr	r1, [r1, #320]
	ldr	r2, [r0]
	bic	r1, r1, #0xc000
	orr	r1, r1, #0x4000
	str	r1, [r2, #320]
	ldr	r1, [r0]
	ldr	r1, [r1, #328]
	ldr	r2, [r0]
	bic	r1, r1, #0x300000
	str	r1, [r2, #328]
	ldr	r1, [r0]
	ldr	r1, [r1, #328]
	ldr	r2, [r0]
	bic	r1, r1, #0x3000000
	str	r1, [r2, #328]
	ldr	r1, [r0]
	ldr	r1, [r1, #328]
	ldr	r2, [r0]
	bic	r1, r1, #0x3000
	str	r1, [r2, #328]
	ldr	r1, [r0]
	ldr	r1, [r1, #328]
	ldr	r2, [r0]
	bic	r1, r1, #0xc000
	str	r1, [r2, #328]
	ldr	r1, [r0]
	ldr	r1, [r1, #324]
	ldr	r2, [r0]
	orr	r1, r1, #0x40
	str	r1, [r2, #324]
	ldr	r1, [r0]
	ldr	r1, [r1, #324]
	ldr	r2, [r0]
	orr	r1, r1, #0x1000
	str	r1, [r2, #324]
	ldr	r1, [r0]
	ldr	r1, [r1, #324]
	ldr	r0, [r0]
	orr	r1, r1, #0x80
	str	r1, [r0, #324]
	b	_514166a0
_514165a0:
	ldr	r1, [r0]
	ldr	r1, [r1, #256]
	ldr	r2, [r0]
	bic	r1, r1, #0x30000
	orr	r1, r1, #0x10000
	str	r1, [r2, #256]
	ldr	r1, [r0]
	ldr	r1, [r1, #288]
	ldr	r2, [r0]
	bic	r1, r1, #3
	orr	r1, r1, #1
	str	r1, [r2, #288]
	ldr	r1, [r0]
	ldr	r1, [r1, #256]
	ldr	r2, [r0]
	bic	r1, r1, #3
	orr	r1, r1, #1
	str	r1, [r2, #256]
	ldr	r1, [r0]
	ldr	r1, [r1, #256]
	ldr	r2, [r0]
	bic	r1, r1, #12	// 0xc
	orr	r1, r1, #4	// 0x4
	str	r1, [r2, #256]
	ldr	r1, [r0]
	ldr	r1, [r1, #264]
	ldr	r2, [r0]
	bic	r1, r1, #0x30000
	str	r1, [r2, #264]
	ldr	r1, [r0]
	ldr	r1, [r1, #2088]
	ldr	r2, [r0]
	bic	r1, r1, #0xc00
	str	r1, [r2, #2088]
	ldr	r1, [r0]
	ldr	r1, [r1, #296]
	ldr	r2, [r0]
	bic	r1, r1, #3
	str	r1, [r2, #296]
	ldr	r1, [r0]
	ldr	r1, [r1, #264]
	ldr	r2, [r0]
	bic	r1, r1, #3
	str	r1, [r2, #264]
	ldr	r1, [r0]
	ldr	r1, [r1, #264]
	ldr	r2, [r0]
	bic	r1, r1, #0xc
	str	r1, [r2, #264]
	ldr	r1, [r0]
	ldr	r1, [r1, #260]
	ldr	r2, [r0]
	orr	r1, r1, #1
	str	r1, [r2, #260]
	ldr	r1, [r0]
	ldr	r1, [r1, #292]
	ldr	r2, [r0]
	orr	r1, r1, #1
	str	r1, [r2, #292]
	ldr	r1, [r0]
	ldr	r1, [r1, #260]
	ldr	r0, [r0]
	orr	r1, r1, #2
	str	r1, [r0, #260]
_514166a0:
	ldr	r0, var_51416c10
ret_514166a4:
	ldmia	sp!, {r4, lr}
	b	sub_51430f80

sub_514166ac:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r4, r0
	mov	r5, r1
	bl	load_0x5A0B0004_to_R0 
	ldr	r0, [r0, #48]
	ldr	r1, var_51416c0c
	cmp	r0, #2	
	bcc	_51416888
	cmp	r4, #0	
	beq	_514167a8
	ldr	r0, [r1]
	ldr	r0, [r0, #324]
	ldr	r2, [r1]
	orr	r0, r0, #0x40
	str	r0, [r2, #324]
	ldr	r0, [r1]
	ldr	r0, [r0, #324]
	ldr	r2, [r1]
	orr	r0, r0, #0x1000
	str	r0, [r2, #324]
	ldr	r0, [r1]
	ldr	r0, [r0, #324]
	ldr	r2, [r1]
	orr	r0, r0, #0x80
	str	r0, [r2, #324]
	ldr	r0, [r1]
	ldr	r0, [r0, #324]
	ldr	r2, [r1]
	bic	r0, r0, #0x40
	str	r0, [r2, #324]
	ldr	r0, [r1]
	ldr	r0, [r0, #324]
	ldr	r2, [r1]
	bic	r0, r0, #0x1000
	str	r0, [r2, #324]
	mov	r0, #15	// 0xf
_5141673c:
	ldr	r2, [r1]
	ldr	r2, [r2, #324]
	ldr	r3, [r1]
	bic	r2, r2, #0x1000
	str	r2, [r3, #324]
	mov	r2, r4, lsr r0
	tst	r2, #1	
	beq	_51416774 
	ldr	r2, [r1]
	ldr	r2, [r2, #324]
	ldr	r3, [r1]
	orr	r2, r2, #128	// 0x80
	str	r2, [r3, #324]
	b	_51416788
_51416774:
	ldr	r2, [r1]
	ldr	r2, [r2, #324]
	ldr	r3, [r1]
	bic	r2, r2, #128	// 0x80
	str	r2, [r3, #324]
_51416788:
	ldr	r2, [r1]
	ldr	r2, [r2, #324]
	ldr	r3, [r1]
	orr	r2, r2, #0x1000
	str	r2, [r3, #324]
	sub	r0, r0, #1
	cmp	r0, #0	
	bge	_5141673c
_514167a8:
	cmp	r4, #0
	bne	_514167c4
	ldr	r0, [r1]
	ldr	r0, [r0, #324]
	ldr	r2, [r1]
	orr	r0, r0, #0x80
	str	r0, [r2, #324]
_514167c4:
	ldr	r0, [r1]
	ldr	r0, [r0, #324]
	ldr	r2, [r1]
	orr	r0, r0, #0x40
	str	r0, [r2, #324]
	ldr	r0, [r1]
	ldr	r0, [r0, #324]
	ldr	r2, [r1]
	orr	r0, r0, #0x1000
	str	r0, [r2, #324]
	ldr	r0, [r1]
	ldr	r0, [r0, #324]
	ldr	r2, [r1]
	bic	r0, r0, #0x40
	str	r0, [r2, #324]
	ldr	r0, [r1]
	ldr	r0, [r0, #324]
	ldr	r2, [r1]
	bic	r0, r0, #0x1000
	str	r0, [r2, #324]
	mov	r0, #15	// 0xf
_51416818:
	ldr	r2, [r1]
	ldr	r2, [r2, #324]
	ldr	r3, [r1]
	bic	r2, r2, #0x1000
	str	r2, [r3, #324]
	mov	r2, r5, lsr r0
	tst	r2, #1	
	beq	_51416850
	ldr	r2, [r1]
	ldr	r2, [r2, #324]
	ldr	r3, [r1]
	orr	r2, r2, #0x80
	str	r2, [r3, #324]
	b	_51416864
_51416850:
	ldr	r2, [r1]
	ldr	r2, [r2, #324]
	ldr	r3, [r1]
	bic	r2, r2, #0x80
	str	r2, [r3, #324]
_51416864:
	ldr	r2, [r1]
	ldr	r2, [r2, #324]
	ldr	r3, [r1]
	orr	r2, r2, #0x1000
	str	r2, [r3, #324]
	sub	r0, r0, #1
	cmp	r0, #0	
	bge	_51416818
ret_51416884:
	ldmia	sp!, {r4, r5, r6, pc}
_51416888:
	cmp	r4, #0	
	beq	_51416964
	ldr	r0, [r1]
	ldr	r0, [r0, #260]
	ldr	r2, [r1]
	orr	r0, r0, #1	
	str	r0, [r2, #260]
	ldr	r0, [r1]
	ldr	r0, [r0, #292]
	ldr	r2, [r1]
	orr	r0, r0, #1	
	str	r0, [r2, #292]
	ldr	r0, [r1]
	ldr	r0, [r0, #260]
	ldr	r2, [r1]
	orr	r0, r0, #2	
	str	r0, [r2, #260]
	ldr	r0, [r1]
	ldr	r0, [r0, #260]
	ldr	r2, [r1]
	bic	r0, r0, #1	
	str	r0, [r2, #260]
	ldr	r0, [r1]
	ldr	r0, [r0, #292]
	ldr	r2, [r1]
	bic	r0, r0, #1	
	str	r0, [r2, #292]
	mov	r0, #15	// 0xf
_514168f8:
	ldr	r2, [r1]
	ldr	r2, [r2, #292]
	ldr	r3, [r1]
	bic	r2, r2, #1	
	str	r2, [r3, #292]
	mov	r2, r4, lsr r0
	tst	r2, #1	
	beq	_51416930
	ldr	r2, [r1]
	ldr	r2, [r2, #260]
	ldr	r3, [r1]
	orr	r2, r2, #2	
	str	r2, [r3, #260]
	b	_51416944
_51416930:
	ldr	r2, [r1]
	ldr	r2, [r2, #260]
	ldr	r3, [r1]
	bic	r2, r2, #2	
	str	r2, [r3, #260]
_51416944:
	ldr	r2, [r1]
	ldr	r2, [r2, #292]
	ldr	r3, [r1]
	orr	r2, r2, #1	
	str	r2, [r3, #292]
	sub	r0, r0, #1	
	cmp	r0, #0	
	bge	_514168f8
_51416964:
	cmp	r4, #0	
	bne	_51416980
	ldr	r0, [r1]
	ldr	r0, [r0, #260]
	ldr	r2, [r1]
	orr	r0, r0, #2	
	str	r0, [r2, #260]
_51416980:
	ldr	r0, [r1]
	ldr	r0, [r0, #260]
	ldr	r2, [r1]
	orr	r0, r0, #1	
	str	r0, [r2, #260]
	ldr	r0, [r1]
	ldr	r0, [r0, #292]
	ldr	r2, [r1]
	orr	r0, r0, #1	
	str	r0, [r2, #292]
	ldr	r0, [r1]
	ldr	r0, [r0, #260]
	ldr	r2, [r1]
	bic	r0, r0, #1	
	str	r0, [r2, #260]
	ldr	r0, [r1]
	ldr	r0, [r0, #292]
	ldr	r2, [r1]
	bic	r0, r0, #1	
	str	r0, [r2, #292]
	mov	r0, #15	// 0xf
_514169d4:
	ldr	r2, [r1]
	ldr	r2, [r2, #292]
	ldr	r3, [r1]
	bic	r2, r2, #1	
	str	r2, [r3, #292]
	mov	r2, r5, lsr r0
	tst	r2, #1	
	beq	_51416a0c
	ldr	r2, [r1]
	ldr	r2, [r2, #260]
	ldr	r3, [r1]
	orr	r2, r2, #2
	str	r2, [r3, #260]
	b	_51416a20
_51416a0c:
	ldr	r2, [r1]
	ldr	r2, [r2, #260]
	ldr	r3, [r1]
	bic	r2, r2, #2
	str	r2, [r3, #260]
_51416a20:
	ldr	r2, [r1]
	ldr	r2, [r2, #292]
	ldr	r3, [r1]
	orr	r2, r2, #1
	str	r2, [r3, #292]
	sub	r0, r0, #1
	cmp	r0, #0
	bge	_514169d4 
	b	ret_51416884	// 0x51416a40

sub_51416a44:
	stmdb	sp!, {r4, r5, r6, lr}
	bl	load_0x5A0B0004_to_R0
	ldr	r1, [r0, #48]
	ldr	r0, var_51416c28
	ldr	r4, var_51416c0c
	cmp	r1, #2
	bcc	_51416abc
	bl	sub_51430f80
	ldr	r0, [r4]
	ldr	r0, [r0, #324]
	ldr	r1, [r4]
	orr	r0, r0, #0x400
	str	r0, [r1, #324]
	mov	r0, #1000	// 0x3e8
	bl	sub_51430f80
	ldr	r0, [r4]
	ldr	r0, [r0, #324]
	ldr	r1, [r4]
	bic	r0, r0, #1024	// 0x400
	str	r0, [r1, #324]
	mov	r0, #1000	// 0x3e8
	bl	sub_51430f80
	ldr	r0, [r4]
	ldr	r0, [r0, #324]
	ldr	r1, [r4]
	orr	r0, r0, #1024	// 0x400
	str	r0, [r1, #324]
	mov	r0, #1000	// 0x3e8
	bl	sub_51430f80
	b	_51416b14
_51416abc:
	bl	sub_51430f80
	ldr	r0, [r4]
	ldr	r0, [r0, #260]
	ldr	r1, [r4]
	orr	r0, r0, #0x100
	str	r0, [r1, #260]
	mov	r0, #1000	// 0x3e8
	bl	sub_51430f80
	ldr	r0, [r4]
	ldr	r0, [r0, #260]
	ldr	r1, [r4]
	bic	r0, r0, #0x100
	str	r0, [r1, #260]
	mov	r0, #1000	// 0x3e8
	bl	sub_51430f80
	ldr	r0, [r4]
	ldr	r0, [r0, #260]
	ldr	r1, [r4]
	orr	r0, r0, #256	// 0x100
	str	r0, [r1, #260]
	mov	r0, #1000	// 0x3e8
	bl	sub_51430f80
_51416b14:
	ldr	r0, var_51416c14
	bl	sub_51430f80
	ldr	r4, var_51416c2c
	ldr	r0, var_51416c30
	mov	r1, r4
	bl	sub_514166ac
	ldr	r0, var_51416c34
	add	r1, r4, #12	// 0xc
	bl	sub_514166ac
	sub	r1, r4, #6	// 0x6
	sub	r0, r4, #472	// 0x1d8
	bl	sub_514166ac
	sub	r5, r4, #5	
	mov	r1, r5
	sub	r0, r5, #476	// 0x1dc
	bl	sub_514166ac
	ldr	r0, var_51416c38 
	mov	r1, r4
	bl	sub_514166ac
	mov	r1, r4
	sub	r0, r5, #496	// 0x1f0
	bl	sub_514166ac
	ldr	r0, var_51416c3c 
	add	r1, r4, #8	
	bl	sub_514166ac
	ldr	r0, var_51416c40 
	mov	r1, #29184	// 0x7200
	bl	sub_514166ac
	add	r1, r4, #200	// 0xc8
	sub	r0, r5, #276	// 0x114
	bl	sub_514166ac
	add	r1, r4, #224	// 0xe0
	mov	r0, #0	
	bl	sub_514166ac
	add	r1, r4, #26	// 0x1a
	sub	r0, r5, #492	// 0x1ec
	bl	sub_514166ac
	add	r1, r4, #43	// 0x2b
	sub	r0, r4, #496	// 0x1f0
	bl	sub_514166ac
	ldr	r0, var_51416c44
	mov	r1, r5
	bl	sub_514166ac
	ldr	r0, var_51416c48
	sub	r1, r4, #7	
	bl	sub_514166ac
	ldr	r0, var_51416c4c 
	add	r1, r4, #156	// 0x9c
	bl	sub_514166ac
	mov	r1, #29184	// 0x7200
	sub	r0, r5, #480	// 0x1e0
	bl	sub_514166ac
	add	r4, r4, #152	// 0x98
	ldr	r0, var_51416c50 
	mov	r1, r4
	bl	sub_514166ac
	ldr	r0, var_51416c54 
	mov	r1, r4
	bl	sub_514166ac
ret_51416c00:
	ldmia	sp!, {r4, r5, r6, lr}

sub_51416c04:
	ldr	r0, var_51416c58
	b	sub_51430f80

var_51416c0c:	.word	0x514431e4
var_51416c10:	.word	0x00002710
var_51416c14:	.word	0x00005208
var_51416c18:	.word	0x00001770
var_51416c1c:	.word	0x0000ee48
var_51416c20:	.word	0x0000a028
var_51416c24:	.word	0x00031128
var_51416c28:	.word	0x00006590
var_51416c2c:	.word	0x00007208
var_51416c30:	.word	0x00007031
var_51416c34:	.word	0x00007032
var_51416c38:	.word	0x00007012
var_51416c3c:	.word	0x00007015
var_51416c40:	.word	0x00007016
var_51416c44:	.word	0x00007019
var_51416c48:	.word	0x0000701a
var_51416c4c:	.word	0x00007022
var_51416c50:	.word	0x00007026
var_51416c54:	.word	0x0000701d
var_51416c58:	.word	0x0003d090



sub_51416d38:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r4, r0
	mov	r6, r1
	mov	r5, #0
	b	_51416d6c 
_51416d4c:
	ldr	r0, [r4, #4]
	uxth r1,r0
	ldr	r0, [r4]
	uxth r0,r0
	bl	sub_514166ac
	add	r4, r4, #8	
	add	r0, r5, #1	
	bic	r5, r0, #0x10000
_51416d6c:
	cmp	r5, r6
	bcc	_51416d4c
	ldmia	sp!, {r4, r5, r6, pc}	// 0x51416d74



/*
 *  51417000
 */

sub_514171bc:
	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	mov	r4, r0
	ldr	r7, var_5141771c
	ldrb	r0, [r7]
	cmp	r0, #1
_514171d0:
	bne	_514171dc
	cmp	r4, #5
	bgt	ret_514173d0
_514171dc:
	cmp	r4, #11	// 0xb
	bcs	ret_514173d0
	ldr	r5, var_51417720
	ldr	r0, [r5, #4]
	cmp	r0, #0
	beq	_51417204
	mov	r1, #21	// 0x15
	ldr	r0, var_5141775c
	bl	sub_51416d38 
	b	_514173bc
_51417204:
	ldr	r0, [r5, #8]
	ldr	r9, var_51417760
	ldr	sl, var_51417728
	cmp	r0, #0
	mov	r8, #0
	mov	r6, #1
	beq	_51417234
	add	r1, r9, #15	// 0xf
	mov	r0, sl
	bl	sub_514166ac 
	str	r8, [r5, #8]
	b	_51417244
_51417234:
	mov	r1, r9
	mov	r0, sl
	bl	sub_514166ac
	str	r6, [r5, #8]
_51417244:
	ldr	fp, var_5141772c
	mov	r0, fp
	bl	sub_51430f80
	ldrb	r0, [r7]
	cmp	r0, #0
	beq	_514172e8
	cmp	r4, #10	// 0xa
	addls	pc, pc, r4, lsl #2
_51417264:
	b	_5141738c
	b	_51417294
	b	_514172a8
	b	_514172bc
	b	_514172bc
	b	_514172bc
	b	_514172bc
	b	_514172bc
	b	_514172bc
	b	_514172bc
	b	_514172d0
	b	_514172d0	// 0x51417290

_51417294:
	mov	r1, #21	// 0x15
	ldr	r0, var_51417764
	bl	sub_51416d38 
	strb	r8, [r5]
	b	_5141738c

_514172a8:
	mov	r1, #21	// 0x15
	ldr	r0, var_51417768
	bl	sub_51416d38 
	strb	r6, [r5]
	b	_5141738c

_514172bc:
	mov	r1, #21	// 0x15
	ldr	r0, var_51417740
	bl	sub_51416d38 
	strb	r6, [r5]
	b	_5141738c

_514172d0:
	mov	r1, #21	// 0x15
	ldr	r0, var_51417730
	bl	sub_51416d38 
	mov	r0, #3
	strb	r0, [r5]
	b	_5141738c

_514172e8:
	cmp	r4, #10	// 0xa
	addls	pc, pc, r4, lsl #2
_514172f0:
	b	_5141738c
	b	_51417320
	b	_51417330
	b	_51417340
	b	_51417340
	b	_51417340
	b	_51417340
	b	_51417340
	b	_51417350
	b	_51417360
	b	_51417370
	b	_51417380	// 0x5141731c

_51417320:
	mov	r1, #21	// 0x15
	ldr	r0, var_51417764
	bl	sub_51416d38 
	b	_5141738c

_51417330:
	mov	r1, #21	// 0x15
	ldr	r0, var_51417768
	bl	sub_51416d38 
	b	_5141738c

_51417340:
	mov	r1, #21	// 0x15
	ldr	r0, var_51417750
	bl	sub_51416d38 
	b	_5141738c

_51417350:
	mov	r1, #21	// 0x15
	ldr	r0, var_51417748
	bl	sub_51416d38 
	b	_5141738c

_51417360:
	mov	r1, #21	// 0x15
	ldr	r0, var_51417740
	bl	sub_51416d38 
	b	_5141738c

_51417370:
	mov	r1, #21	// 0x15
	ldr	r0, var_51417738
	bl	sub_51416d38 
	b	_5141738c

_51417380:
	mov	r1, #21	// 0x15
	ldr	r0, var_51417730
	bl	sub_51416d38 
_5141738c:
	ldr	r0, [r5, #8]
	cmp	r0, #0
	bne	_514173a8
	mov	r1, r9
	mov	r0, sl
	bl	sub_514166ac 
	b	_514173b4
_514173a8:
	ldr	r1, var_51417724
	mov	r0, sl
	bl	sub_514166ac 
_514173b4:
	mov	r0, fp
	bl	sub_51430f80 
_514173bc:
	ldr	r0, var_51417758
	cmp	r4, #0
	bne	_514173d4
	ldr	r1, var_5141777c
	bl	sub_514166ac 
ret_514173d0:
	ldmia	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, pc}
_514173d4:
	ldr	r1, var_51417754
	bl	sub_514166ac 
	b	ret_514173d0 	// 0x514173dc

sub_514173e0:
	stmdb	sp!, {r4, lr}
	bl	sub_51416498 
	ldmia	sp!, {r4, lr}
	b	sub_51416a44 

sub_514173f0:
	stmdb	sp!, {r4, lr}
	bl	load_0x5A0B0004_to_R0 
	ldr	r2, var_51417780
	mov	r1, #0
	str	r1, [r2, #12]
	ldr	r2, [r0, #48]
	ldr	r1, var_51416c0c
	cmp	r2, #2
	bcc	_5141745c 
	ldr	r2, [r1]
	ldr	r2, [r2, #256]
	ldr	r3, [r1]
	bic	r2, r2, #0x3
	orr	r2, r2, #0x2
	str	r2, [r3, #256]
	ldr	r2, [r1]
	ldr	r2, [r2, #256]
	ldr	r3, [r1]
	bic	r2, r2, #0xc
	orr	r2, r2, #0x8
	str	r2, [r3, #256]
	ldr	r2, [r1]
	ldr	r2, [r2, #256]
	ldr	r3, [r1]
	bic	r2, r2, #0x30
	orr	r2, r2, #0x20
	str	r2, [r3, #256]
_5141745c:
	ldr	r2, [r1]
	ldr	r2, [r2, #256]
	ldr	r3, [r1]
	bic	r2, r2, #0xc0
	orr	r2, r2, #0x80
	str	r2, [r3, #256]
	ldr	r2, [r1]
	ldr	r2, [r2, #256]
	ldr	r3, [r1]
	bic	r2, r2, #0x300
	orr	r2, r2, #0x200
	str	r2, [r3, #256]
	ldr	r2, [r1]
	ldr	r2, [r2, #256]
	ldr	r3, [r1]
	bic	r2, r2, #0xc00
	orr	r2, r2, #0x800
	str	r2, [r3, #256]
	ldr	r2, [r1]
	ldr	r2, [r2, #256]
	ldr	r3, [r1]
	bic	r2, r2, #0x3000
	orr	r2, r2, #0x2000
	str	r2, [r3, #256]
	ldr	r2, [r1]
	ldr	r2, [r2, #256]
	ldr	r3, [r1]
	bic	r2, r2, #0xc000
	orr	r2, r2, #0x8000
	str	r2, [r3, #256]
	ldr	r2, [r0, #48]
	cmp	r2, #2	
	bcc	_51417510
	ldr	r2, [r1]
	ldr	r2, [r2, #256]
	ldr	r3, [r1]
	bic	r2, r2, #0x30000
	orr	r2, r2, #0x20000
	str	r2, [r3, #256]
	ldr	r2, [r1]
	ldr	r2, [r2, #256]
	ldr	r3, [r1]
	bic	r2, r2, #0xc0000
	orr	r2, r2, #0x80000
	str	r2, [r3, #256]
_51417510:
	ldr	r2, [r1]
	ldr	r2, [r2, #256]
	ldr	r3, [r1]
	bic	r2, r2, #0x300000
	orr	r2, r2, #0x200000
	str	r2, [r3, #256]
	ldr	r2, [r1]
	ldr	r2, [r2, #256]
	ldr	r3, [r1]
	bic	r2, r2, #0xc00000
	orr	r2, r2, #0x800000
	str	r2, [r3, #256]
	ldr	r2, [r1]
	ldr	r2, [r2, #256]
	ldr	r3, [r1]
	bic	r2, r2, #0x3000000
	orr	r2, r2, #0x2000000
	str	r2, [r3, #256]
	ldr	r2, [r1]
	ldr	r2, [r2, #256]
	ldr	r3, [r1]
	bic	r2, r2, #0xc000000
	orr	r2, r2, #0x8000000
	str	r2, [r3, #256]
	ldr	r2, [r1]
	ldr	r2, [r2, #256]
	ldr	r3, [r1]
	bic	r2, r2, #0x30000000
	orr	r2, r2, #0x20000000
	str	r2, [r3, #256]
	ldr	r2, [r1]
	ldr	r2, [r2, #256]
	ldr	r3, [r1]
	bic	r2, r2, #0xc0000000
	orr	r2, r2, #0x80000000
	str	r2, [r3, #256]
	ldr	r0, [r0, #48]
	cmp	r0, #2	
	bcc	_514175f4
	ldr	r0, [r1]
	ldr	r0, [r0, #288]
	ldr	r2, [r1]
	bic	r0, r0, #0x3
	orr	r0, r0, #0x2
	str	r0, [r2, #288]
	ldr	r0, [r1]
	ldr	r0, [r0, #288]
	ldr	r2, [r1]
	bic	r0, r0, #0xc
	orr	r0, r0, #0x8
	str	r0, [r2, #288]
	ldr	r0, [r1]
	ldr	r0, [r0, #288]
	ldr	r2, [r1]
	bic	r0, r0, #0x30
	orr	r0, r0, #0x20
	str	r0, [r2, #288]
_514175f4:
	ldr	r0, [r1]
	ldr	r0, [r0, #288]
	ldr	r2, [r1]
	bic	r0, r0, #0xc0
	orr	r0, r0, #0x80
	str	r0, [r2, #288]
	ldr	r0, [r1]
	ldr	r0, [r0, #288]
	ldr	r2, [r1]
	bic	r0, r0, #0x300
	orr	r0, r0, #0x200
	str	r0, [r2, #288]
	ldr	r0, [r1]
	ldr	r0, [r0, #288]
	ldr	r2, [r1]
	bic	r0, r0, #0xc00
	orr	r0, r0, #0x800
	str	r0, [r2, #288]
	ldr	r0, [r1]
	ldr	r0, [r0, #288]
	ldr	r2, [r1]
	bic	r0, r0, #0x3000
	orr	r0, r0, #0x2000
	str	r0, [r2, #288]
	ldr	r0, [r1]
	ldr	r0, [r0, #288]
	ldr	r2, [r1]
	bic	r0, r0, #0xc000
	orr	r0, r0, #0x8000
	str	r0, [r2, #288]
	ldr	r0, [r1]
	ldr	r0, [r0, #288]
	ldr	r2, [r1]
	bic	r0, r0, #0x30000
	orr	r0, r0, #0x20000
	str	r0, [r2, #288]
	ldr	r0, [r1]
	ldr	r0, [r0, #288]
	ldr	r2, [r1]
	bic	r0, r0, #0xc0000
	orr	r0, r0, #0x80000
	str	r0, [r2, #288]
	ldr	r0, [r1]
	ldr	r0, [r0, #288]
	ldr	r2, [r1]
	bic	r0, r0, #0x300000
	orr	r0, r0, #0x200000
	str	r0, [r2, #288]
	ldr	r0, [r1]
	ldr	r0, [r0, #288]
	ldr	r1, [r1]
	bic	r0, r0, #0xc00000
	orr	r0, r0, #0x800000
	str	r0, [r1, #288]
	mov	r0, #0
	ldmia	sp!, {r4, pc}	// 0x514176d0

sub_514176d4:
	mov	r0, #0
	bx	lr
	
sub_514176dc:
	mov	r1, #2
	str	r1, [r0]
	mov	r1, #66	// 0x42
	str	r1, [r0, #4]
	mov	r1, #4	
	str	r1, [r0, #8]
	mov	r1, #3	
	str	r1, [r0, #12]
	mov	r1, #15	// 0xf
	str	r1, [r0, #16]
	mov	r1, #5	
	str	r1, [r0, #20]
	mov	r0, #0
	bx	lr	// 0x51417710

var_51417714:	.word	0x000072a1
var_51417718:	.word	0x00033450
var_5141771c:	.word	0x51445db0
var_51417720:	.word	0x51445324
var_51417724:	.word	0x00007243
var_51417728:	.word	0x00007039
var_5141772c:	.word	0x00004e20
var_51417730:	.word	0x51445330
var_51417734:	.word	0x514453d8
var_51417738:	.word	0x51445528
var_5141773c:	.word	0x514455d0
var_51417740:	.word	0x51445720
var_51417744:	.word	0x514457c8
var_51417748:	.word	0x51445870
var_5141774c:	.word	0x514459c0
var_51417750:	.word	0x51445b10
var_51417754:	.word	0x00007203
var_51417758:	.word	0x00007014
var_5141775c:	.word	0x51445a68
var_51417760:	.word	0x00007234
var_51417764:	.word	0x51445d08
var_51417768:	.word	0x51445c60
var_5141776c:	.word	0x51445bb8
var_51417770:	.word	0x51445918
var_51417774:	.word	0x51445678
var_51417778:	.word	0x51445480
var_5141777c:	.word	0x00007201
var_51417780:	.word	0x74108000



var_51417ef0:	.word	0x51445dbc

sub_51417ef4:
	ldr	r3, [sp]
	ldr	r1, var_514181b0
	mov	r2, #0
_51417f00:
	mov	r0, #0
_51417f04:
	strh	r3, [r1], #2
	add	r0, r0, #1
	cmp	r0, #480	// 0x1e0	hresolution
	blt	_51417f04
	add	r2, r2, #1
	cmp	r2, #800	// 0x320	vresolution
	blt	_51417f00
	bx	lr	// 0x51417f20

sub_51417f24:
	stmdb	sp!, {r3, lr}
	ldr	r3, var_514181b4
	str	r0, [sp]
	mov	r0, #0	
	mov	r1, #0	
	sub	r2, r3, #320	// 0x140
	bl	sub_51417ef4 
ret_51417f40:
	ldmia	sp!, {ip, pc}

sub_51417f44:	
	stmdb	sp!, {r4, lr}
	bl	load_0x5A0B0004_to_R0
	ldr	r0, [r0, #48]
	cmp	r0, #2
	beq	_51417f60
	cmp	r0, #3	
	bne	_51417f84
_51417f60:
	mov	r1, #1	
	mov	r0, #148	// 0x94
	bl	value_table_sub_A
	mov	r1, #0	
	mov	r0, #148	// 0x94
	bl	value_table_sub_B
	ldmia	sp!, {r4, lr}
	add	r0, pc, #564	// 0x234	// !!!! PC relative 0x51417f7c + 0x234 = 0x514181b0
	b	SimpleDebugPrint
_51417f84:
	mov	r1, #1
	mov	r0, #148	// 0x94
	bl	value_table_sub_A
	ldmia	sp!, {r4, lr}
	mov	r1, #1
	mov	r0, #148	// 0x94
	b	value_table_sub_B 	// 0x51417f9c

sub_51417fa0:
	stmdb	sp!, {r4, lr}
	bl	load_0x5A0B0004_to_R0 
	mov	r4, r0
	bl	sub_51417f44 
	ldr	r0, [r4, #48]
	cmp	r0, #4
	bcs	ret_51417fc4 
	ldmia	sp!, {r4, lr}
	b	sub_51415a68
ret_51417fc4:
	ldmia	sp!, {r4, pc}

sub_51417fc8:
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	ldr	r8, [sp, #32]
	add	lr, sp, #36	// 0x24
	ldmia	lr, {r5, ip, lr}
	add	r4, ip, r8
	cmp	r4, #800	// 0x320	vresolution
	ble	_51417fec
	rsb	r4, ip, #800	// 0x320
	sxth r8,r4
_51417fec:
	add	r4, lr, r5
	cmp	r4, #480	// 0x1e0	hresolution
	ble	_51418000
	rsb	r4, lr, #480	// 0x1e0
	sxth r5,r4
_51418000:
	ldr	r4, var_514181b0
	rsb	ip, ip, ip, lsl #4
	add	ip, lr, ip, lsl #5
	add	r6, r4, ip, lsl #1
	smlabb	r1, r2, r1, r3
	add	r7, r0, r1, lsl #1
	mov	r4, #0	
	mov	r9, r5, lsl #1
	b	_51418040
_51418024:
	mov	r2, r9
	mov	r1, r7
	mov	r0, r6
	bl	sub_5143f1c0
	add	r6, r6, #960	// 0x3c0
	add	r7, r7, r5, lsl #1
	add	r4, r4, #1	
_51418040:
	cmp	r4, r8
	blt	_51418024
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
_5141804c:
	b	sub_514171bc 
	cmp	r0, #0	
	beq	_51418060
	mov	r0, #10	// 0xa
	b	_5141804c
_51418060:
	mov	r0, #0	
	b	_5141804c

sub_51418068:
	stmdb	sp!, {r4, lr}
	sub	sp, sp, #0x5f000
	add	r0, sp, #0x5e000
	ldr	r1, var_514181e4
	add	r0, r0, #1872	// 0x750
	mov	r2, #2224	// 0x8b0
	bl	sub_514042bc 
	mov	r0, #0
	bl	sub_51403f40 
	cmp	r0, #0	
	bne	_51418110
	ldr	r0, var_514181e8
	ldrb	r0, [r0]
	cmp	r0, #1	
	beq	_51418118
	cmp	r0, #32	// 0x20
	add	r4, sp, #2896	// 0xb50
	beq	_51418154
	cmp	r0, #128	// 0x80
	bne	_51418110
	mov	r0, #0	
	bl	sub_51417f24 
	add	ip, sp, #0x5e000
	ldr	r0, [ip, #4068]
	ldr	r2, [ip, #4072]
	add	r1, r0, #0x8500000
	mov	r0, r4
	bl	sub_514042bc 
	add	ip, sp, #0x5e000
	ldr	r0, [ip, #4084]
	sxth r3,r0
	ldr	r0, [ip, #4080]
	sxth r2,r0
	ldr	r0, [ip, #4088]
	sxth r1,r0
	ldr	r0, [ip, #4092]
	sxth r0,r0
	stmia	sp, {r0, r1, r2, r3}
	mov	r0, r4
	mov	r2, #0	
	mov	r3, #0	
	bl	sub_51417fc8 
_51418110:
	add	sp, sp, #0x5f000
	ldmia	sp!, {r4, pc}
_51418118:
	add	ip, sp, #0x5e000
	ldr	r2, var_514181ec
	ldr	r1, [ip, #1872]
	ldr	r0, var_514181b0
	cmp	r1, r2
	bne	_51418144
	ldr	r1, [ip, #1880]
	ldr	r2, [ip, #1884]
	add	r1, r1, #0x8500000
	bl	sub_514042bc 
	b	_51418110
_51418144:
	ldr	r2, var_514181f0
	ldr	r1, var_514181f4
	bl	sub_5143f0a8 
	b	_51418110
_51418154:
	mov	r0, #0	
	bl	sub_51417f24 
	add	ip, sp, #0x5e000
	ldr	r0, [ip, #4040]
	ldr	r2, [ip, #4044]
	add	r1, r0, #0x8500000
	mov	r0, r4
	bl	sub_514042bc
	add	ip, sp, #0x5e000
	ldr	r0, [ip, #4056]
	sxth r3,r0
	ldr	r0, [ip, #4052]
	sxth r2,r0
	ldr	r0, [ip, #4060]
	sxth r1,r0
	ldr	r0, [ip, #4064]
	sxth r0,r0
	stmia	sp, {r0, r1, r2, r3}
	mov	r0, r4
	mov	r2, #0
	mov	r3, #0	
	bl	sub_51417fc8
	b	_51418110	// 0x514181ac



/*
 *   51418000
 */

var_514181b0:	.word	0x5a100000
var_514181b4:	.word	0x0000031f
var_514181b8:	.word	0x44434c0a
var_514181bc:	.word	0x62343220
var_514181c0:	.word	0x52207469
var_514181c4:	.word	0x38384247
var_514181c8:	.word	0x435f5f38
var_514181cc:	.word	0x3236434d
var_514181d0:	.word	0x4e442032
var_514181d4:	.word	0x42206549
var_514181d8:	.word	0x53415059
var_514181dc:	.word	0x0a5f5f53
var_514181e0:	.word	0x00000000
var_514181e4:	.word	0x08520000
var_514181e8:	.word	0x514449a8
var_514181ec:	.word	0x5a5b5c5d
var_514181f0:	.word	0x000028ea
var_514181f4:	.word	0x000bb800



LCD_printf:
sub_514182d4:
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	cmp	r1, #24	// 0x18
	bcc	_514182e4 
	mov	r1, #0
_514182e4:
	mov	r5, #0
	ldr	lr, var_51418668
	mov	sl, #1
	b	_51418468
_514182f4:
	ldr	ip, var_51418670
	rsb	r3, r3, r3, lsl #3
	add	r3, ip, r3, lsl #1
	mov	r4, #0
	mov	ip, #0x3c00
	smulbb	ip, r1, ip
	add	fp, ip, r5, lsl #4
_51418310:
	mov	ip, #0
	add	r6, fp, r4, lsl #1
_51418318:
	rsb	r7, ip, ip, lsl #4
	add	r7, r6, r7, lsl #6
	ldrb	r8, [r3]
	mov	r8, r8, lsr ip
	tst	r8, #1
	beq	_51418338
	add	r8, lr, r7, lsl #1
	strh	r2, [r8]
_51418338:
	add	r8, sl, ip, lsl #1
	rsb	r8, r8, r8, lsl #4
	add	r8, r6, r8, lsl #5
	ldrb	r9, [r3]
	mov	r9, r9, lsr ip
	tst	r9, #1
	beq	_5141835c
	add	r9, lr, r8, lsl #1
	strh	r2, [r9]
_5141835c:
	add	r7, r7, #1
	ldrb	r9, [r3]
	mov	r9, r9, lsr ip
	tst	r9, #1
	beq	_51418378
	add	r7, lr, r7, lsl #1
	strh	r2, [r7]
_51418378:
	add	r7, r8, #1
	ldrb	r8, [r3]
	mov	r8, r8, lsr ip
	tst	r8, #1
	beq	_51418394
	add	r7, lr, r7, lsl #1
	strh	r2, [r7]
_51418394:
	add	ip, ip, #1
	cmp	ip, #8
	blt	_51418318
	add	r3, r3, #1
	add	r4, r4, #1
	cmp	r4, #7
	blt	_51418310
	mov	r4, #0
	add	ip, sl, r1, lsl #1
	mov	r6, #0x1e00
	smulbb	ip, ip, r6
	add	fp, ip, r5, lsl #4
_514183c4:
	mov	ip, #0	
	add	r6, fp, r4, lsl #1
_514183cc:
	rsb	r7, ip, ip, lsl #4
	add	r7, r6, r7, lsl #6
	ldrb	r8, [r3]
	mov	r8, r8, lsr ip
	tst	r8, #1
	beq	_514183ec
	add	r8, lr, r7, lsl #1
	strh	r2, [r8]
_514183ec:
	add	r8, sl, ip, lsl #1
	rsb	r8, r8, r8, lsl #4
	add	r8, r6, r8, lsl #5
	ldrb	r9, [r3]
	mov	r9, r9, lsr ip
	tst	r9, #1
	beq	_51418410
	add	r9, lr, r8, lsl #1
	strh	r2, [r9]
_51418410:
	add	r7, r7, #1
	ldrb	r9, [r3]
	mov	r9, r9, lsr ip
	tst	r9, #1
	beq	_5141842c
	add	r7, lr, r7, lsl #1
	strh	r2, [r7]
_5141842c:
	add	r7, r8, #1
	ldrb	r8, [r3]
	mov	r8, r8, lsr ip
	tst	r8, #1
	beq	_51418448
	add	r7, lr, r7, lsl #1
	strh	r2, [r7]
_51418448:
	add	ip, ip, #1
	cmp	ip, #8
	blt	_514183cc
	add	r3, r3, #1
	add	r4, r4, #1
	cmp	r4, #7
	blt	_514183c4
	add	r5, r5, #1
_51418468:
	ldrb	r3, [r0, r5]
	cmp	r3, #0
	bne	_514182f4
ret_51418474:
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}



asc_spacer:
	.ascii	"--------------------------------"
	.byte	0

asc_jetdroid:
	.ascii	"   \t    JetDroid mode  \t      "
	.byte	0

Download_Mode_MSG: //0x514184B8
	STMFD   SP!, {R4,LR}
	MOV     R0, #0x7D0
	bl	sub_51430f80
	bl	sub_51417fa0
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




var_51418668:	.word	0x5150b0f0
var_5141866c:	.word	0x000001df
var_51418670:	.word	0x5144157c
var_51418674:	.word	0x51445df0
var_51418678:	.word	0x2d2d2d2d
var_5141867c:	.word	0x2d2d2d2d
var_51418680:	.word	0x2d2d2d2d
var_51418684:	.word	0x2d2d2d2d
var_51418688:	.word	0x2d2d2d2d
var_5141868c:	.word	0x2d2d2d2d
var_51418690:	.word	0x2d2d2d2d
var_51418694:	.word	0x2d2d2d2d
var_51418698:	.word	0x00000000
var_5141869c:	.word	0x09202020
var_514186a0:	.word	0x20202020
var_514186a4:	.word	0x6e776f44
var_514186a8:	.word	0x64616f6c
var_514186ac:	.word	0x646f6d20
var_514186b0:	.word	0x09202065
var_514186b4:	.word	0x20202020
var_514186b8:	.word	0x00002020
var_514186bc:	.word	0x20202020
var_514186c0:	.word	0x20202020
var_514186c4:	.word	0x20202020
var_514186c8:	.word	0x20202020
var_514186cc:	.word	0x2d544720
var_514186d0:	.word	0x30303853
var_514186d4:	.word	0x20202030
var_514186d8:	.word	0x20202020
var_514186dc:	.word	0x20202020
var_514186e0:	.word	0x20202020
var_514186e4:	.word	0x00202020
var_514186e8:	.word	0x0000ffe0
var_514186ec:	.word	0x20092020
var_514186f0:	.word	0x50552020
var_514186f4:	.word	0x44414f4c
var_514186f8:	.word	0x61642020
var_514186fc:	.word	0x74206174
var_51418700:	.word	0x6370206f
var_51418704:	.word	0x20092020
var_51418708:	.word	0x00202020
var_5141870c:	.word	0x20202020
var_51418710:	.word	0x20202020
var_51418714:	.word	0x20202020
var_51418718:	.word	0x2d544720
var_5141871c:	.word	0x30303853
var_51418720:	.word	0x20202030
var_51418724:	.word	0x20202020
var_51418728:	.word	0x20202020
var_5141872c:	.word	0x00202020


/*
 *  51419000
 */

pmic_read_I2C:		// sub_51419978:
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
	bl	j_I2C_GPIO_Line_Open 
	mov	r5, r0
	mov	r2, #0
	stmib	sp, {r2, sl}
	mov	r2, r8
	mov	r3, #0	
	mov	r1, r7
	mov	r0, #0	
	str	r9, [sp]
	bl	I2C_GPIO_tx1 
	orr	r5, r0, r5
	mov	r0, #0	
	bl	j_I2C_GPIO_Line_Close 
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
	bl	SimpleDebugPrint
	add	r4, r4, #1
	cmp	r4, #10	// 0xa
	blt	_51419994
	mov	r0, #1
	b	ret_514199e8	// 0x51419a10

pmic_write_I2C:		// sub_51419a14:
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
	bl	j_I2C_GPIO_Line_Open 
	mov	r5, r0
	mov	r3, r9
	mov	r2, r8
	mov	r1, r7
	mov	r0, #0	
	str	sl, [sp]
	bl	I2C_GPIO_tx2
	orr	r5, r0, r5
	mov	r0, #0	
	bl	j_I2C_GPIO_Line_Close
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
	add	r0, pc, #376	// 0x178	// !!!! PC relative 0x51419a8c + 0x178
	bl	SimpleDebugPrint
	add	r4, r4, #1
	cmp	r4, #10	// 0xa
	blt	_51419a30 
	mov	r0, #1	
	b	ret_51419a7c	// 0x51419aa4

sub_51419aa8:
	stmdb	sp!, {r1, r2, r3, r4, r5, r6, r7, r8, r9, lr}
	mov	r7, r0
	mov	r8, r1
	mov	r9, r2
	mov	r4, #0
	ldr	r6, var_51419bd0
_51419ac0:
	mov	r3, r6
	mov	r2, #141	// 0x8d
	mov	r1, #140	// 0x8c
	mov	r0, #0
	bl	j_I2C_GPIO_Line_Open
	mov	r5, r0
	mov	r2, #0	
	stmib	sp, {r2, r9}
	mov	r2, r7
	mov	r3, #0	
	mov	r1, #208	// 0xd0
	mov	r0, #0
	str	r8, [sp]
	bl	I2C_GPIO_tx1
	orr	r5, r0, r5
	mov	r0, #0
	bl	j_I2C_GPIO_Line_Close
	orr	r0, r0, r5
	cmp	r0, #0	
	bne	_51419b18
	mov	r0, #0	
ret_51419b14:
	ldmia	sp!, {r1, r2, r3, r4, r5, r6, r7, r8, r9, pc}
_51419b18:
	mov	r1, r4
	add	r0, pc, #292	// 0x124	// !!!! PC relative 0x51419b1c + 0x124
	bl	SimpleDebugPrint
	add	r4, r4, #1
	cmp	r4, #10	// 0xa
	blt	_51419ac0
	mov	r0, #1	
	b	ret_51419b14

sub_51419b38:
	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov	r7, r0
	mov	r8, r1
	mov	r9, r2
	mov	r4, #0
	ldr	r6, var_51419bd0
_51419b50:
	mov	r3, r6
	mov	r2, #141	// 0x8d
	mov	r1, #140	// 0x8c
	mov	r0, #0	
	bl	j_I2C_GPIO_Line_Open
	mov	r5, r0
	mov	r3, r8
	mov	r2, r7
	mov	r1, #208	// 0xd0
	mov	r0, #0
	str	r9, [sp]
	bl	I2C_GPIO_tx2
	orr	r5, r0, r5
	mov	r0, #0
	bl	j_I2C_GPIO_Line_Close
	orr	r0, r0, r5
	cmp	r0, #0	
	bne	_51419ba0
	mov	r0, #0	
ret_51419b9c:
	ldmia	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_51419ba0:
	mov	r1, r4
	add	r0, pc, #192	// 0xc0		// !!!! PC relative 0x51419ba4 + 0xc0
	bl	SimpleDebugPrint
	add	r4, r4, #1
	cmp	r4, #10	// 0xa
	blt	_51419b50
	mov	r0, #1	
	b	ret_51419b9c
	mov	r0, #0	
	bx	lr
	mov	r0, #0	
	bx	lr	// 0x51419bcc

var_51419bd0:	.word	0x00061a80
var_51419bd4:	.word	0x63696d70
var_51419bd8:	.word	0x6165725f
var_51419bdc:	.word	0x2e2e2e64
var_51419be0:	.word	0x20433249
var_51419be4:	.word	0x6c696166
var_51419be8:	.word	0x6c73202c
var_51419bec:	.word	0x5f657661
var_51419bf0:	.word	0x72646461
var_51419bf4:	.word	0x7830203a
var_51419bf8:	.word	0x722c7825
var_51419bfc:	.word	0x203a6765
var_51419c00:	.word	0x78257830
var_51419c04:	.word	0x25207e20
var_51419c08:	.word	0x000a2064
var_51419c0c:	.word	0x63696d70
var_51419c10:	.word	0x6972775f
var_51419c14:	.word	0x2e2e6574
var_51419c18:	.word	0x4332492e
var_51419c1c:	.word	0x69616620
var_51419c20:	.word	0x73202c6c
var_51419c24:	.word	0x6576616c
var_51419c28:	.word	0x6464615f
var_51419c2c:	.word	0x30203a72
var_51419c30:	.word	0x2c782578
var_51419c34:	.word	0x3a676572
var_51419c38:	.word	0x25783020
var_51419c3c:	.word	0x207e2078
var_51419c40:	.word	0x0a206425
var_51419c44:	.word	0x00000000
var_51419c48:	.word	0x63696d70
var_51419c4c:	.word	0x6374725f
var_51419c50:	.word	0x6165725f
var_51419c54:	.word	0x2e2e2e64
var_51419c58:	.word	0x20433249
var_51419c5c:	.word	0x6c696166
var_51419c60:	.word	0x207e7e7e
var_51419c64:	.word	0x0a206425
var_51419c68:	.word	0x00000000
var_51419c6c:	.word	0x63696d70
var_51419c70:	.word	0x6374725f
var_51419c74:	.word	0x6972775f
var_51419c78:	.word	0x2e2e6574
var_51419c7c:	.word	0x4332492e
var_51419c80:	.word	0x69616620
var_51419c84:	.word	0x7e7e7e6c
var_51419c88:	.word	0x20642520
var_51419c8c:	.word	0x0000000a

PMIC_LUT2_write:	// sub_51419c90:
	stmdb	sp!, {r3, r4, r5, r6, r7, lr}
	mov	r7, r1
	ldr	r6, var_5141aa8c
	add	r5, r0, r0, lsl #2
	mov	r3, #1	
	add	r4, r5, r6
	ldrb	r0, [r6, r5]
	ldrb	r1, [r4, #1]
	mov	r2, sp
	bl	pmic_read_I2C 
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
	bl	pmic_write_I2C 
	cmp	r0, #0
	beq	_51419d04
	mov	r0, #0	
	b	ret_51419cc4 
_51419d04:
	mov	r0, #1	
	b	ret_51419cc4 	// 0x51419d08

PMIC_LUT2_read:	// sub_51419d0c:
	stmdb	sp!, {r3, r4, r5, lr}
	mov	r5, r1
	ldr	r2, var_5141aa8c 
	add	r0, r0, r0, lsl #2
	mov	r3, #1
	add	r4, r0, r2
	ldrb	r0, [r2, r0]
	ldrb	r1, [r4, #1]
	mov	r2, sp
	bl	pmic_read_I2C
	cmp	r0, #0
	beq	_51419d44
	mov	r0, #0	
ret_51419d40:
	ldmia	sp!, {r3, r4, r5, pc}
_51419d44:
	ldrb	r0, [r4, #2]
	ldrb	r1, [sp]
	and	r0, r0, r1
	ldrb	r1, [r4, #4]
	mov	r0, r0, lsr r1
	strb	r0, [r5]
	mov	r0, #1	
	b	ret_51419d40	// 0x51419d60

PMIC_LUT1_write:	// sub_51419d64:
	stmdb	sp!, {r4, lr}
	mov	ip, r1
	ldr	r3, var_5141aa90
	add	r1, r3, r0, lsl #1
	ldrb	r0, [r3, r0, lsl #1]
	mov	r3, r2
	ldrb	r1, [r1, #1]
	mov	r2, ip
	bl	pmic_write_I2C
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

PMIC_set_reg_SIMLTEN:	// sub_5141a61c:
	stmdb	sp!, {r3, lr}
	bl	read_from_0x5a0b0034_to_R0 
	cmp	r0, #6	
	bcs	_5141a648 
	mov	r1, #21	// 0x15
	mov	r0, #155	// 0x9b
	bl	PMIC_LUT2_write 
	mov	r1, #1	
	mov	r0, #152	// 0x98
	bl	PMIC_LUT2_write 
ret_5141a644:
	ldmia	sp!, {ip, pc}
_5141a648:
	mov	r0, #14	// 0xe
	str	r0, [sp]
	mov	r2, #1	
	mov	r1, sp
	mov	r0, #58	// 0x3a
	bl	PMIC_LUT1_write
	b	ret_5141a644	// 0x5141a660




var_5141aa8c:	.word	0x514422c4
var_5141aa90:	.word	0x51442140
var_5141aa94:	.word	0x51442bf0
var_5141aa98:	.word	0x0000019f
var_5141aa9c:	.word	0x00000101
var_5141aaa0:	.word	0x51445e1c
var_5141aaa4:	.word	0x00000132
var_5141aaa8:	.word	0x6978616d
var_5141aaac:	.word	0x77705f6d
var_5141aab0:	.word	0x656b5f72
var_5141aab4:	.word	0x74735f79
var_5141aab8:	.word	0x73757461
var_5141aabc:	.word	0x69616620
var_5141aac0:	.word	0x000a736c




sub_5141ab40:
	stmdb	sp!, {r3, r4, r5, lr}
	cmp	r1, #0
	bne	_5141ab5c
	mov	r1, #1
	mov	r0, #0
	bl	PMIC_LUT2_write
ret_5141ab58:
	ldmia	sp!, {r3, r4, r5, pc}
_5141ab5c:
	cmp	r0, #1
	mov	r4, #36	// 0x24
	bne	_5141ab98
	mov	r0, #41	// 0x29
	str	r0, [sp]
	mov	r2, #1
	mov	r1, sp
	mov	r0, #0
	bl	PMIC_LUT1_write
	str	r4, [sp]
	mov	r2, #1
	mov	r1, sp
	mov	r0, #1
	bl	PMIC_LUT1_write
	b	ret_5141ab58
_5141ab98:
	cmp	r0, #2
	bne	_5141abd0
	mov	r0, #40	// 0x28
	str	r0, [sp]
	mov	r2, #1
	mov	r1, sp
	mov	r0, #0
	bl	PMIC_LUT1_write
	str	r4, [sp]
	mov	r2, #1
	mov	r1, sp
	mov	r0, #1
	bl	PMIC_LUT1_write
	b	ret_5141ab58
_5141abd0:
	cmp	r0, #3
	bne	_5141ac08
	mov	r0, #43	// 0x2b
	str	r0, [sp]
	mov	r2, #1
	mov	r1, sp
	mov	r0, #0
	bl	PMIC_LUT1_write
	str	r4, [sp]
	mov	r2, #1
	mov	r1, sp
	mov	r0, #1
	bl	PMIC_LUT1_write
	b	ret_5141ab58
_5141ac08:
	mov	r0, #77	// 0x4d
	str	r0, [sp]
	mov	r2, #1
	mov	r1, sp
	mov	r0, #0
	bl	PMIC_LUT1_write
	str	r4, [sp]
	mov	r2, #1
	mov	r1, sp
	mov	r0, #1
	bl	PMIC_LUT1_write
	b	ret_5141ab58	// 0x5141ac34



sub_5141ade0:
	stmdb	sp!, {r3, r4, r5, lr}
	mov	r4, r0
	mov	r0, #2
	orr	r0, r0, r4, lsl #4
	str	r0, [sp]
	mov	r2, #1	
	mov	r1, sp
	mov	r0, #23	// 0x17
	bl	PMIC_LUT1_write 
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
	bl	SimpleDebugPrint
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
	bl	SimpleDebugPrint 
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
	bl	SimpleDebugPrint 
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
	bl	SimpleDebugPrint 
_5141af18:
	strb	r4, [r5, #1]
	ldmia	sp!, {r3, r4, r5, pc}	// 0x5141af1c

PMIC_set_reg_SRAMEN_MVTEN_LDOAEN:	// sub_5141af20:
	stmdb	sp!, {r3, lr}
	orr	r0, r0, #14
	str	r0, [sp]
	bl	read_from_0x5a0b0034_to_R0
	cmp	r0, #4	
	bcs	_5141af58
	mov	r2, #1	
	mov	r1, sp
	mov	r0, #61	// 0x3d
	bl	PMIC_LUT1_write
	mov	r2, #1
	mov	r1, sp
	mov	r0, #72	// 0x48
	bl	PMIC_LUT1_write
_5141af58:
	mov	r2, #1
	mov	r1, sp
	mov	r0, #46	// 0x2e
	bl	PMIC_LUT1_write
	ldmia	sp!, {ip, pc}	// 0x5141af68
 

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
	bl	PMIC_LUT1_write
	mov	r0, #1
	str	r0, [sp]
	mov	r2, #1
	mov	r1, sp
	mov	r0, #20	// 0x14
	bl	PMIC_LUT1_write 
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

pmic_reading_writing_B:		// sub_5141b088:
	stmdb	sp!, {r3, r4, r5, lr}
	mov	r4, #15	// 0xf
	str	r4, [sp]
	mov	r2, #1	// 0x1
	mov	r1, sp
	mov	r0, #76	// 0x4c
	bl	PMIC_LUT1_write
	mov	r1, #1	// 0x1
	mov	r0, #40	// 0x28
	bl	PMIC_LUT2_write
	mov	r1, #45	// 0x2d
	mov	r0, #172	// 0xac
	bl	PMIC_LUT2_write 
	str	r4, [sp]
	mov	r2, #1	// 0x1
	mov	r1, sp
	mov	r0, #66	// 0x42
	bl	PMIC_LUT1_write 
	mov	r1, #45	// 0x2d
	mov	r0, #178	// 0xb2
	bl	PMIC_LUT2_write 
	mov	r1, #9	// 0x9
	mov	r0, #137	// 0x89
	bl	PMIC_LUT2_write 
	bl	read_from_0x5a0b0034_to_R0 
	cmp	r0, #4	// 0x4
	bcs	_5141b100 
	mov	r1, #7	// 0x7
	mov	r0, #158	// 0x9e
	bl	PMIC_LUT2_write 
_5141b100:
	mov	r0, #19	// 0x13
	str	r0, [sp]
	mov	r2, #1	// 0x1
	mov	r1, sp
	mov	r0, #63	// 0x3f
	bl	PMIC_LUT1_write 
	mov	r2, #1	// 0x1
	mov	r1, sp
	mov	r0, #64	// 0x40
	bl	PMIC_LUT1_write 
	bl	read_from_0x5a0b0034_to_R0 
	cmp	r0, #4	// 0x4
	bcs	_5141b140
	mov	r1, #7	// 0x7
	mov	r0, #180	// 0xb4
	bl	PMIC_LUT2_write 
_5141b140:
	mov	r1, #46	// 0x2e
	mov	r0, #131	// 0x83
	bl	PMIC_LUT2_write 
	mov	r1, #7	// 0x7
	mov	r0, #127	// 0x7f
	bl	PMIC_LUT2_write 
	mov	r1, #9	// 0x9
	mov	r0, #143	// 0x8f
	bl	PMIC_LUT2_write 
	str	r4, [sp]
	mov	r2, #1	// 0x1
	mov	r1, sp
	mov	r0, #52	// 0x34
	bl	PMIC_LUT1_write 
	mov	r1, #21	// 0x15
	mov	r0, #52	// 0x34
	bl	PMIC_LUT2_write 
	mov	r0, #6	// 0x6
	str	r0, [sp]
	mov	r2, #1	// 0x1
	mov	r1, sp
	mov	r0, #95	// 0x5f
	bl	PMIC_LUT1_write 
	ldr	r0, var_5141b1a8 
	bl	sub_51430f80
ret_5141b1a4:	
	ldmia	sp!, {r3, r4, r5, pc}

var_5141b1a8:	
	.word	0x00000bb8



/*
 *  5141d000
 */

sub_5141dc50:	// MISSING
	bx	lr

sub_5141df9c:	// MISSING
	bx	lr

/*
 *  5141e000
 */

sub_5141e174:	// MISSING
	bx	lr
	
sub_5141e294:	// MISSING
	bx	lr

/*
 *  51420000
 */

var_5142069c:	.word	0x80060000
var_514206a0:	.word	0x80050000
var_514206a4:	.word	0x80130000
var_514206a8:	.word	0x515d1e40
var_514206ac:	.word	0x0000aaaa
var_514206b0:	.word	0x00005555
var_514206b4:	.word	0x80110000



sub_51420b24:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	ip, r0
	mov	r3, r2
	ldr	r0, var_5142069c
	cmp	ip, #2
	bcs	ret_51420b58 
	add	r2, ip, ip, lsl #3
	ldr	ip, var_514211c8 
	add	r2, ip, r2, lsl #4
	ldr	ip, [r2]
	cmp	ip, #1
	beq	_51420b5c 
	add	r0, r0, #0xb0000
ret_51420b58:
	ldmia	sp!, {r4, r5, r6, pc}
_51420b5c:
	ldr	r2, [r2, #136]
	mov	r4, #0	
	mov	ip, #0	
	cmp	r3, #0	
	beq	ret_51420b58
	mov	r0, #0
	ldr	lr, [r2, #12]
	cmp	lr, #0
	bls	_51420bb8 
_51420b80:
	add	r5, r2, r0, lsl #4
	ldr	r5, [r5, #16]
	cmp	r5, r1
	bne	_51420bac 
	add	r0, r2, r0, lsl #4
	add	r1, r0, #16	// 0x10
	mov	r0, r3
	mov	r2, #16	// 0x10
	bl	sub_5142fadc
	mov	ip, #1
	b	_51420bb8 
_51420bac:
	add	r0, r0, #1
	cmp	lr, r0
	bhi	_51420b80
_51420bb8:
	cmp	ip, #0	
	bne	_51420bc4
	ldr	r4, var_514211cc
_51420bc4:
	mov	r0, r4
	b	ret_51420b58	// 0x51420bc8



/*
 *  51421000
 */
var_514211bc:	.word	0x80090000
var_514211c0:	.word	0x80030000
var_514211c4:	.word	0x80140000
var_514211c8:	.word	0x515d1d20
var_514211cc:	.word	0x80070000
var_514211d0:	.word	0x80080000
var_514211d4:	.word	0x515d1ef0
var_514211d8:	.word	0x80010000

_514211dc:	.word	0xeafff27e	//	b	5141dbdc

sub_514211e0:	// MISSING
	bx	lr


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



var_5142fcec:	.word	0x5143234c
var_5142fcf0:	.word	0x514323f4
var_5142fcf4:	.word	0x514324f8
var_5142fcf8:	.word	0x51432698
var_5142fcfc:	.word	0x51432d54
var_5142fd00:	.word	0x51432edc
var_5142fd04:	.word	0x51432da4
var_5142fd08:	.word	0x51432210
var_5142fd0c:	.word	0x51433578
var_5142fd10:	.word	0x51432208
var_5142fd14:	.word	0x514335fc
var_5142fd18:	.word	0x51433620
var_5142fd1c:	.word	0x51433638
var_5142fd20:	.word	0x51432550
var_5142fd24:	.word	0x514326dc
var_5142fd28:	.word	0x514337c0
var_5142fd2c:	.word	0x5143393c
var_5142fd30:	.word	0x51433b00
var_5142fd34:	.word	0x51649170


sub_5142fadc:	// MISSING
	bx	lr

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

memcopy_R2bytes_fromR0_toR1:	// sub_5142fd38:
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

memclear_R2bytes_withR1_atR0:	// sub_5142fd5c:	
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
 * I2C_GPIO
 */

j_I2C_GPIO_Line_Open:	// sub_5142fd7c:
	b	I2C_GPIO_Line_Open

j_I2C_GPIO_Line_Close:	// sub_5142fd80:
	b	I2C_GPIO_Line_Close 

I2C_GPIO_Read_Write:	// sub_5142fd84:
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
	bl	I2C_GPIO_Condition_Start
	and	r1, r8, #254	// 0xfe
	mov	r0, fp
	bl	I2C_GPIO_Condition_WriteByte 
	mov	r1, sp
	mov	r0, fp
	bl	I2C_GPIO_Condition_GetAck 
	ldrb	r0, [sp]
	cmp	r0, #0	
	beq	_5142fdec 
	mov	r1, r8
	add	r0, pc, #520	// 0x208	// !!!! PC relative 0x5142fddc + 0x208
	bl	SimpleDebugPrint
	mvn	r5, #0	
	b	_5142fec0
_5142fdec:
	mov	r4, #0	
	b	_5142fe30
_5142fdf4:
	ldrb	r1, [r9, r4]
	mov	r0, fp
	bl	I2C_GPIO_Condition_WriteByte
	mov	r1, sp
	mov	r0, fp
	bl	I2C_GPIO_Condition_GetAck 
	ldrb	r0, [sp]
	cmp	r0, #0	
	beq	_5142fe2c 
	mov	r1, r4
	add	r0, pc, #508	// 0x1fc	// !!!! PC relative 0x5142fe1c + 0x1fc
	bl	SimpleDebugPrint 
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
	bl	I2C_GPIO_Condition_Start
	orr	r1, r8, #1
	mov	r0, fp
	bl	I2C_GPIO_Condition_WriteByte 
	mov	r1, sp
	mov	r0, fp
	bl	I2C_GPIO_Condition_GetAck
	ldrb	r0, [sp]
	cmp	r0, #0	
	beq	_5142fe80 
	mov	r1, r8
	add	r0, pc, #472	// 0x1d8	// !!!! PC relative 0x5142fe70 + 0x1d8
	bl	SimpleDebugPrint
	mvn	r5, #0
	b	_5142fec0 
_5142fe80:
	mov	r4, #0	
	sub	r7, r6, #1	
	b	_5142feb8 
_5142fe8c:
	add	r1, sl, r4
	mov	r0, fp
	bl	I2C_GPIO_Condition_ReadByte 
	cmp	r4, r7
	beq	_5142feac 
	mov	r0, fp
	bl	I2C_GPIO_Condition_SetAck 
	b	_5142feb4 
_5142feac:
	mov	r0, fp
	bl	I2C_GPIO_Condition_SetNAck 
_5142feb4:
	add	r4, r4, #1	
_5142feb8:
	cmp	r4, r6
	bcc	_5142fe8c 
_5142fec0:
	mov	r0, fp
	bl	I2C_GPIO_Condition_Stop 
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
	bl	I2C_GPIO_Read_Write 
ret_5142ff18:
	ldmia	sp!, {r2, r3, ip, pc}

I2C_GPIO_tx1:	// sub_5142ff1c:
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
	bl	SimpleDebugPrint
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
	bl	I2C_GPIO_Read_Write
	add	sp, sp, #32	// 0x20
ret_5142ff84:
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}

I2C_GPIO_tx2:	// sub_5142ff88:
	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
	sub	sp, sp, #32	// 0x20
	mov	r6, r0
	ldr	r4, [sp, #56]
	mov	r5, r2
	mov	r8, r3
	mov	r7, r1
	cmp	r4, #16	// 0x10
	bls	_5142ffb4
	add	r0, pc, #208	// 0xd0		// !!!! PC relative 0x5142ffac + 0xd0
	bl	SimpleDebugPrint
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
	bl	I2C_GPIO_Read_Write
	add	sp, sp, #32	// 0x20
ret_5142ffe8:
	ldmia	sp!, {r4, r5, r6, r7, r8, pc}


/*
 *  51430000
 */

I2C_GPIO_Line_Open:	// sub_514300a8:
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
	bl	SimpleDebugPrint
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
	bl	SimpleDebugPrint
	mov	r0, #0
_51430134:
	.word	0xecbd8b02	//	fldmiad	sp!, {d8}
	ldmia	sp!, {r4, r5, r6, r7, r8, pc}
_5143013c:
	mov	r1, r5
	add	r0, pc, #512	// 0x200	// !!!! PC relative 0x51430140 + 0x200
	bl	SimpleDebugPrint
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
	bl	value_table_sub_B
	mov	r1, #1
	mov	r0, r7
	bl	value_table_sub_B
	mov	r1, #1
	mov	r0, r6
	bl	value_table_sub_A
	mov	r1, #1
	mov	r0, r7
	bl	value_table_sub_A
	mov	r0, #0	
	b	_51430134	// 0x514301dc

I2C_GPIO_Line_Close:	// sub_514301e0:
	stmdb	sp!, {r4, lr}
	mov	r4, r0
	cmp	r4, #6
	bcc	_51430200
	mov	r2, #117	// 0x75
	add	r1, pc, #224	// 0xe0	// !!!! PC relative 0x514301f4 + 0xe0
	add	r0, pc, #240	// 0xf0	// !!!! PC relative 0x514301f8 + 0xf0
	bl	SimpleDebugPrint
_51430200:
	ldr	r2, var_51430314
	add	r0, r4, r4, lsl #1
	ldrb	r1, [r2, r0, lsl #2]
	cmp	r1, #0	
	bne	_51430228 
	mov	r1, r4
	add	r0, pc, #368	// 0x170	// !!!! PC relative 0x51430218 + 0x170 
	bl	SimpleDebugPrint 
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
	bl	value_table_sub_A 
	ldrb	r0, [r4, #2]
	mov	r1, #0
	bl	value_table_sub_A 
	ldrb	r0, [r4, #1]
	mov	r1, #0
	bl	value_table_sub_B 
	ldrb	r0, [r4, #2]
	mov	r1, #0
	bl	value_table_sub_B 
_51430288:
	mov	r0, #0
	b	ret_51430224 // 0x5143028c

I2C_GPIO_Line_ConfigSDA:	// sub_51430290:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r4, r0
	mov	r5, r1
	cmp	r4, #6
	bcc	_514302b4
	mov	r2, #156	// 0x9c
	add	r1, pc, #44	// 0x2c	// !!!! PC relative !!!! 0x514302a8 + 0x2c
	add	r0, pc, #60	// 0x3c	// !!!! PC relative !!!! 0x514302ac + 0x3c
	bl	SimpleDebugPrint
_514302b4:
	ldr	r1, var_51430314
	add	r0, r4, r4, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0	
	bne	_514303ec
	mov	r1, r4
	add	r0, pc, #232	// 0xe8	// !!!! PC relative !!!! 0x514302cc + 0xe8
	bl	SimpleDebugPrint
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
	bl	value_table_sub_A
	mov	r0, #0
	b	ret_514302d8	// 0x51430400

I2C_GPIO_Line_ConfigSCL:	// sub_51430404:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r4, r0
	mov	r5, r1
	cmp	r4, #6
	bcc	_51430428
	mov	r2, #181	// 0xb5
	sub	r1, pc, #328	// 0x148	// !!!! PC relative !!!!! 0x5143041c + 0x148
	sub	r0, pc, #312	// 0x138	// !!!! PC relative !!!!! 0x51430420 + 0x138
	bl	SimpleDebugPrint
_51430428:
	ldr	r1, var_51430314
	add	r0, r4, r4, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0	
	bne	_51430450 
	mov	r1, r4
	add	r0, pc, #616	// 0x268	// !!!! PC relative !!!!! 0x51430440 + 0x268
	bl	SimpleDebugPrint
	mvn	r0, #0	
ret_5143044c:
	ldmia	sp!, {r4, r5, r6, pc}
_51430450:
	add	r0, r1, r0, lsl #2
	mov	r1, r5
	ldrb	r0, [r0, #1]
	bl	value_table_sub_A
	mov	r0, #0	
_51430464:
	b	ret_5143044c 

I2C_GPIO_Line_SetSDA:	// sub_51430468:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r4, r0
	mov	r5, r1
	cmp	r4, #6	
	bcc	_5143048c 
	mov	r2, #206	// 0xce
	sub	r1, pc, #428	// 0x1ac	// !!!! PC relative !!!!! 0x51430480 +0x1ac
	sub	r0, pc, #412	// 0x19c	// !!!! PC relative !!!!! 0x51430484 +0x19c
	bl	SimpleDebugPrint
_5143048c:
	ldr	r1, var_51430314
	add	r0, r4, r4, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0
	bne	_514304b4 
	mov	r1, r4
	add	r0, pc, #564	// 0x234	// !!!! PC relative !!!!! 0x514304a4 +0x234
	bl	SimpleDebugPrint
	mvn	r0, #0	
ret_514304b0:
	ldmia	sp!, {r4, r5, r6, pc}
_514304b4:
	add	r0, r1, r0, lsl #2
	mov	r1, r5
	ldrb	r0, [r0, #2]
	bl	value_table_sub_B 
	mov	r0, #0
	b	ret_514304b0 	// 0x514304c8

I2C_GPIO_Line_SetSCL:	// sub_514304cc:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r4, r0
	mov	r5, r1
	cmp	r4, #6
	bcc	_514304f0 
	mov	r2, #231	
	sub	r1, pc, #528	// 0x210	// !!!! PC relative !!!!! 0x514304e4 +0x210
	sub	r0, pc, #512	// 0x200	// !!!! PC relative !!!!! 0x514304e8 +0x200
	bl	SimpleDebugPrint
_514304f0:
	ldr	r1, var_51430314
	add	r0, r4, r4, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0
	bne	_51430518 
	mov	r1, r4
	add	r0, pc, #508	// 0x1fc	// !!!! PC relative !!!!! 0x51430508 +0x1fc
	bl	SimpleDebugPrint 
	mvn	r0, #0	
ret_51430514:	
	ldmia	sp!, {r4, r5, r6, pc}
_51430518:
	add	r0, r1, r0, lsl #2
	mov	r1, r5
	ldrb	r0, [r0, #1]
	bl	value_table_sub_B 
	mov	r0, #0	
	b	ret_51430514 	// 0x5143052c

I2C_GPIO_Line_GetSDA:	// sub_51430530:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r4, r0
	mov	r5, r1
	cmp	r4, #6	
	bcc	_51430554
	mov	r2, #256	// 0x100
	sub	r1, pc, #628	// 0x274	// !!!! PC relative !!!! 0x51430548 + 0x274
	sub	r0, pc, #612	// 0x264	// !!!! PC relative !!!! 0x5143054c + 0x264
	bl	SimpleDebugPrint
_51430554:
	ldr	r1, var_51430314
	add	r0, r4, r4, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0	
	bne	_5143057c
	mov	r1, r4
	add	r0, pc, #452	// 0x1c4	// !!!! PC relative !!!! 0x5143056c + 0x452
	bl	SimpleDebugPrint
	mvn	r0, #0	
ret_51430578:
	ldmia	sp!, {r4, r5, r6, pc}
_5143057c:
	add	r0, r1, r0, lsl #2
	ldrb	r0, [r0, #2]
	bl	value_table_sub_C
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

I2C_GPIO_Condition_Start:	// sub_514305b8:
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	mov	r8, r0
	mov	r4, #0
	cmp	r8, #6	
	bcc	_514305dc
	ldr	r2, var_51430764
	sub	r1, pc, #764	// 0x2fc	// !!!! PC relative !!!!! 0x514305d0 + 0x2fc
	sub	r0, pc, #748	// 0x2ec	// !!!! PC relative !!!!! 0x514305d4 + 0x2ec
	bl	SimpleDebugPrint
_514305dc:
	ldr	r1, var_51430314
	add	r0, r8, r8, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0
	bne	_51430604
	mov	r1, r8
	add	r0, pc, #364	// 0x16c	// !!!! PC relative !!!!! 0x514305f4 + 0x16c
	bl	SimpleDebugPrint 
	mvn	r0, #0	
ret_51430600:
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
_51430604:
	add	r7, r1, r0, lsl #2
	ldr	r5, [r7, #8]
	mov	r1, #1	
	mov	r0, r8
	bl	I2C_GPIO_Line_SetSDA
	mov	r1, #0	
	mov	r0, r8
	bl	I2C_GPIO_Line_ConfigSCL 
	ldr	r9, var_51430798
	mov	sl, r5, lsr #1
_5143062c:
	ldrb	r0, [r7, #1]
	bl	value_table_sub_C 
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
	bl	I2C_GPIO_Line_SetSCL 
	mov	r1, #1	
	mov	r0, r8
	bl	I2C_GPIO_Line_ConfigSCL 
	mov	r1, #1	
	mov	r0, r8
	bl	I2C_GPIO_Line_SetSCL 
	mov	r0, r5
	bl	sub_51430f80 
	mov	r1, #0	
	mov	r0, r8
	bl	I2C_GPIO_Line_SetSDA 
	mov	r0, sl
	bl	sub_51430f80 
	mov	r1, #0	
	mov	r0, r8
	bl	I2C_GPIO_Line_SetSCL 
	mov	r0, sl
	bl	sub_51430f80 
	mov	r0, #0	
	b	ret_51430600	// 0x514306ac

var_514306b0:	.word	0x4332495b
var_514306b4:	.word	0x4950475f
var_514306b8:	.word	0x694c5f4f
var_514306bc:	.word	0x435f656e
var_514306c0:	.word	0x69666e6f
var_514306c4:	.word	0x4c435367
var_514306c8:	.word	0x6f4e205d
var_514306cc:	.word	0x704f2074
var_514306d0:	.word	0x64656e65
var_514306d4:	.word	0x6843203a
var_514306d8:	.word	0x29642528
var_514306dc:	.word	0x00000a20
var_514306e0:	.word	0x4332495b
var_514306e4:	.word	0x4950475f
var_514306e8:	.word	0x694c5f4f
var_514306ec:	.word	0x535f656e
var_514306f0:	.word	0x44537465
var_514306f4:	.word	0x4e205d41
var_514306f8:	.word	0x4f20746f
var_514306fc:	.word	0x656e6570
var_51430700:	.word	0x43203a64
var_51430704:	.word	0x64252868
var_51430708:	.word	0x000a2029
var_5143070c:	.word	0x4332495b
var_51430710:	.word	0x4950475f
var_51430714:	.word	0x694c5f4f
var_51430718:	.word	0x535f656e
var_5143071c:	.word	0x43537465
var_51430720:	.word	0x4e205d4c
var_51430724:	.word	0x4f20746f
var_51430728:	.word	0x656e6570
var_5143072c:	.word	0x43203a64
var_51430730:	.word	0x64252868
var_51430734:	.word	0x000a2029
var_51430738:	.word	0x4332495b
var_5143073c:	.word	0x4950475f
var_51430740:	.word	0x694c5f4f
var_51430744:	.word	0x475f656e
var_51430748:	.word	0x44537465
var_5143074c:	.word	0x4e205d41
var_51430750:	.word	0x4f20746f
var_51430754:	.word	0x656e6570
var_51430758:	.word	0x43203a64
var_5143075c:	.word	0x64252868
var_51430760:	.word	0x000a2029
var_51430764:	.word	0x00000137
var_51430768:	.word	0x4332495b
var_5143076c:	.word	0x4950475f
var_51430770:	.word	0x6f435f4f
var_51430774:	.word	0x7469646e
var_51430778:	.word	0x5f6e6f69
var_5143077c:	.word	0x72617453
var_51430780:	.word	0x4e205d74
var_51430784:	.word	0x4f20746f
var_51430788:	.word	0x656e6570
var_5143078c:	.word	0x43203a64
var_51430790:	.word	0x64252868
var_51430794:	.word	0x000a2029
var_51430798:	.word	0x000186a0

I2C_GPIO_Condition_Stop:	// sub_5143079c:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r4, r0
	cmp	r4, #6
	bcc	_514307bc
	ldr	r2, var_514309d0
	ldr	r1, var_514309d4 
	ldr	r0, var_514309d8
	bl	SimpleDebugPrint 
_514307bc:
	ldr	r1, var_51430314 
	add	r0, r4, r4, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0	
	bne	_514307e4
	mov	r1, r4
	add	r0, pc, #512	// 0x200	// !!!! PC relative !!!!! 0x514307d4 +0x200
	bl	SimpleDebugPrint
	mvn	r0, #0
ret_514307e0:
	ldmia	sp!, {r4, r5, r6, pc}
_514307e4:
	add	r0, r1, r0, lsl #2
	ldr	r5, [r0, #8]
	mov	r1, #0
	mov	r0, r4
	bl	I2C_GPIO_Line_SetSDA
	mov	r5, r5, lsr #1
	mov	r0, r5
	bl	sub_51430f80 
	mov	r1, #1	
	mov	r0, r4
	bl	I2C_GPIO_Line_SetSCL
	mov	r0, r5
	bl	sub_51430f80 
	mov	r1, #1	
	mov	r0, r4
	bl	I2C_GPIO_Line_SetSDA 
	mov	r0, r5
	bl	sub_51430f80 
	mov	r0, #0	
	b	ret_514307e0	// 0x51430830

I2C_GPIO_Condition_WriteBit:	// sub_51430834:
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	mov	r7, r0
	mov	r6, r1
	mov	r4, #0	
	cmp	r7, #6	
	bcc	_5143085c 
	ldr	r1, var_514309d4 
	ldr	r0, var_514309d8
	mov	r2, #448	// 0x1c0
	bl	SimpleDebugPrint
_5143085c:
	ldr	r1, var_51430314
	add	r0, r7, r7, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0
	bne	_51430884 
	mov	r1, r7
	add	r0, pc, #400	// 0x190	// !!!! PC relative 0x51430874 + 0x190
	bl	SimpleDebugPrint
	mvn	r0, #0	
ret_51430880:
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
_51430884:
	add	r5, r1, r0, lsl #2
	ldr	r8, [r5, #8]
	mov	r1, r6
	mov	r0, r7
	bl	I2C_GPIO_Line_SetSDA 
	mov	sl, r8, lsr #1
	mov	r0, sl
	bl	sub_51430f80 
	mov	r1, #0	
	mov	r0, r7
	bl	I2C_GPIO_Line_ConfigSCL 
	ldr	r9, var_51430798 
_514308b4:
	ldrb	r0, [r5, #1]
	bl	value_table_sub_C 
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
	bl	I2C_GPIO_Line_SetSCL 
	mov	r1, #1	
	mov	r0, r7
	bl	I2C_GPIO_Line_ConfigSCL 
	mov	r1, #1	
	mov	r0, r7
	bl	I2C_GPIO_Line_SetSCL 
	mov	r0, r8
	bl	sub_51430f80 
	mov	r1, #0	
	mov	r0, r7
	bl	I2C_GPIO_Line_SetSCL 
	mov	r0, sl
	bl	sub_51430f80 
	mov	r0, #0	
	b	ret_51430880 	// 0x51430928

I2C_GPIO_Condition_ReadBit:	// sub_5143092c:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r4, r0
	mov	r6, r1
	cmp	r4, #6
	bcc	_51430950
	ldr	r2, var_51430a40
	sub	r1, pc, #1648	// 0x670	// !!!! PC relative 0x51430944 - 0x670
	sub	r0, pc, #1632	// 0x660	// !!!! PC relative 0x51430948 - 0x660
	bl	SimpleDebugPrint
_51430950:
	ldr	r1, var_51430314
	add	r0, r4, r4, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0
	bne	_51430978
	mov	r1, r4
	add	r0, pc, #212	// 0xd4	// !!!! PC relative 0x51430968 + 0xd4
	bl	SimpleDebugPrint
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
	bl	I2C_GPIO_Line_SetSCL
	mov	r0, r5
	bl	sub_51430f80
	mov	r1, r6
	mov	r0, r4
	bl	I2C_GPIO_Line_GetSDA
	mov	r0, r5
	bl	sub_51430f80
	mov	r1, #0
	mov	r0, r4
	bl	I2C_GPIO_Line_SetSCL
	mov	r0, r5
	bl	sub_51430f80
	mov	r0, #0
	b	ret_51430974	// 0x514309cc

var_514309d0:	.word	0x00000179
var_514309d4:	.word	0x514302dc
var_514309d8:	.word	0x514302f0
var_514309dc:	.word	0x4332495b
var_514309e0:	.word	0x4950475f
var_514309e4:	.word	0x6f435f4f
var_514309e8:	.word	0x7469646e
var_514309ec:	.word	0x5f6e6f69
var_514309f0:	.word	0x706f7453
var_514309f4:	.word	0x6f4e205d
var_514309f8:	.word	0x704f2074
var_514309fc:	.word	0x64656e65
var_51430a00:	.word	0x6843203a
var_51430a04:	.word	0x29642528
var_51430a08:	.word	0x00000a20
var_51430a0c:	.word	0x4332495b
var_51430a10:	.word	0x4950475f
var_51430a14:	.word	0x6f435f4f
var_51430a18:	.word	0x7469646e
var_51430a1c:	.word	0x5f6e6f69
var_51430a20:	.word	0x74697257
var_51430a24:	.word	0x74694265
var_51430a28:	.word	0x6f4e205d
var_51430a2c:	.word	0x704f2074
var_51430a30:	.word	0x64656e65
var_51430a34:	.word	0x6843203a
var_51430a38:	.word	0x29642528
var_51430a3c:	.word	0x00000a20
var_51430a40:	.word	0x000001fe
var_51430a44:	.word	0x4332495b
var_51430a48:	.word	0x4950475f
var_51430a4c:	.word	0x6f435f4f
var_51430a50:	.word	0x7469646e
var_51430a54:	.word	0x5f6e6f69
var_51430a58:	.word	0x64616552
var_51430a5c:	.word	0x5d746942
var_51430a60:	.word	0x746f4e20
var_51430a64:	.word	0x65704f20
var_51430a68:	.word	0x3a64656e
var_51430a6c:	.word	0x28684320
var_51430a70:	.word	0x20296425
var_51430a74:	.word	0x0000000a

I2C_GPIO_Condition_GetAck:	// sub_51430a78:
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	mov	r8, r0
	mov	r5, r1
	mov	r4, #0
	cmp	r8, #6
	bcc	_51430aa0
	ldr	r2, var_51430cd4 
	sub	r1, pc, #1984	// 0x7c0	// !!!! PC relative !!!!! 0x51430a94 + 0x7c0
	sub	r0, pc, #1968	// 0x7b0	// !!!! PC relative !!!!! 0x51430a98 + 0x7b0
	bl	SimpleDebugPrint
_51430aa0:
	ldr	r1, var_51430314
	add	r0, r8, r8, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0
	bne	_51430ac8
	mov	r1, r8
	add	r0, pc, #536	// 0x218	// !!!! PC relative !!!!! 0x51430ab8 + 0x218
	bl	SimpleDebugPrint
	mvn	r0, #0	
ret_51430ac4:
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
_51430ac8:
	add	r7, r1, r0, lsl #2
	ldr	r6, [r7, #8]
	mov	r1, #0
	mov	r0, r8
	bl	I2C_GPIO_Line_ConfigSDA 
	mov	r0, r6
	bl	sub_51430f80
	mov	r1, #0	
	mov	r0, r8
	bl	I2C_GPIO_Line_ConfigSCL 
	ldr	r9, var_51430798
	mov	sl, r6, lsr #1
_51430af8:
	ldrb	r0, [r7, #1]
	bl	value_table_sub_C
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
	bl	I2C_GPIO_Line_SetSCL
	mov	r1, #1	
	mov	r0, r8
	bl	I2C_GPIO_Line_ConfigSCL 
	mov	r1, #1
	mov	r0, r8
	bl	I2C_GPIO_Line_SetSCL
	mov	r0, sl
	bl	sub_51430f80 
	mov	r1, r5
	mov	r0, r8
	bl	I2C_GPIO_Line_GetSDA 
	mov	r0, sl
	bl	sub_51430f80
	mov	r1, #0
	mov	r0, r8
	bl	I2C_GPIO_Line_SetSCL 
	mov	r1, #1	
	mov	r0, r8
	bl	I2C_GPIO_Line_ConfigSDA 
	mov	r0, sl
	bl	sub_51430f80 
	mov	r0, #0	
	b	ret_51430ac4 	// 0x51430b88

I2C_GPIO_Condition_SetAck:	// sub_51430b8c:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r5, r0
	cmp	r5, #6	
	bcc	_51430bac 
	ldr	r1, var_514309d4 
	ldr	r0, var_514309d8
	mov	r2, #644	// 0x284
	bl	SimpleDebugPrint 
_51430bac:
	ldr	r1, var_51430314
	add	r0, r5, r5, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0	
	bne	_51430bd4
	mov	r1, r5
	add	r0, pc, #320	// 0x140 // !!!! PC relative 0x15430bc4 + 0x140
	bl	SimpleDebugPrint
	mvn	r0, #0
ret_51430bd0:
	ldmia	sp!, {r4, r5, r6, pc}
_51430bd4:
	add	r0, r1, r0, lsl #2
	ldr	r4, [r0, #8]
	mov	r1, #1	
	mov	r0, r5
	bl	I2C_GPIO_Line_ConfigSDA
	mov	r1, #0	
	mov	r0, r5
	bl	I2C_GPIO_Line_SetSDA
	mov	r6, r4, lsr #1
	mov	r0, r6
	bl	sub_51430f80
	mov	r1, #1	
	mov	r0, r5
	bl	I2C_GPIO_Line_SetSCL
	mov	r0, r4
	bl	sub_51430f80
	mov	r1, #0
	mov	r0, r5
	bl	I2C_GPIO_Line_SetSCL
	mov	r0, r6
	bl	sub_51430f80 
	mov	r0, #0	
	b	ret_51430bd0 	// 0x51430c2c

I2C_GPIO_Condition_SetNAck:	// sub_51430c30:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r5, r0
	cmp	r5, #6
	bcc	_51430c50 
	ldr	r2, var_51430d40 
	sub	r1, pc, #2416	// 0x970	// !!!! PC relative 0x15430c44 - 0x970
	sub	r0, pc, #2400	// 0x960	// !!!! PC relative 0x15430c48 - 0x960
	bl	SimpleDebugPrint 
_51430c50:
	ldr	r1, var_51430314
	add	r0, r5, r5, lsl #1
	ldrb	r2, [r1, r0, lsl #2]
	cmp	r2, #0
	bne	_51430c78
	mov	r1, r5
	add	r0, pc, #212	// 0xd4		// !!!! PC relative 0x15430b68 + 0xd4
	bl	SimpleDebugPrint
	mvn	r0, #0	
ret_51430c74:
	ldmia	sp!, {r4, r5, r6, pc}
_51430c78:
	add	r0, r1, r0, lsl #2
	ldr	r4, [r0, #8]
	mov	r1, #1
	mov	r0, r5
	bl	I2C_GPIO_Line_ConfigSDA
	mov	r1, #1	
	mov	r0, r5
	bl	I2C_GPIO_Line_SetSDA
	mov	r6, r4, lsr #1
	mov	r0, r6
	bl	sub_51430f80 
	mov	r1, #1	
	mov	r0, r5
	bl	I2C_GPIO_Line_SetSCL
	mov	r0, r4
	bl	sub_51430f80
	mov	r1, #0	
	mov	r0, r5
	bl	I2C_GPIO_Line_SetSCL
	mov	r0, r6
	bl	sub_51430f80
	mov	r0, #0	
	b	ret_51430c74	// 0x51430cd0

var_51430cd4:	.word	0x00000233
var_51430cd8:	.word	0x4332495b
var_51430cdc:	.word	0x4950475f
var_51430ce0:	.word	0x6f435f4f
var_51430ce4:	.word	0x7469646e
var_51430ce8:	.word	0x5f6e6f69
var_51430cec:	.word	0x41746547
var_51430cf0:	.word	0x205d6b63
var_51430cf4:	.word	0x20746f4e
var_51430cf8:	.word	0x6e65704f
var_51430cfc:	.word	0x203a6465
var_51430d00:	.word	0x25286843
var_51430d04:	.word	0x0a202964
var_51430d08:	.word	0x00000000
var_51430d0c:	.word	0x4332495b
var_51430d10:	.word	0x4950475f
var_51430d14:	.word	0x6f435f4f
var_51430d18:	.word	0x7469646e
var_51430d1c:	.word	0x5f6e6f69
var_51430d20:	.word	0x41746553
var_51430d24:	.word	0x205d6b63
var_51430d28:	.word	0x20746f4e
var_51430d2c:	.word	0x6e65704f
var_51430d30:	.word	0x203a6465
var_51430d34:	.word	0x25286843
var_51430d38:	.word	0x0a202964
var_51430d3c:	.word	0x00000000
var_51430d40:	.word	0x000002ae
var_51430d44:	.word	0x4332495b
var_51430d48:	.word	0x4950475f
var_51430d4c:	.word	0x6f435f4f
var_51430d50:	.word	0x7469646e
var_51430d54:	.word	0x5f6e6f69
var_51430d58:	.word	0x4e746553
var_51430d5c:	.word	0x5d6b6341
var_51430d60:	.word	0x746f4e20
var_51430d64:	.word	0x65704f20
var_51430d68:	.word	0x3a64656e
var_51430d6c:	.word	0x28684320
var_51430d70:	.word	0x20296425
var_51430d74:	.word	0x0000000a

I2C_GPIO_Condition_WriteByte:	// sub_51430d78:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r5, r0
	mov	r6, r1
	cmp	r5, #6	
	bcc	_51430d9c 
	ldr	r1, var_514309d4 
	ldr	r0, var_514309d8 
	mov	r2, #728	// 0x2d8
	bl	SimpleDebugPrint 
_51430d9c:
	ldr	r1, var_51430314 
	add	r0, r5, r5, lsl #1
	ldrb	r0, [r1, r0, lsl #2]
	cmp	r0, #0
	bne	_51430dc4 
	mov	r1, r5
	add	r0, pc, #344	// 0x158		// !!!! PC relative !!!!!
	bl	SimpleDebugPrint
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
	bl	I2C_GPIO_Condition_WriteBit
	add	r0, r4, #1
	and	r4, r0, #255	// 0xff
	cmp	r4, #8
	bcc	_51430dc8
	mov	r1, #0
	mov	r0, r5
	bl	I2C_GPIO_Line_SetSDA 
	mov	r0, #0
	b	ret_51430dc0	// 0x51430dfc

I2C_GPIO_Condition_ReadByte:	// sub_51430e00:
	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov	r6, r0
	mov	r5, r1
	mov	r4, #0	
	cmp	r6, #6	
	bcc	_51430e28 
	ldr	r2, var_51430f48 
	ldr	r1, var_514309d4 
	ldr	r0, var_514309d8 
	bl	SimpleDebugPrint 
_51430e28:
	ldr	r8, var_51430314 
	add	r7, r6, r6, lsl #1
	ldrb	r0, [r8, r7, lsl #2]
	cmp	r0, #0	
	bne	_51430e50
	mov	r1, r6
	add	r0, pc, #260	// 0x104	// !!!! PC relative 0x51430e40 + 0x104
	bl	SimpleDebugPrint 
	mvn	r0, #0	
ret_51430e4c:
	ldmia	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_51430e50:
	mov	r1, #0	
	mov	r0, r6
	bl	I2C_GPIO_Line_ConfigSDA 
	add	r7, r8, r7, lsl #2
	ldr	r0, [r7, #8]
	mov	r0, r0, lsr #2
	bl	sub_51430f80 
	mov	r1, #0
	mov	r0, r6
	bl	I2C_GPIO_Line_ConfigSCL 
	ldr	r8, var_51430798 
_51430e7c:
	ldrb	r0, [r7, #1]
	bl	value_table_sub_C
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
	bl	I2C_GPIO_Line_SetSCL 
	mov	r1, #1	
	mov	r0, r6
	bl	I2C_GPIO_Line_ConfigSCL
	mov	r0, #0	
	strb	r0, [r5]
	mov	r4, #0
_51430ed4:
	mov	r1, sp
	mov	r0, r6
	bl	I2C_GPIO_Condition_ReadBit 
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
	bl	I2C_GPIO_Line_ConfigSDA 
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

sub_51430fbc:	// MISSING
	bx	lr

/*
 *  51431000
 */
 
sub_514310b8:
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	mov	r4, r0
	ldr	r7, var_514311a0
	ldr	r8, var_514311a4
	add	r6, r7, r4, lsl #3
	ldr	r0, [r6, #4]
	cmp	r0, #0
	beq	_514310e0
	str	r4, [r8]
ret_514310dc:
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
_514310e0:
	mov	r0, #4
	bl	SYSCON_related_a
	mov	r5, r0
	cmp	r4, #0
	bne	_51431124
	str	r5, [r7, r4, lsl #3]
	mov	r0, #10	// 0xa
	str	r0, [r6, #4]
	str	r4, [r8]
	mov	r5, #100	// 0x64
	mov	r4, #1
_5143110c:
	mul	r0, r4, r5
	bl	sub_51430fbc
	add	r4, r4, #1
	cmp	r4, #4
	bls	_5143110c
	b	ret_514310dc
_51431124:
	str	r5, [r7, r4, lsl #3]
	ldr	r0, [r7, #4]
	ldr	r1, [r7]
	mul	r0, r5, r0
	bl	sub_5143fee8
	mov	r9, r0
	str	r0, [r6, #4]
	ldr	r0, [r7, #4]
	ldr	r1, [r7]
	mul	r0, r5, r0
	bl	sub_5143fee8
	cmp	r1, #0
	beq	_51431160
	add	r0, r9, #1
	str	r0, [r6, #4]
_51431160:
	str	r4, [r8]
	b	ret_514310dc	// 0x51431164

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
	b	sub_514310b8

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
	addls	pc, pc, fp, lsl #2	// JUMPTABLE
_51431220:
	b	ret_5143126c
	b	_5143123c
	b	_51431270
	b	_514312a4
	b	_514312d8
	b	_5143132c
 	b	_51431380	// 0x51431238
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
_5143132c:
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
	addls	pc, pc, ip, lsl #2	// JUMPTABLE
_5143150c:	
	b	sub_514315ac	
	b	sub_514315ac	
	b	sub_5143152c	
	b	sub_51431540	
	b	sub_51431558	
	b	sub_51431570	
	b	sub_51431584
 	b	sub_5143159c	// 0x51431528
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
	bl	SimpleDebugPrint 
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
	bl	SimpleDebugPrint 
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




var_514319c4:	.word	0x51649438
var_514319c8:	.word	0x70100000
var_514319cc:	.word	0x70180000
var_514319d0:	.word	0x51649338
var_514319d4:	.word	0x000001ff
var_514319d8:	.word	0x000003ff
var_514319dc:	.word	0x000007ff
var_514319e0:	.word	0x00000fff
var_514319e4:	.word	0x0303c884
var_514319e8:	.word	0x51446144
var_514319ec:	.word	0x4f5b0a0a
var_514319f0:	.word	0x5d444c43
var_514319f4:	.word	0x7272455b
var_514319f8:	.word	0x5d64253a
var_514319fc:	.word	0x736f4c20
var_51431a00:	.word	0x61702065
var_51431a04:	.word	0x6e656974
var_51431a08:	.word	0x77206563
var_51431a0c:	.word	0x69746961
var_51431a10:	.word	0x4920676e
var_51431a14:	.word	0x0a20544e
var_51431a18:	.word	0x00000a0a



sub_51431fb8:
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, lr}
	cmp	r2, #0	
	beq	ret_514320fc 
	cmp	r3, #0	
	beq	ret_514320fc 
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




var_51432a9c:	.word	0x51649238
var_51432aa0:	.word	0x800a0000
var_51432aa4:	.word	0x51431b3c
var_51432aa8:	.word	0x51431694
var_51432aac:	.word	0x514317a0
var_51432ab0:	.word	0x514318ac
var_51432ab4:	.word	0xaaaaaaaa
var_51432ab8:	.word	0x514431e4
var_51432abc:	.word	0x00003fff
var_51432ac0:	.word	0x51649318
var_51432ac4:	.word	0x51446154
var_51432ac8:	.word	0x80120000



/*
 *  51433000
 */ 

var_51433a7c:	.word	0x51649338
var_51433a80:	.word	0x80090000
var_51433a84:	.word	0x514319ec
var_51433a88:	.word	0x51446144
var_51433a8c:	.word	0x80030000
var_51433a90:	.word	0x51649438
var_51433a94:	.word	0x70100000
var_51433a98:	.word	0x70180000
var_51433a9c:	.word	0x80010000
var_51433aa0:	.word	0x800d0000
var_51433aa4:	.word	0x80070000
var_51433aa8:	.word	0x00008005
var_51433aac:	.word	0x0303c938
var_51433ab0:	.word	0x80020000

sub_51433ab4:
	stmdb	sp!, {r4, lr}
	bl	sub_51431694
	mov	r0, #0
	ldmia	sp!, {r4, pc}
	ldr	r1, var_51433a90
	add	r0, r1, r0, lsl #4
	ldr	r0, [r0, #4]
	bx	lr	// 0x51433ad0

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




var_51433b50:	.word	0x51649238

sub_51433b54:
	mrc	15, 0, r0, cr1, cr0, 0
	orr	r0, r0, #0x1000000
	mcr	15, 0, r0, cr1, cr0, 0
	bx	lr	// 0x51433b60

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
	bx      lr	// 0x51433bc0




sub_51433c88:
	stmdb	sp!, {r0, r1, r2, r3, r4, r5, lr}
	mov	r5, r0
	bl	sub_51433b84
	ldr	r1, var_51433db8
	mov	r2, #0
	mov	r3, #0
_51433ca0:
	add	r3, r3, #1
	mov	r4, #0
	mcr	15, 0, r2, cr7, cr10, 4
	mcr	15, 0, r2, cr7, cr10, 5
	cmp	r3, #2	
	streq	r5, [r1]
_51433cb8:
	add	r4, r4, #1
	cmp	r4, #256	// 0x100
	bne	_51433cb8 
	cmp	r3, #2	
	bne	_51433ca0
	bl	sub_51433b74 
ret_51433cd0:
	ldmia	sp!, {r0, r1, r2, r3, r4, r5, lr}

sub_51433cd4:
	mov	pc, lr	// 0x51433cd4


var_51433db4:	.word	0x7e00f900
var_51433db8:	.word	0x7e00f020

sub_51433dbc:
	stmdb	sp!, {r4, lr}
	mov	r4, #0
	mov	r1, r0
	ldr	r0, var_514347c4
	cmp	r1, #60	// 0x3c
	addls	pc, pc, r1, lsl #2	// JUMPTABLE
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
	bne	_5143404c
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
	bl	SimpleDebugPrint
	ldr	r0, var_51434804
	ldr	r1, [r0]
	orr	r1, r1, #0x800000
	str	r1, [r0]
_514344f4:
	mov	r0, r4
	ldmia	sp!, {r4, pc}	// 0x514344f8




var_514347c4:	.word	0x7e00f000
var_514347c8:	.word	0x5359535b
var_514347cc:	.word	0x5d4e4f43
var_514347d0:	.word	0x7272455b
var_514347d4:	.word	0x3353205d
var_514347d8:	.word	0x31343643
var_514347dc:	.word	0x79535f30
var_514347e0:	.word	0x6e6f4373
var_514347e4:	.word	0x4373495f
var_514347e8:	.word	0x6b636f6c
var_514347ec:	.word	0x69746147
var_514347f0:	.word	0x2928676e
var_514347f4:	.word	0x44202d20
var_514347f8:	.word	0x63697665
var_514347fc:	.word	0x44492065
var_51434800:	.word	0x00000a20
var_51434804:	.word	0x51446d48




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
	bl	SimpleDebugPrint
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
	bl	SimpleDebugPrint
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
	bl	SimpleDebugPrint
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
	bl	SimpleDebugPrint 
	ldr	r0, var_51435d48 
	ldr	r1, [r0]
	orr	r1, r1, #0x40000000
	str	r1, [r0]
	mov	r0, #0
	b	ret_51435c20 	// 0x51435c50

sub_51435c54:
	stmdb	sp!, {r4, lr}
	mov	r4, #0
	ldr	r2, var_51435d90
	ldr	r3, var_51435d80 
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
	bl	SimpleDebugPrint 
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
	beq	ret_51435e38
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
	addls	pc, pc, r0, lsl #2	// JUMPTABLE
_514362c8:	
	b	_5143675c
	b	_5143675c
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	_5143669c
	b	_514363dc
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	_5143640c
	b	_51436490
	b	_514364c0
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	_514364f0
	b	_51436520
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	_51436550
	b	ret_51436408
	b	_51436580
	b	ret_51436408
	b	_514365b0
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	_514364f0
	b	_51436520
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	_514365dc
	b	ret_51436408
	b	ret_51436408
	b	_5143660c
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	ret_51436408
	b	_5143663c
	b	_5143663c
	b	_5143663c
	b	_5143663c
	b	_5143666c
	b	ret_51436408
	b	ret_51436408
	b	_5143675c
	b	_5143675c
	b	_514366cc
	b	ret_51436408
	b	_514366fc
	b	ret_51436408
	b	_5143672c	// 0x514363d8

_514363dc:
	cmp	r4, #15	// 0xf
	bls	_514363f4
	ldr	r2, var_51436478
	add	r1, pc, #108	// 0x6c		// !!!! PC relative 0x514363e8 + 0x6c
	add	r0, pc, #136	// 0x88		// !!!! PC relative 0x514363ec + 0x88
	bl	SimpleDebugPrint
_514363f4:
	and	r0, r4, #15	// 0xf
	ldr	r1, [r5, #32]
	bic	r1, r1, #0xf00000
	orr	r0, r1, r0, lsl #20
	str	r0, [r5, #32]	// 0x51436404

ret_51436408:
	ldmia	sp!, {r4, r5, r6, pc}
	
_5143640c:
	cmp	r4, #15	// 0xf
	bls	_51436424
	ldr	r2, var_5143648c
	add	r1, pc, #60	// 0x3c
	add	r0, pc, #88	// 0x58
	bl	SimpleDebugPrint 
_51436424:
	and	r0, r4, #15	// 0xf
	ldr	r1, [r5, #36]
	bic	r1, r1, #15	// 0xf
	orr	r0, r1, r0
	str	r0, [r5, #36]
	b	ret_51436408	// 0x51436438

var_5143643c:	.word	0xbfff4900
var_51436440:	.word	0x41e0004a
var_51436444:	.word	0xf2000080
var_51436448:	.word	0x8000c011
var_5143644c:	.word	0x43535953
var_51436450:	.word	0x00004e4f
var_51436454:	.word	0x51446d50
var_51436458:	.word	0x0000072a
var_5143645c:	.word	0x5c637273
var_51436460:	.word	0x63737973
var_51436464:	.word	0x645f6e6f
var_51436468:	.word	0x65766972
var_5143646c:	.word	0x00632e72
var_51436470:	.word	0x51443198
var_51436474:	.word	0x00000747
var_51436478:	.word	0x00000772
var_5143647c:	.word	0x69746172
var_51436480:	.word	0x3d3c206f
var_51436484:	.word	0x46783020
var_51436488:	.word	0x00000000
var_5143648c:	.word	0x0000078e

_51436490:
	cmp	r4, #15	// 0xf
	bls	_514364a8
	ldr	r2, var_514368e0
	sub	r1, pc, #72	// 0x48	// !!!! PC relative 0x5143649c - 0x48
	sub	r0, pc, #44	// 0x2c	// !!!! PC relative 0x514364a0 - 0x2c
	bl	SimpleDebugPrint
_514364a8:
	and	r0, r4, #15	// 0xf
	ldr	r1, [r5, #36]
	bic	r1, r1, #240	// 0xf0
	orr	r0, r1, r0, lsl #4
	str	r0, [r5, #36]
	b	ret_51436408

_514364c0:
	cmp	r4, #15	// 0xf
	bls	_514364d8
	ldr	r2, var_514368e4
	sub	r1, pc, #120	// 0x78	// !!!! PC relative 0x514364cc - 0x78
	sub	r0, pc, #92	// 0x5c	// !!!! PC relative 0x514364d0 - 0x5c
	bl	SimpleDebugPrint
_514364d8:
	and	r0, r4, #15	// 0xf
	ldr	r1, [r5, #36]
	bic	r1, r1, #3840	// 0xf00
	orr	r0, r1, r0, lsl #8
	str	r0, [r5, #36]
	b	ret_51436408

_514364f0:
	cmp	r4, #15	// 0xf
	bls	_51436508
	ldr	r2, var_514368e8
	sub	r1, pc, #168	// 0xa8	// !!!! PC relative 0x514364fc - 0xa8
	sub	r0, pc, #140	// 0x8c	// !!!! PC relative 0x51436500 - 0xac
	bl	SimpleDebugPrint
_51436508:
	and	r0, r4, #15	// 0xf
	ldr	r1, [r5, #40]
	bic	r1, r1, #3840	// 0xf00
	orr	r0, r1, r0, lsl #8
	str	r0, [r5, #40]
	b	ret_51436408

_51436520:
	cmp	r4, #15	// 0xf
	bls	_51436538
	ldr	r2, var_514368ec
	sub	r1, pc, #216	// 0xd8	// !!!! PC relative 0x5143652c - 0xd8
	sub	r0, pc, #188	// 0xbc	// !!!! PC relative 0x51436530 - 0xbc
	bl	SimpleDebugPrint
_51436538:
	and	r0, r4, #15	// 0xf
	ldr	r1, [r5, #40]
	bic	r1, r1, #61440	// 0xf000
	orr	r0, r1, r0, lsl #12
	str	r0, [r5, #40]
	b	ret_51436408

_51436550:
	cmp	r4, #15	// 0xf
	bls	_51436568 
	ldr	r2, var_514368f0
	sub	r1, pc, #264	// 0x108	// !!!! PC relative 0x5143655c - 0x108
	sub	r0, pc, #236	// 0xec		// !!!! PC relative 0x51436560 - 0xec
	bl	SimpleDebugPrint 
_51436568:
	and	r0, r4, #15	// 0xf
	ldr	r1, [r5, #32]
	bic	r1, r1, #0xf000000
	orr	r0, r1, r0, lsl #24
	str	r0, [r5, #32]
	b	ret_51436408 

_51436580:
	cmp	r4, #15	// 0xf
	bls	_51436598 
	mov	r2, #2000	// 0x7d0
	sub	r1, pc, #312	// 0x138	// !!!! PC relative 0x5143658c - 0x138
	sub	r0, pc, #284	// 0x11c	// !!!! PC relative 0x51436590 - 0x11c
	bl	SimpleDebugPrint
_51436598:
	and	r0, r4, #15	// 0xf
	ldr	r1, [r5, #36]
	bic	r1, r1, #0xf000
	orr	r0, r1, r0, lsl #12
	str	r0, [r5, #36]
	b	ret_51436408

_514365b0:
	cmp	r4, #15	// 0xf
	bls	_514365c8
	ldr	r2, var_514368f4
	sub	r1, pc, #360	// 0x168	// !!!! PC relative 0x514365bc - 0x168
	sub	r0, pc, #332	// 0x14c	// !!!! PC relative 0x514365c0 - 0x14c
	bl	SimpleDebugPrint
_514365c8:
	ldr	r0, [r5, #32]
	bic	r0, r0, #0xf0000000
	orr	r0, r0, r4, lsl #28
	ldmia	sp!, {r4, r5, r6, lr}
	b	sub_51433c88 

_514365dc:
	cmp	r4, #15	// 0xf
	bls	_514365f4
	ldr	r2, var_514368f8
	sub	r1, pc, #404	// 0x194	// !!!! PC relative 0x514365e8 - 0x194
	sub	r0, pc, #376	// 0x178	// !!!! PC relative 0x514365ec - 0x178
	bl	SimpleDebugPrint 
_514365f4:
	and	r0, r4, #15	// 0xf
	ldr	r1, [r5, #36]
	bic	r1, r1, #0xf0000
	orr	r0, r1, r0, lsl #16
	str	r0, [r5, #36]
	b	ret_51436408 

_5143660c:
	cmp	r4, #3	
	bls	_51436624
	ldr	r2, var_514368fc
	sub	r1, pc, #452	// 0x1c4	// !!!! PC relative 0x51436618 - 0x1c4
	add	r0, pc, #732	// 0x2dc	// !!!! PC relative 0x5143661c - 0x2dc
	bl	SimpleDebugPrint
_51436624:
	and	r0, r4, #3	
	ldr	r1, [r5, #32]
	bic	r1, r1, #0xc0000
	orr	r0, r1, r0, lsl #18
	str	r0, [r5, #32]
	b	ret_51436408

_5143663c:
	cmp	r4, #15	// 0xf
	bls	_51436654
	ldr	r2, var_51436910
	sub	r1, pc, #500	// 0x1f4	// !!!! PC relative 0x51436648 - 0x1f4
	sub	r0, pc, #472	// 0x1d8	// !!!! PC relative 0x5143664c - 0x1d8
	bl	SimpleDebugPrint
_51436654:
	and	r0, r4, #15	// 0xf
	ldr	r1, [r5, #40]
	bic	r1, r1, #0xf0000
	orr	r0, r1, r0, lsl #16
	str	r0, [r5, #40]
	b	ret_51436408 

_5143666c:
	cmp	r4, #15	// 0xf
	bls	_51436684
	mov	r2, #2080	// 0x820
	sub	r1, pc, #548	// 0x224	// !!!! PC relative 0x51436678 - 0x224
	sub	r0, pc, #520	// 0x208	// !!!! PC relative 0x5143667c - 0x208
	bl	SimpleDebugPrint
_51436684:
	and	r0, r4, #15	// 0xf
	ldr	r1, [r5, #36]
	bic	r1, r1, #0xf00000
	orr	r0, r1, r0, lsl #20
	str	r0, [r5, #36]
	b	ret_51436408

_5143669c:
	cmp	r4, #15	// 0xf
	bls	_514366b4
	ldr	r2, var_51436914
	sub	r1, pc, #596	// 0x254	// !!!! PC relative 0x514366a8 - 0x254
	sub	r0, pc, #568	// 0x238	// !!!! PC relative 0x514366ac - 0x238
	bl	SimpleDebugPrint 
_514366b4:
	and	r0, r4, #15	// 0xf
	ldr	r1, [r5, #32]
	bic	r1, r1, #15	// 0xf
	orr	r0, r1, r0
	ldmia	sp!, {r4, r5, r6, lr}
	b	sub_51433c88

_514366cc:
	cmp	r4, #1	
	bls	_514366e4
	ldr	r2, var_51436918
	sub	r1, pc, #644	// 0x284	// !!!! PC relative 0x514366d8 - 0x284
	add	r0, pc, #568	// 0x238	// !!!! PC relative 0x514366dc - 0x238
	bl	SimpleDebugPrint
_514366e4:
	and	r0, r4, #1	
	ldr	r1, [r5, #32]
	bic	r1, r1, #16	// 0x10
	orr	r0, r1, r0, lsl #4
	str	r0, [r5, #32]
	b	ret_51436408

_514366fc:
	cmp	r4, #7	
	bls	_51436714
	ldr	r2, var_5143692c
	sub	r1, pc, #692	// 0x2b4	// !!!! PC relative 0x51436708 - 0x2b4
	add	r0, pc, #540	// 0x21c	// !!!! PC relative 0x5143670c - 0x21c
	bl	SimpleDebugPrint
_51436714:
	and	r0, r4, #7
	ldr	r1, [r5, #32]
	bic	r1, r1, #0xe00
	orr	r0, r1, r0, lsl #9
	ldmia	sp!, {r4, r5, r6, lr}
	b	sub_51433c88

_5143672c:
	cmp	r4, #15	// 0xf
	bls	_51436744
	ldr	r2, var_51436940
	sub	r1, pc, #740	// 0x2e4	// !!!! PC relative 0x51436738 - 0x2e4
	sub	r0, pc, #712	// 0x2c8	// !!!! PC relative 0x5143673c - 0x2c8
	bl	SimpleDebugPrint
_51436744:
	and	r0, r4, #15	// 0xf
	ldr	r1, [r5, #32]
	bic	r1, r1, #0xf000
	orr	r0, r1, r0, lsl #12
	ldmia	sp!, {r4, r5, r6, lr}
	b	sub_51433c88 

_5143675c:
	add	r0, pc, #480	// 0x1e0
	bl	SimpleDebugPrint
	ldr	r0, var_51435d48
	ldr	r1, [r0]
	orr	r1, r1, #0x200000
	str	r1, [r0]
	b	ret_51436408 	// 0x51436774





var_514368e0:	.word	0x00000796
var_514368e4:	.word	0x0000079e
var_514368e8:	.word	0x000007ad
var_514368ec:	.word	0x000007b6
var_514368f0:	.word	0x000007c6
var_514368f4:	.word	0x000007da
var_514368f8:	.word	0x000007f1
var_514368fc:	.word	0x000007fd
var_51436900:	.word	0x69746172
var_51436904:	.word	0x3d3c206f
var_51436908:	.word	0x33783020
var_5143690c:	.word	0x00000000
var_51436910:	.word	0x00000818
var_51436914:	.word	0x0000082c
var_51436918:	.word	0x00000835
var_5143691c:	.word	0x69746172
var_51436920:	.word	0x3d3c206f
var_51436924:	.word	0x31783020
var_51436928:	.word	0x00000000
var_5143692c:	.word	0x0000083f
var_51436930:	.word	0x69746172
var_51436934:	.word	0x3d3c206f
var_51436938:	.word	0x37783020
var_5143693c:	.word	0x00000000
var_51436940:	.word	0x0000084a
var_51436944:	.word	0x5359535b
var_51436948:	.word	0x5d4e4f43
var_5143694c:	.word	0x7272455b
var_51436950:	.word	0x3353205d
var_51436954:	.word	0x31343643
var_51436958:	.word	0x79535f30
var_5143695c:	.word	0x6e6f4373
var_51436960:	.word	0x7672445f
var_51436964:	.word	0x7465535f
var_51436968:	.word	0x6b6c435f
var_5143696c:	.word	0x20766944
var_51436970:	.word	0x6c43202d
var_51436974:	.word	0x206b636f
var_51436978:	.word	0x0a204449
var_5143697c:	.word	0x00000000



sub_51436a48:	
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r4, #0	
	ldr	r5, var_51435d48
	mov	r2, r0
	ldr	r6, var_51435d80
	cmp	r2, #67	// 0x43
	ldr	r0, [r5, #4]
	addls	pc, pc, r2, lsl #2	// JUMPTABLE
_51436a68:
	b	_514370a4
	b	_514370a4
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_51436b7c
	b	_51436bf4
	b	_51436c6c
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_51436ce4
	b	_51436dac
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_51436e14
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_51436ce4
	b	_51436dac
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_51436e58
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_51436e9c
	b	_51436f14
	b	_514370b8
	b	_514370b8
	b	_51436f8c
	b	_514370b8
	b	_514370b8
	b	_51436fd4
	b	_51436fd4
	b	_51436fd4
	b	_51436fd4
	b	_514370b8
	b	_514370b8
	b	_514370b8
	b	_514370a4
	b	_51437008
	b	_5143703c
	b	_51437070
	b	_514370b8
	b	_514370b8
	b	_514370b8 	// 0x51436b78

_51436b7c:
	ldr	r2, var_51435d48
	cmp	r1, #3
	ldr	r2, [r2, #4]
	bic	r2, r2, #0x40000
	beq	_51436bcc
	cmp	r1, #7
	beq	_51436bc0
	cmp	r1, #8
	beq	_51436bb8
	cmp	r1, #9
	bne	_51436bd8
	mov	r4, #3
	orr	r0, r0, #0x40000
	str	r0, [r5, #4]
	b	_51436be0
_51436bb8:
	str	r2, [r5, #4]
	b	_51436be0
_51436bc0:
	mov	r4, #1
	str	r2, [r5, #4]
	b	_51436be0
_51436bcc:
	mov	r4, #2
	str	r2, [r5, #4]
	b	_51436be0
_51436bd8:
	add	r0, pc, #356	// 0x164	// !!!! PC relative 0x51436bd8 + 0x164
	bl	SimpleDebugPrint
_51436be0:
	ldr	r0, [r6, #28]
	bic	r0, r0, #0xc0000
	orr	r0, r0, r4, lsl #18
	str	r0, [r6, #28]
	b	_514370b8 

_51436bf4:
	ldr	r2, var_51435d48
	cmp	r1, #3
	ldr	r2, [r2, #4]
	bic	r2, r2, #0x100000
	beq	_51436c44
	cmp	r1, #7
	beq	_51436c38
	cmp	r1, #8
	beq	_51436c30
	cmp	r1, #9
	bne	_51436c50
	mov	r4, #3
	orr	r0, r0, #0x100000
	str	r0, [r5, #4]
	b	_51436c58
_51436c30:
	str	r2, [r5, #4]
	b	_51436c58
_51436c38:
	mov	r4, #1
	str	r2, [r5, #4]
	b	_51436c58
_51436c44:
	mov	r4, #2
	str	r2, [r5, #4]
	b	_51436c58
_51436c50:
	add	r0, pc, #236	// 0xec		// !!!! PC relative 0x51436c50 + 0xec
	bl	SimpleDebugPrint
_51436c58:
	ldr	r0, [r6, #28]
	bic	r0, r0, #0x300000
	orr	r0, r0, r4, lsl #20
	str	r0, [r6, #28]
	b	_514370b8

_51436c6c:
	ldr	r2, var_51435d48
	cmp	r1, #3
	ldr	r2, [r2, #4]
	bic	r2, r2, #0x400000
	beq	_51436cbc
	cmp	r1, #7
	beq	_51436cb0
	cmp	r1, #8
	beq	_51436ca8
	cmp	r1, #9
	bne	_51436cc8
	mov	r4, #3
	orr	r0, r0, #0x400000
	str	r0, [r5, #4]
	b	_51436cd0
_51436ca8:
	str	r2, [r5, #4]
	b	_51436cd0
_51436cb0:
	mov	r4, #1
	str	r2, [r5, #4]
	b	_51436cd0
_51436cbc:
	mov	r4, #2
	str	r2, [r5, #4]
	b	_51436cd0 
_51436cc8:
	add	r0, pc, #116	// 0x74		// !!!! PC relative 0x51436cc8 + 0x74
	bl	SimpleDebugPrint 
_51436cd0:
	ldr	r0, [r6, #28]
	bic	r0, r0, #0xc00000
	orr	r0, r0, r4, lsl #22
	str	r0, [r6, #28]
	b	_514370b8

_51436ce4:
	cmp	r1, #8
	beq	_51436d98
	bgt	_51436d68
	cmp	r1, #3
	beq	_51436d80
	cmp	r1, #7
	bne	_51436d90
	mov	r4, #1
	b	_51436d98	// 0x51436d04

var_51436d08:	.word	0x5359535b
var_51436d0c:	.word	0x5d4e4f43
var_51436d10:	.word	0x7272455b
var_51436d14:	.word	0x3353205d
var_51436d18:	.word	0x31343643
var_51436d1c:	.word	0x79535f30
var_51436d20:	.word	0x6e6f4373
var_51436d24:	.word	0x7672445f
var_51436d28:	.word	0x7465475f
var_51436d2c:	.word	0x6b6c435f
var_51436d30:	.word	0x20766944
var_51436d34:	.word	0x6c43202d
var_51436d38:	.word	0x206b636f
var_51436d3c:	.word	0x0a204449
var_51436d40:	.word	0x00000000
var_51436d44:	.word	0x5359535b
var_51436d48:	.word	0x5d4e4f43
var_51436d4c:	.word	0x7272455b
var_51436d50:	.word	0x5953205d
var_51436d54:	.word	0x4e4f4353
var_51436d58:	.word	0x4b4c435f
var_51436d5c:	.word	0x4352535f
var_51436d60:	.word	0x7079545f
var_51436d64:	.word	0x000a2065

_51436d68:
	cmp	r1, #11	// 0xb
	beq	_51436d88
	cmp	r1, #14	// 0xe
	bne	_51436d90
	mov	r4, #4
	b	_51436d98
_51436d80:
	mov	r4, #2
	b	_51436d98
_51436d88:
	mov	r4, #3
	b	_51436d98
_51436d90:
	sub	r0, pc, #84	// 0x54		// !!!! PC relative 0x51436d90 - 0x54
	bl	SimpleDebugPrint 
_51436d98:
	ldr	r0, [r6, #28]
	bic	r0, r0, #896	// 0x380
	orr	r0, r0, r4, lsl #7
	str	r0, [r6, #28]
	b	_514370b8

_51436dac:
	cmp	r1, #8
	beq	_51436e00
	bgt	_51436dd0
	cmp	r1, #3
	beq	_51436de8
	cmp	r1, #7
	bne	_51436df8
	mov	r4, #1
	b	_51436e00
_51436dd0:
	cmp	r1, #11	// 0xb
	beq	_51436df0
	cmp	r1, #14	// 0xe
	bne	_51436df8
	mov	r4, #4
	b	_51436e00
_51436de8:
	mov	r4, #2
	b	_51436e00
_51436df0:
	mov	r4, #3
	b	_51436e00
_51436df8:
	sub	r0, pc, #188	// 0xbc		// !!!! PC relative 0x51436df8 - 0xbc
	bl	SimpleDebugPrint
_51436e00:
	ldr	r0, [r6, #28]
	bic	r0, r0, #0x1c00
	orr	r0, r0, r4, lsl #10
	str	r0, [r6, #28]
	b	_514370b8

_51436e14:
	cmp	r1, #3
	beq	_51436e50
	cmp	r1, #7
	beq	_51436e48
	cmp	r1, #8
	beq	_51436e34
	sub	r0, pc, #240	// 0xf0		// !!!! PC relative 0x51436e2c - 0xf0
	bl	SimpleDebugPrint
_51436e34:
	ldr	r0, [r6, #28]
	bic	r0, r0, #0xc000000
	orr	r0, r0, r4, lsl #26
	str	r0, [r6, #28]
	b	_514370b8
_51436e48:
	mov	r4, #1
	b	_51436e34
_51436e50:
	mov	r4, #2
	b	_51436e34
_51436e58:
	cmp	r1, #3
	beq	_51436e94
	cmp	r1, #7
	beq	_51436e8c
	cmp	r1, #8
	beq	_51436e78
	sub	r0, pc, #308	// 0x134	// !!!! PC relative 0x51436e70 - 0x134
	bl	SimpleDebugPrint
_51436e78:
	ldr	r0, [r6, #28]
	bic	r0, r0, #0x30000000
	orr	r0, r0, r4, lsl #28
	str	r0, [r6, #28]
	b	_514370b8
_51436e8c:
	mov	r4, #1
	b	_51436e78
_51436e94:
	mov	r4, #2
	b	_51436e78
_51436e9c:
	ldr	r2, var_5143736c
	cmp	r1, #3
	ldr	r2, [r2, #4]
	bic	r2, r2, #0x4000
	beq	_51436eec
	cmp	r1, #7
	beq	_51436ee0
_51436eb8:
	cmp	r1, #8
	beq	_51436ed8
	cmp	r1, #9
	bne	_51436ef8
	mov	r4, #3
	orr	r0, r0, #0x4000
	str	r0, [r5, #4]
	b	_51436f00
_51436ed8:
	str	r2, [r5, #4]
	b	_51436f00
_51436ee0:
	mov	r4, #1
	str	r2, [r5, #4]
	b	_51436f00
_51436eec:
	mov	r4, #2
	str	r2, [r5, #4]
	b	_51436f00
_51436ef8:
	sub	r0, pc, #444	// 0x1bc	// !!!! PC relative 0x51436ef8 - 0x1bc
	bl	SimpleDebugPrint
_51436f00:
	ldr	r0, [r6, #28]
	bic	r0, r0, #0xc000
	orr	r0, r0, r4, lsl #14
	str	r0, [r6, #28]
	b	_514370b8

_51436f14:
	ldr	r2, var_5143736c
	cmp	r1, #3
	ldr	r2, [r2, #4]
	bic	r2, r2, #0x10000
	beq	_51436f64
	cmp	r1, #7
	beq	_51436f58
	cmp	r1, #8
	beq	_51436f50
	cmp	r1, #9
	bne	_51436f70
	mov	r4, #3
	orr	r0, r0, #0x10000
	str	r0, [r5, #4]
	b	_51436f78
_51436f50:
	str	r2, [r5, #4]
	b	_51436f78
_51436f58:
	mov	r4, #1
	str	r2, [r5, #4]
	b	_51436f78
_51436f64:
	mov	r4, #2
	str	r2, [r5, #4]
	b	_51436f78
_51436f70:
	sub	r0, pc, #564	// 0x234	// !!!! PC relative 0x51436f70 - 0x234
	bl	SimpleDebugPrint
_51436f78:
	ldr	r0, [r6, #28]
	bic	r0, r0, #0x30000
	orr	r0, r0, r4, lsl #16
	str	r0, [r6, #28]
	b	_514370b8

_51436f8c:
	cmp	r1, #3
	beq	_51436fa8
	cmp	r1, #9
	bne	_51436fb8
	orr	r0, r0, #0x80000000
	str	r0, [r5, #4]
	b	_51436fc0
_51436fa8:
	mov	r4, #1
	bic	r0, r0, #0x80000000
	str	r0, [r5, #4]
	b	_51436fc0
_51436fb8:
	sub	r0, pc, #636	// 0x27c	// !!!! PC relative 0x51436fb8 - 0x27c
	bl	SimpleDebugPrint 
_51436fc0:
	ldr	r0, [r6, #28]
	bic	r0, r0, #0x80000000
	orr	r0, r0, r4, lsl #31
	str	r0, [r6, #28]
	b	_514370b8

_51436fd4:
	cmp	r1, #7
	beq	_51437000 
	cmp	r1, #8
	beq	_51436fec 
	sub	r0, pc, #680	// 0x2a8	// !!!! PC relative 0x51436fe4 - 0x2a8
	bl	SimpleDebugPrint
_51436fec:
	ldr	r0, [r6, #28]
	bic	r0, r0, #0x2000
	orr	r0, r0, r4, lsl #13
	str	r0, [r6, #28]
	b	_514370b8 
_51437000:
	mov	r4, #1
	b	_51436fec 
_51437008:
	cmp	r1, #1
	beq	_51437028 
	cmp	r1, #4
	bne	_51437020 
	mov	r4, #1
	b	_51437028 
_51437020:
	sub	r0, pc, #740	// 0x2e4	// !!!! PC relative 0x51437020 - 0x2e4
	bl	SimpleDebugPrint
_51437028:
	ldr	r0, [r6, #28]
	bic	r0, r0, #1
	orr	r0, r0, r4
	str	r0, [r6, #28]
	b	_514370b8 

_5143703c:
	cmp	r1, #2
	beq	_5143705c
	cmp	r1, #5
	bne	_51437054
	mov	r4, #1
	b	_5143705c
_51437054:
	sub	r0, pc, #792	// 0x318	// !!!! PC relative 0x51437054 - 0x318
	bl	SimpleDebugPrint 
_5143705c:
	ldr	r0, [r6, #28]
	bic	r0, r0, #2
	orr	r0, r0, r4, lsl #1
	str	r0, [r6, #28]
	b	_514370b8
_51437070:
	cmp	r1, #3
	beq	_51437090
	cmp	r1, #6
	bne	_51437088
	mov	r4, #1
	b	_51437090
_51437088:
	sub	r0, pc, #844	// 0x34c	// !!!! PC relative 0x51437088 - 0x34c
	bl	SimpleDebugPrint
_51437090:
	ldr	r0, [r6, #28]
	bic	r0, r0, #4
	orr	r0, r0, r4, lsl #2
	str	r0, [r6, #28]
	b	_514370b8

_514370a4:
	add	r0, pc, #708	// 0x2c4	// !!!! PC relative 0x514370a4 + 0x2c4
	bl	SimpleDebugPrint 
	ldr	r0, [r5]
	orr	r0, r0, #0x80000
	str	r0, [r5]

_514370b8:
	ldr	r0, [r5, #4]
	cmp	r0, #0
	beq	ret_514370dc
	ldr	r0, [r6, #2052]
	orr	r0, r0, #1
	str	r0, [r6, #2052]
	ldmia	sp!, {r4, r5, r6, lr}
	add	r0, pc, #720	// 0x2d0	// !!!! PC relative 0x514370d4 + 0x2d0
	b	SimpleDebugPrint
ret_514370dc:
	ldmia	sp!, {r4, r5, r6, pc}


/*
 *  51437000
 */
var_5143736c:	.word	0x51446d48
var_51437370:	.word	0x5359535b
var_51437374:	.word	0x5d4e4f43
var_51437378:	.word	0x7272455b
var_5143737c:	.word	0x3353205d
var_51437380:	.word	0x31343643
var_51437384:	.word	0x79535f30
var_51437388:	.word	0x6e6f4373
var_5143738c:	.word	0x7672445f
var_51437390:	.word	0x7465535f
var_51437394:	.word	0x6b6c435f
var_51437398:	.word	0x20637253
var_5143739c:	.word	0x6c43202d
var_514373a0:	.word	0x206b636f
var_514373a4:	.word	0x0a204449
var_514373a8:	.word	0x00000000
var_514373ac:	.word	0x5359535b
var_514373b0:	.word	0x5d4e4f43
var_514373b4:	.word	0x4d373220
var_514373b8:	.word	0x58207a48
var_514373bc:	.word	0x6c61742d
var_514373c0:	.word	0x63736f20
var_514373c4:	.word	0x616c6c69
var_514373c8:	.word	0x20726f74
var_514373cc:	.word	0x636f6c63
var_514373d0:	.word	0x6e65206b
var_514373d4:	.word	0x656c6261
var_514373d8:	.word	0x00000a20
var_514373dc:	.word	0x7e00f000
var_514373e0:	.word	0x5359535b
var_514373e4:	.word	0x5d4e4f43
var_514373e8:	.word	0x7272455b
var_514373ec:	.word	0x3353205d
var_514373f0:	.word	0x31343643
var_514373f4:	.word	0x79535f30
var_514373f8:	.word	0x6e6f4373
var_514373fc:	.word	0x7672445f
var_51437400:	.word	0x7465475f
var_51437404:	.word	0x6b6c435f
var_51437408:	.word	0x20637253
var_5143740c:	.word	0x5953202d
var_51437410:	.word	0x4e4f4353
var_51437414:	.word	0x4d53485f
var_51437418:	.word	0x2030434d
var_5143741c:	.word	0x0000000a
var_51437420:	.word	0x5359535b
var_51437424:	.word	0x5d4e4f43
var_51437428:	.word	0x7272455b
var_5143742c:	.word	0x3353205d
var_51437430:	.word	0x31343643
var_51437434:	.word	0x79535f30
var_51437438:	.word	0x6e6f4373
var_5143743c:	.word	0x7672445f
var_51437440:	.word	0x7465475f
var_51437444:	.word	0x6b6c435f
var_51437448:	.word	0x20637253
var_5143744c:	.word	0x5953202d
var_51437450:	.word	0x4e4f4353
var_51437454:	.word	0x4d53485f
var_51437458:	.word	0x2031434d
var_5143745c:	.word	0x0000000a



SYSCON_related_a:	// sub_514376ec:
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
	bl	SimpleDebugPrint
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
	bl	SimpleDebugPrint
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
	bl	SimpleDebugPrint
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
	bl	SimpleDebugPrint
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
	bl	SimpleDebugPrint
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
	bl	SimpleDebugPrint
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
	bl	SimpleDebugPrint
_51437b70:
	ldr	r0, [r5, #40]
	and	r0, r0, #3840	// 0xf00
	add	r1, r6, r0, lsr #8
	mov	r0, r4
	bl	sub_5143fee8
	mov	r9, r0
	b	_51437f64
_51437b8c:
	add	r0, pc, #344	// 0x158	// !!!! PC relative 0x5137b8c + 0x158
	bl	SimpleDebugPrint
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
	b	_51437bdc	
	b	_51437bec	
	b	_51437bfc	
	b	_51437c0c	
	b	_51437c0c
	b	_51437c0c	// 0x51437bd8

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
	bl	SimpleDebugPrint
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
	bl	SimpleDebugPrint
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
	bl	SimpleDebugPrint
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
	bl	SimpleDebugPrint 
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
	bl	SimpleDebugPrint 
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
	bl	SimpleDebugPrint
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
	bl	SimpleDebugPrint
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
	bl	SimpleDebugPrint 
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

value_table_sub_A:	// sub_51438078:	
	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
	mov	r8, r1
	mov	r4, #0	
	ldr	r1, var_51438340	// =0x514431e8
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

value_table_sub_B:	// sub_514380f8:	
	stmdb	sp!, {r4, lr}
	mov	r2, #0
	ldr	r4, var_51438340 	// = 0x514431e8
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


value_table_sub_C:	// sub_51438160:
	str	lr, [sp, #-4]!
	mov	r1, #0	// 0x0
	ldr	lr, var_51438340	// = 0x514431e8
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
	ldr	r4, var_51438340	// = 0x514431e8
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



var_51438628:	.word	0x5164a828
var_5143862c:	.word	0x5c637273
var_51438630:	.word	0x6f697067
var_51438634:	.word	0x6972645f
var_51438638:	.word	0x5f726576
var_5143863c:	.word	0x746e6965
var_51438640:	.word	0x0000632e
var_51438644:	.word	0x4f495047
var_51438648:	.word	0x4e49455f
var_5143864c:	.word	0x554e5f54
var_51438650:	.word	0x203c204d
var_51438654:	.word	0x4f495047
var_51438658:	.word	0x58414d5f
var_5143865c:	.word	0x4e49455f
var_51438660:	.word	0x554e5f54
var_51438664:	.word	0x0000004d
var_51438668:	.word	0x00000119
var_5143866c:	.word	0x746e4975
var_51438670:	.word	0x65707954
var_51438674:	.word	0x203d3c20
var_51438678:	.word	0x68746f42
var_5143867c:	.word	0x6764455f
var_51438680:	.word	0x00000065
var_51438684:	.word	0x0000011a
var_51438688:	.word	0x6c6c6143
var_5143868c:	.word	0x6b636162
var_51438690:	.word	0x636e7546
var_51438694:	.word	0x6e6f6974
var_51438698:	.word	0x203d2120
var_5143869c:	.word	0x4c4c554e
var_514386a0:	.word	0x00000000
var_514386a4:	.word	0x514437c0
var_514386a8:	.word	0x4950475b
var_514386ac:	.word	0x455b5d4f
var_514386b0:	.word	0x205d7272
var_514386b4:	.word	0x4f495047
var_514386b8:	.word	0x4e49455f
var_514386bc:	.word	0x554e5f54
var_514386c0:	.word	0x000a204d
var_514386c4:	.word	0x514443a8
var_514386c8:	.word	0x00000156
var_514386cc:	.word	0x746c4675
var_514386d0:	.word	0x74646957
var_514386d4:	.word	0x3d3c2068
var_514386d8:	.word	0x33783020
var_514386dc:	.word	0x00000046
var_514386e0:	.word	0x4950475b
var_514386e4:	.word	0x455b5d4f
var_514386e8:	.word	0x205d7272
var_514386ec:	.word	0x544e4945
var_514386f0:	.word	0x69462030
var_514386f4:	.word	0x7265746c
var_514386f8:	.word	0x70795420
var_514386fc:	.word	0x000a2065
var_51438700:	.word	0x746c4665
var_51438704:	.word	0x65707954
var_51438708:	.word	0x203d3c20
var_5143870c:	.word	0x466e4565
var_51438710:	.word	0x0000544c
var_51438714:	.word	0x0000016e
var_51438718:	.word	0x746c4675
var_5143871c:	.word	0x74646957
var_51438720:	.word	0x3d3c2068
var_51438724:	.word	0x37783020
var_51438728:	.word	0x00000046



var_51438a08:	.word	0x4950475b
var_51438a0c:	.word	0x455b5d4f
var_51438a10:	.word	0x205d7272
var_51438a14:	.word	0x544e4945
var_51438a18:	.word	0x20397e31
var_51438a1c:	.word	0x746c6946
var_51438a20:	.word	0x54207265
var_51438a24:	.word	0x20657079
var_51438a28:	.word	0x0000000a
var_51438a2c:	.word	0x5164aa34
var_51438a30:	.word	0x4950475b
var_51438a34:	.word	0x455b5d4f
var_51438a38:	.word	0x205d7272
var_51438a3c:	.word	0x52534948
var_51438a40:	.word	0x45202d20
var_51438a44:	.word	0x5f544e49
var_51438a48:	.word	0x204d554e
var_51438a4c:	.word	0x0a206425
var_51438a50:	.word	0x00000000
var_51438a54:	.word	0x51446d54
var_51438a58:	.word	0x7f008000




sub_51438b94:
	stmdb	sp!, {r4, lr}
	ldr	r0, var_51438a54 
	mov	r1, #0
	strb	r1, [r0]
	ldr	r0, var_51438a2c
	str	r1, [r0]
	str	r1, [r0, #4]
	str	r1, [r0, #8]
	str	r1, [r0, #12]
	str	r1, [r0, #16]
	str	r1, [r0, #20]
	mov	r0, #0
	ldr	r2, var_51438628
_51438bc8:
	str	r1, [r2, r0, lsl #2]
	add	r0, r0, #1	
	and	r0, r0, #255	// 0xff
	cmp	r0, #127	// 0x7f
	bcc	_51438bc8
	sub	r1, pc, #392	// 0x188	// !!!! PC relative 0x51438bdc - 0x188
	mov	r0, #0	
	bl	sub_51401880
	mov	r0, #0	
	bl	sub_514014f4
	sub	r1, pc, #412	// 0x19c	// !!!! PC relative 0x51438bf0 - 0x19c
	mov	r0, #1	
	bl	sub_51401880
	mov	r0, #1	
	bl	sub_514014f4
	sub	r1, pc, #432	// 0x1b0	// !!!! PC relative 0x51438c04 - 0x1b0
	mov	r0, #32	// 0x20
	bl	sub_51401880
	mov	r0, #32	// 0x20
	bl	sub_514014f4
	sub	r1, pc, #452	// 0x1c4	// !!!! PC relative 0x51438c18 - 0x1c4
	mov	r0, #33	// 0x21
	bl	sub_51401880
	mov	r0, #33	// 0x21
	bl	sub_514014f4
	sub	r1, pc, #472	// 0x1d8	// !!!! PC relative 0x51438c2c - 0x1d8
	mov	r0, #53	// 0x35
	bl	sub_51401880
	ldmia	sp!, {r4, lr}
	mov	r0, #53	// 0x35
	b	sub_514014f4	// 0x51438c40



sub_51438cc8:
	mov	r1, r0
	ldr	r0, var_514390b8
	ldr	r0, [r0]
	add	r0, r0, #416	// 0x1a0	// !!!! relative addressing
	ldr	r2, [r0]
	bic	r2, r2, #3	// 0x3
	orr	r1, r2, r1
	str	r1, [r0]
	bx	lr	// 0x51438ce8

sub_51438cec:
	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
	mov	r7, r1
	mov	r4, #0
	ldr	r1, var_514390b8
	ldr	r1, [r1]
	add	r5, r1, #416	// 0x1a0	// !!!! relative addressing 
	ldr	r6, [r5]
	cmp	r0, #4
	addls	pc, pc, r0, lsl #2	// JUMPTABLE
	b	_51438d50
	b	_51438d28 
	b	_51438d30
	b	_51438d38 
	b	_51438d40
	b	_51438d48
_51438d28:
	mov	r4, #30	// 0x1e
	b	_51438d58
_51438d30:
	mov	r4, #28	// 0x1c
	b	_51438d58
_51438d38:
	mov	r4, #26	// 0x1a
	b	_51438d58
_51438d40:
	mov	r4, #24	// 0x18
	b	_51438d58
_51438d48:
	mov	r4, #22	// 0x16
	b	_51438d58
_51438d50:
	add	r0, pc, #868	// 0x364	// !!!! PC relative 0x51438d50 + 0x364
	bl	SimpleDebugPrint
_51438d58:
	mov	r0, #3
	bic	r0, r6, r0, lsl r4
	orr	r0, r0, r7, lsl r4
	str	r0, [r5]
	ldmia	sp!, {r4, r5, r6, r7, r8, pc}	// 0x51438d68



/*
 *  51439000
 */ 
 
var_514390b8:	.word	0x514431e4
var_514390bc:	.word	0x4950475b
var_514390c0:	.word	0x455b5d4f
var_514390c4:	.word	0x205d5252
var_514390c8:	.word	0x36433353
var_514390cc:	.word	0x5f303134
var_514390d0:	.word	0x4f495047
var_514390d4:	.word	0x7465535f
var_514390d8:	.word	0x76697244
var_514390dc:	.word	0x72745365
var_514390e0:	.word	0x74676e65
var_514390e4:	.word	0x20292868
var_514390e8:	.word	0x0000000a
var_514390ec:	.word	0xff000f00
var_514390f0:	.word	0x00555051
var_514390f4:	.word	0x015555d5
var_514390f8:	.word	0x000aaaaa




sub_514392d0:
	stmdb	sp!, {r4, lr}
	mov	r4, r0
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc 
	cmp	r0, #1	
	beq	_51439308
	ldr	r0, var_51439370
	ldr	r1, var_51439458
	str	r1, [r0, #16]
	ldr	r1, [r0, #20]
	add	r1, r1, #1	
	str	r1, [r0, #20]
	mvn	r0, #0	
ret_51439304:
	ldmia	sp!, {r4, pc}
_51439308:
	cmp	r4, #0	
	bne	_51439318 
	mov	r0, #32	
	b	_5143934c 
_51439318:
	cmp	r4, #1	
	bne	_51439328 
	mov	r0, #36	
	b	_5143934c 
_51439328:
	cmp	r4, #2	
	bne	_51439338 
	mov	r0, #40	
	b	_5143934c 
_51439338:
	cmp	r4, #3	
	bne	_51439348 
	mov	r0, #44	
	b	_5143934c 
_51439348:
	mov	r0, #48	
_5143934c:
	add	r0, r0, #0x70000000
	add	r0, r0, #0x7100000
	ldr	r0, [r0]
	tst	r0, #1	
	beq	_51439368 
	mov	r0, #1	
	b	ret_51439304 
_51439368:
	mov	r0, #0
	b	ret_51439304 

var_51439370:	.word	0x51446d5c
var_51439374:	.word	0x5164accc
var_51439378:	.word	0x54534f5b
var_5143937c:	.word	0x3a4b4349
var_51439380:	.word	0x205d6425
var_51439384:	.word	0x646f4d5b
var_51439388:	.word	0x49203a65
var_5143938c:	.word	0x75535f6e
var_51439390:	.word	0x6e657073
var_51439394:	.word	0x205d2064
var_51439398:	.word	0x756f435b
var_5143939c:	.word	0x3a20746e
var_514393a0:	.word	0x5d642520
var_514393a4:	.word	0x00000020
var_514393a8:	.word	0x54534f5b
var_514393ac:	.word	0x3a4b4349
var_514393b0:	.word	0x205d6425
var_514393b4:	.word	0x646f4d5b
var_514393b8:	.word	0x49203a65
var_514393bc:	.word	0x61575f6e
var_514393c0:	.word	0x7075656b
var_514393c4:	.word	0x205d2020
var_514393c8:	.word	0x756f435b
var_514393cc:	.word	0x3a20746e
var_514393d0:	.word	0x5d642520
var_514393d4:	.word	0x00000020
var_514393d8:	.word	0x01312d00
var_514393dc:	.word	0x77100000
var_514393e0:	.word	0x5f6e493c
var_514393e4:	.word	0x6e795356
var_514393e8:	.word	0x3d3d3e63
var_514393ec:	.word	0x3d3d3d3d
var_514393f0:	.word	0x3d3d3d3d
var_514393f4:	.word	0x3d3d3d3d
var_514393f8:	.word	0x3d3d3d3d
var_514393fc:	.word	0x3d3d3d3d
var_51439400:	.word	0x69563d3d
var_51439404:	.word	0x6e6f6364
var_51439408:	.word	0x29642528
var_5143940c:	.word	0x203a2020
var_51439410:	.word	0x78257830
var_51439414:	.word	0x000a3d3d
var_51439418:	.word	0x6e493c0a
var_5143941c:	.word	0x4557475f
var_51439420:	.word	0x64705553
var_51439424:	.word	0x3e657461
var_51439428:	.word	0x3d3d3d3d
var_5143942c:	.word	0x3d3d3d3d
var_51439430:	.word	0x3d3d3d3d
var_51439434:	.word	0x3d3d3d3d
var_51439438:	.word	0x3d3d3d3d
var_5143943c:	.word	0x563d3d3d
var_51439440:	.word	0x6f636469
var_51439444:	.word	0x6425286e
var_51439448:	.word	0x203a2029
var_5143944c:	.word	0x78257830
var_51439450:	.word	0x000a3d3d
var_51439454:	.word	0x5164aa4c
var_51439458:	.word	0x00010021

sub_5143945c:
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	mov	r4, r0
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc 
	cmp	r0, #1
	beq	_514394a0 
	ldr	r0, var_51439370
	ldr	r1, var_5143a2b0
	str	r1, [r0, #16]
	ldr	r1, [r0, #20]
	add	r1, r1, #1
	str	r1, [r0, #20]
	ldr	r1, [r0, #24]
	add	r1, r1, #1
	str	r1, [r0, #24]
	mvn	r0, #0	
ret_5143949c:
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
_514394a0:
	cmp	r4, #0
	beq	_514394b8
	cmp	r4, #1
	beq	_514394b8
	cmp	r4, #2
	beq	_514394b8
_514394b8:
	cmp	r4, #1
	beq	_514394d0
	cmp	r4, #2
	beq	_514394d0
	cmp	r4, #3
	beq	_514394d0
_514394d0:
	cmp	r4, #0
	beq	_514394e8
	cmp	r4, #1
	beq	_514394e8
	cmp	r4, #2
	beq	_514394e8
_514394e8:
	cmp	r4, #0
	beq	_51439500
	cmp	r4, #1
	beq	_51439500
	cmp	r4, #2
	beq	_51439500
_51439500:
	cmp	r4, #0
	beq	_51439518
	cmp	r4, #1
	beq	_51439518
	cmp	r4, #2
	beq	_51439518
_51439518:
	cmp	r4, #0
	beq	_51439530
	cmp	r4, #1
	beq	_51439530
	cmp	r4, #2
	beq	_51439530 
_51439530:
	cmp	r4, #0	
	beq	_51439548 
	cmp	r4, #1	
	beq	_51439548 
	cmp	r4, #2	
	beq	_51439548 
_51439548:
	mov	r0, #11	// 0xb
	ldr	r9, var_5143a2b8 
	smulbb	r7, r4, r0
	ldr	lr, var_5143a2b4
	ldr	r6, var_514393dc 
	cmp	r4, #0
	mov	r8, #0	
	add	r5, r9, #44	// 0x2c
	add	r0, r9, r7, lsl #2
	bne	_51439648 
	ldrb	r1, [lr, #460]
	cmp	r1, #0
	bne	_514395a4
	ldr	r1, [lr, #412]
	ldr	r2, [lr, #416]
	orr	r1, r1, r2
	ldr	r2, [lr, #424]
	orr	r1, r1, r2
	ldr	r2, [lr, #420]
	orr	r1, r1, r2
	ldr	r2, [lr, #396]
	orr	r1, r1, r2
	b	_51439620
_514395a4:
	ldrb	r1, [lr, #463]
	mov	r3, lr
	cmp	r1, #0	
	beq	_514395bc 
	mvn	r0, #2
	b	ret_5143949c
_514395bc:
	ldrb	r1, [r3, #466]
	cmp	r1, #1
	bne	_514395f8
	ldr	r1, [r3, #412]
	ldr	r2, [r3, #416]
	orr	r1, r1, r2
	ldr	r2, [r3, #424]
	orr	r1, r1, r2
	ldr	r2, [r3, #420]
	orr	r1, r1, r2
	ldr	r2, [r3, #396]
	orr	r1, r1, r2
	orr	r1, r1, #0x400000
	orr	r1, r1, #0x2000
	b	_51439620
_514395f8:
	ldr	r1, [r3, #412]
	ldr	r2, [r3, #416]
	orr	r1, r1, r2
	ldr	r2, [r3, #424]
	orr	r1, r1, r2
	ldr	r2, [r3, #420]
	orr	r1, r1, r2
	ldr	r2, [r3, #396]
	orr	r1, r1, r2
	orr	r1, r1, #0x400000
_51439620:
	ldr	r2, [lr, #40]
	str	r2, [r9, #4]
	ldr	r2, [lr, #60]
	str	r2, [r9, #28]
	ldr	r2, [lr, #300]
	ldr	r3, [lr, #320]
	mul	r2, r3, r2
	bic	r2, r2, #0xff000000
	str	r2, [r9, #12]
	b	_5143989c
_51439648:
	cmp	r4, #1
	bne	_51439768
	ldrb	r1, [lr, #461]
	cmp	r1, #0
	bne	_51439684
	ldr	r1, [lr, #412]
	ldr	r2, [lr, #416]
	orr	r1, r1, r2
	ldr	r2, [lr, #424]
	orr	r1, r1, r2
	ldr	r2, [lr, #420]
	orr	r1, r1, r2
	ldr	r2, [lr, #396]
	orr	r1, r1, r2
	b	_51439738
_51439684:
	ldrb	r1, [lr, #464]
	cmp	r1, #0	
	beq	_514396a0
	cmp	r1, #1
	beq	_514396a0
	mvn	r0, #2
	b	ret_5143949c
_514396a0:
	ldrb	r2, [lr, #467]
	mov	r3, lr	
	cmp	r2, #1
	bne	_514396f8 
	cmp	r1, #1
	bne	_514396c0
	mov	r1, #0x800000
	b	_514396c4
_514396c0:
	mov	r1, #0	
_514396c4:
	ldr	r2, [r3, #412]
	orr	r1, r1, r2
	ldr	r2, [r3, #416]
	orr	r1, r1, r2
	ldr	r2, [r3, #424]
	orr	r1, r1, r2
	ldr	r2, [r3, #420]
	orr	r1, r1, r2
	ldr	r2, [r3, #396]
	orr	r1, r1, r2
	orr	r1, r1, #0x400000
	orr	r1, r1, #0x2000
	b	_51439738 
_514396f8:
	cmp	r1, #1	
	bne	_51439708
	mov	r1, #0x800000
	b	_5143970c
_51439708:
	mov	r1, #0
_5143970c:
	ldr	r2, [r3, #412]
	orr	r1, r1, r2
	ldr	r2, [r3, #416]
	orr	r1, r1, r2
	ldr	r2, [r3, #424]
	orr	r1, r1, r2
	ldr	r2, [r3, #420]
	orr	r1, r1, r2
	ldr	r2, [r3, #396]
	orr	r1, r1, r2
	orr	r1, r1, #0x400000
_51439738:
	ldr	r3, var_5143a2b8
	ldr	r2, [lr, #44]
	str	r2, [r3, #48]
	ldr	r2, [lr, #64]
	str	r2, [r5, #28]
	ldr	r2, [lr, #304]
	ldr	r3, [lr, #324]
	mul	r2, r3, r2
	bic	r2, r2, #0xff000000
	str	r2, [r5, #12]
	str	r2, [r6, #92]
	b	_51439894
_51439768:
	cmp	r4, #2
	bne	_51439870
	ldrb	r1, [lr, #462]
	cmp	r1, #0	
	bne	_514397a4
	ldr	r1, [lr, #412]
	ldr	r2, [lr, #416]
	orr	r1, r1, r2
	ldr	r2, [lr, #424]
	orr	r1, r1, r2
	ldr	r2, [lr, #420]
	orr	r1, r1, r2
	ldr	r2, [lr, #396]
	orr	r1, r1, r2
	b	_51439858
_514397a4:
	ldrb	r1, [lr, #465]
	cmp	r1, #0	
	beq	_514397c0
	cmp	r1, #1
	beq	_514397c0
	mvn	r0, #2
	b	ret_5143949c
_514397c0:
	ldrb	r2, [lr, #468]
	mov	r3, lr
	cmp	r2, #1
	bne	_51439818
	cmp	r1, #1	
	bne	_514397e0
	mov	r1, #0x800000
	b	_514397e4 
_514397e0:
	mov	r1, #0
_514397e4:
	ldr	r2, [r3, #412]
	orr	r1, r1, r2
	ldr	r2, [r3, #416]
	orr	r1, r1, r2
	ldr	r2, [r3, #424]
	orr	r1, r1, r2
	ldr	r2, [r3, #420]
	orr	r1, r1, r2
	ldr	r2, [r3, #396]
	orr	r1, r1, r2
	orr	r1, r1, #0x400000
	orr	r1, r1, #0x2000
	b	_51439858
_51439818:
	cmp	r1, #1
	bne	_51439828
	mov	r1, #0x800000
	b	_5143982c
_51439828:
	mov	r1, #0
_5143982c:
	ldr	r2, [r3, #412]
	orr	r1, r1, r2
	ldr	r2, [r3, #416]
	orr	r1, r1, r2
	ldr	r2, [r3, #424]
	orr	r1, r1, r2
	ldr	r2, [r3, #420]
	orr	r1, r1, r2
	ldr	r2, [r3, #396]
	orr	r1, r1, r2
	orr	r1, r1, #0x400000
_51439858:
	ldr	r2, [lr, #308]
	ldr	r3, [lr, #328]
	mul	r2, r3, r2
	bic	r2, r2, #0xff000000
	str	r2, [r6, #108]
	b	_51439894
_51439870:
	ldr	r1, [lr, #412]
	ldr	r2, [lr, #416]
	orr	r1, r1, r2
	ldr	r2, [lr, #424]
	orr	r1, r1, r2
	ldr	r2, [lr, #420]
	orr	r1, r1, r2
	ldr	r2, [lr, #396]
	orr	r1, r1, r2
_51439894:
	mvn	r2, #0xff000000
	str	r2, [r0, #16]
_5143989c:
	str	r1, [r0, #20]
	add	r1, lr, r4, lsl #2
	ldr	r2, [r1, #220]
	str	r2, [r0, #24]
	ldr	r2, [r1, #240]
	str	r2, [r0, #28]
	ldr	r3, [r1, #360]
	ldr	r2, [r1, #340]
	orr	r2, r2, r3, lsl #13
	str	r2, [r0, #32]
	ldr	r2, [lr, #388]
	ldr	r3, [r1, #300]
	add	r3, r2, r3
	sub	r3, r3, #1	
	ldr	ip, [lr, #392]
	ldr	r1, [r1, #320]
	add	r1, ip, r1
	sub	r1, r1, #1	
	ldr	lr, [lr, #440]
	cmp	lr, #1	
	bne	_51439944 
	tst	r2, #1	
	beq	_51439900 
	mvn	r0, #2	
	b	ret_5143949c
_51439900:
	tst	r1, #1	
	bne	_51439910 
	mvn	r0, #2	
	b	ret_5143949c
_51439910:
	mov	ip, ip, lsl #21
	mov	r2, r2, lsl #21
	mov	ip, ip, lsr #21
	mov	r2, r2, lsr #10
	orr	r2, r2, ip, lsr #1
	str	r2, [r0, #36]
	mov	r1, r1, lsl #21
	mov	r2, r3, lsl #21
	mov	r1, r1, lsr #21
	mov	r2, r2, lsr #10
	orr	r1, r2, r1, lsr #1
	str	r1, [r0, #40]
	b	_51439974
_51439944:
	mov	r2, r2, lsl #21
	mov	ip, ip, lsl #21
	mov	r2, r2, lsr #21
	mov	ip, ip, lsr #21
	orr	r2, ip, r2, lsl #11
	str	r2, [r0, #36]
	mov	r2, r3, lsl #21
	mov	r1, r1, lsl #21
	mov	r2, r2, lsr #21
	mov	r1, r1, lsr #21
	orr	r1, r1, r2, lsl #11
	str	r1, [r0, #40]
_51439974:
	mov	r0, #1	
	strb	r0, [r9, r7, lsl #2]
	cmp	r4, #4	
	beq	_51439994
	mov	r0, r4
	bl	sub_514392d0 
	cmp	r0, #0	
	bne	_51439b08 
_51439994:
	cmp	r4, #0	
	bne	_514399dc 
	ldr	r0, [r9, #12]
	str	r0, [r6, #72]
	ldr	r0, [r9, #20]
	bic	r0, r0, #0x400000
	str	r0, [r6, #32]
	ldr	r0, [r9, #24]
	str	r0, [r6, #160]
	ldr	r0, [r9, #28]
	str	r0, [r6, #208]
	ldr	r0, [r9, #32]
	str	r0, [r6, #256]
	ldr	r0, [r9, #36]
	str	r0, [r6, #64]
	ldr	r0, [r9, #40]
	str	r0, [r6, #68]
	b	_51439b04
_514399dc:
	cmp	r4, #1
	bne	_51439a28
	ldr	r0, var_5143a2b8 
	ldr	r0, [r0, #56]
	str	r0, [r6, #92]
	ldr	r0, [r5, #20]
	bic	r0, r0, #0x400000
	str	r0, [r6, #36]
	ldr	r0, [r5, #24]
	str	r0, [r6, #168]
	ldr	r0, [r5, #28]
	str	r0, [r6, #216]
	ldr	r0, [r5, #32]
	str	r0, [r6, #256]
	ldr	r0, [r5, #36]
	str	r0, [r6, #80]
	ldr	r0, [r5, #40]
	str	r0, [r6, #84]
	b	_51439b04
_51439a28:
	cmp	r4, #2	
	bne	_51439a78
	ldr	r1, var_5143a2b8
	add	r0, r1, #88	// 0x58
	ldr	r1, [r1, #104]
	str	r1, [r6, #104]
	ldr	r1, [r0, #20]
	bic	r1, r1, #0x400000
	str	r1, [r6, #40]
	ldr	r1, [r0, #24]
	str	r1, [r6, #176]
	ldr	r1, [r0, #28]
	str	r1, [r6, #224]
	ldr	r1, [r0, #32]
	str	r1, [r6, #264]
	ldr	r1, [r0, #36]
	str	r1, [r6, #96]
	ldr	r0, [r0, #40]
	str	r0, [r6, #100]
	b	_51439b04
_51439a78:
	cmp	r4, #3	
	bne	_51439ac4
	ldr	r1, var_5143a2b8
	add	r0, r1, #132	// 0x84	// !!!! PC relative 0x51439a84 + 0x84
	ldr	r1, [r1, #148]
	str	r1, [r6, #120]
	ldr	r1, [r0, #20]
	str	r1, [r6, #44]
	ldr	r1, [r0, #24]
	str	r1, [r6, #184]
	ldr	r1, [r0, #28]
	str	r1, [r6, #232]
	ldr	r1, [r0, #32]
	str	r1, [r6, #268]
	ldr	r1, [r0, #36]
	str	r1, [r6, #112]
	ldr	r0, [r0, #40]
	str	r0, [r6, #116]
	b	_51439b04
_51439ac4:
	cmp	r4, #4	
	bne	_51439b04
	ldr	r0, [r9, #192]
	str	r0, [r6, #136]
	ldr	r0, [r9, #196]
	str	r0, [r6, #48]
	ldr	r0, [r9, #200]
	str	r0, [r6, #192]
	ldr	r0, [r9, #204]
	str	r0, [r6, #240]
	ldr	r0, [r9, #208]
	str	r0, [r6, #272]
	ldr	r0, [r9, #212]
	str	r0, [r6, #128]
	ldr	r0, [r9, #216]
	str	r0, [r6, #132]
_51439b04:
	strb	r8, [r9, r7, lsl #2]
_51439b08:
	cmp	r4, #0
	bne	_51439b4c
	ldr	r0, [r9, #12]
	str	r0, [r6, #72]
	ldr	r0, [r9, #20]
	str	r0, [r6, #32]
	ldr	r0, [r9, #24]
	str	r0, [r6, #160]
	ldr	r0, [r9, #28]
	str	r0, [r6, #208]
	ldr	r0, [r9, #32]
	str	r0, [r6, #256]
	ldr	r0, [r9, #36]
	str	r0, [r6, #64]
	ldr	r0, [r9, #40]
	str	r0, [r6, #68]
	strb	r8, [r9]
_51439b4c:
	mov	r0, #0	
	b	ret_5143949c 	// 0x51439b50

sub_51439b54:
	stmdb	sp!, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #20	// 0x14
	mov	r6, r2
	add	r8, sp, #88	// 0x58
	ldmia	r8, {r5, r7, r8}
	ldr	fp, [sp, #76]
	ldr	r4, [sp, #100]
	ldr	r2, [sp, #72]
	ldr	sl, [sp, #104]
	mov	r1, #0
	str	r1, [sp, #4]
	str	r1, [sp]
	ldr	r9, var_5143a2b4
	ldr	r1, [r9, #380]
	cmp	r1, r3
	bcc	_51439ba0
	ldr	r1, [r9, #384]
	cmp	r1, r2
	bcs	_51439bac
_51439ba0:
	mvn	r0, #4
_51439ba4:
	add	sp, sp, #36	// 0x24
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
_51439bac:
	ldr	lr, [sp, #24]
	cmp	r3, lr
	bhi	_51439bc0
	cmp	r2, r6
	bls	_51439bc8
_51439bc0:
	mvn	r0, #4
	b	_51439ba4
_51439bc8:
	ldr	lr, var_5143a2b4
	cmp	r8, #1
	mov	r1, #1
	mov	ip, #0
	add	lr, lr, r5
	bne	_51439c14
	cmp	r4, #1	
	beq	_51439bf8
	cmp	r4, #0	
	beq	_51439bf8
	mvn	r0, #2
	b	_51439ba4
_51439bf8:
	strb	r1, [lr, #460]
	strb	r4, [lr, #463]
	strb	sl, [lr, #466]
	cmp	r0, #9
	beq	_51439c18
	mov	r0, #9
	b	_51439c18
_51439c14:
	strb	ip, [lr, #460]
_51439c18:
	ldr	lr, [sp, #24]
	add	r4, r9, r5, lsl #2
	str	lr, [r4, #260]
	str	r6, [r4, #280]
	str	r3, [r4, #300]
	str	r2, [r4, #320]
	str	fp, [r9, #388]
	ldr	r2, [sp, #80]
	str	r2, [r9, #392]
	ldr	r2, [r4, #260]
	ldr	r3, [r4, #300]
	sub	r2, r2, r3
	str	ip, [r9, #412]
	str	ip, [r9, #416]
	str	ip, [r9, #420]
	str	ip, [r9, #424]
	cmp	r0, #0
	mov	lr, #1024	// 0x400
	mov	r3, #4	
	bne	_51439c8c
	str	r1, [r9, #404]
	str	r3, [r9, #408]
	tst	r2, #31	// 0x1f
	beq	_51439c80
	mvn	r0, #4	
	b	_51439ba4
_51439c80:
	str	ip, [r9, #396]
	str	lr, [r9, #420]
	b	_51439e2c
_51439c8c:
	cmp	r0, #1
	bne	_51439cb8
	str	r1, [r9, #404]
	str	r3, [r9, #408]
	tst	r2, #15	// 0xf
	beq	_51439cac
	mvn	r0, #4	
	b	_51439ba4
_51439cac:
	str	r3, [r9, #396]
	str	lr, [r9, #420]
	b	_51439e2c
_51439cb8:
	cmp	r0, #2
	mov	ip, #2
	bne	_51439cf4
	cmp	r5, #4
	beq	_51439cf4
	str	r1, [r9, #404]
	str	ip, [r9, #408]
	tst	r2, #7
	beq	_51439ce4
	mvn	r0, #4
	b	_51439ba4
_51439ce4:
	mov	r0, #8
	str	r0, [r9, #396]
	str	lr, [r9, #420]
	b	_51439e2c
_51439cf4:
	cmp	r0, #3
	mov	lr, #0x20000
	bne	_51439d38
	cmp	r5, #0
	beq	_51439d10
	cmp	r5, #1
	bne	_51439d38 
_51439d10:
	str	r1, [r9, #404]
	str	r1, [r9, #408]
	tst	r2, #3
	beq	_51439d28
	mvn	r0, #4
	b	_51439ba4
_51439d28:
	mov	r0, #12
	str	r0, [r9, #396]
	str	lr, [r9, #412]
	b	_51439e2c 
_51439d38:
	cmp	r0, #4
	bne	_51439d78
	cmp	r5, #1
	beq	_51439d50
	cmp	r5, #2	
	bne	_51439d78
_51439d50:
	str	r1, [r9, #404]
	str	r1, [r9, #408]
	tst	r2, #3	
	beq	_51439d68
	mvn	r0, #4	
	b	_51439ba4
_51439d68:
	mov	r0, #16	// 0x10
	str	r0, [r9, #396]
	str	lr, [r9, #412]
	b	_51439e2c
_51439d78:
	cmp	r0, #6	
	mov	lr, #0x10000
	bne	_51439dac
	str	ip, [r9, #404]
	str	r1, [r9, #408]
	tst	r2, #1	
	beq	_51439d9c
	mvn	r0, #4
	b	_51439ba4
_51439d9c:
	mov	r0, #20
	str	r0, [r9, #396]
	str	lr, [r9, #416]
	b	_51439e2c
_51439dac:
	cmp	r0, #7	
	bne	_51439ddc
	str	ip, [r9, #404]
	str	r1, [r9, #408]
	tst	r2, #1
	beq	_51439dcc
	mvn	r0, #4
	b	_51439ba4
_51439dcc:
	mov	r0, #24	// 0x18
	str	r0, [r9, #396]
	str	lr, [r9, #416]
	b	_51439e2c
_51439ddc:
	cmp	r0, #8	
	bne	_51439df8
	str	r3, [r9, #404]
	str	r1, [r9, #408]
	mov	r0, #32	// 0x20
	str	r0, [r9, #396]
	b	_51439e2c 
_51439df8:
	cmp	r0, #9
	bne	_51439e14 
	str	r3, [r9, #404]
	str	r1, [r9, #408]
	mov	r0, #44	// 0x2c
	str	r0, [r9, #396]
	b	_51439e2c
_51439e14:
	cmp	r0, #11	// 0xb
	bne	_51439e8c
	str	r3, [r9, #404]
	str	r1, [r9, #408]
	mov	r0, #48	// 0x30
	str	r0, [r9, #396]
_51439e2c:
	ldr	r0, [r4, #300]
	ldr	r8, [r4, #260]
	mov	fp, r0
	cmp	r8, r0
	bcc	_51439e94
	ldr	r0, [r9, #404]
	ldr	r1, [r9, #408]
	mov	sl, r9
	mul	r0, r2, r0
	bl	sub_5143fee8 
	mov	r9, r0
	str	r0, [r4, #360]
	ldr	r1, [sl, #404]
	mul	r0, r1, fp
	ldr	r1, [sl, #408]
	bl	sub_5143fee8 
	str	r0, [r4, #340]
	str	r0, [sp, #16]
	cmp	r9, #0	
	beq	_51439e9c 
	tst	r9, #3
	beq	_51439e9c
	mvn	r0, #2	
	b	_51439ba4
_51439e8c:
	mvn	r0, #3	
	b	_51439ba4
_51439e94:
	mvn	r0, #3
	b	_51439ba4
_51439e9c:
	ldr	r0, [sp, #84]
	mov	fp, sl
	str	r0, [sl, r5, lsl #2]
	str	r0, [sp, #12]
	ldr	r1, [sp]
	ldr	r0, [sp, #4]
	mla	r0, r1, r8, r0
	ldr	r1, [fp, #404]
	mul	r0, r1, r0
	ldr	r1, [fp, #408]
	bl	sub_5143fee8
	ldr	r1, [sp, #84]
	add	sl, r0, r1
	str	sl, [r4, #220]
	ldr	r0, [sp, #16]
	add	r9, r9, r0
	mla	r0, r6, r9, sl
	str	r0, [r4, #240]
	cmp	r7, #1
	bne	_51439f34
	ldr	r0, [r4, #280]
	ldr	r1, [fp, #408]
	mul	r8, r0, r8
	ldr	r0, [fp, #404]
	mul	r0, r8, r0
	bl	sub_5143fee8
	ldr	r1, [sp, #12]
	add	r0, r0, r1
	str	r0, [r4, #20]
	ldr	r0, [fp, #404]
	ldr	r1, [fp, #408]
	mul	r0, r8, r0
	bl	sub_5143fee8
	add	r0, r0, sl
	str	r0, [r4, #40]
	mla	r0, r6, r9, r0
	str	r0, [r4, #60]
	b	_51439fd4
_51439f34:
	cmp	r7, #0	
	bne	_51439f48
	str	sl, [r4, #40]
	str	r0, [r4, #60]
	b	_51439fd4
_51439f48:
	cmp	r7, #2
	bne	_51439ff8
	ldr	r0, [r4, #280]
	ldr	r1, [fp, #408]
	mul	r8, r0, r8
	ldr	r0, [fp, #404]
	mul	r0, r8, r0
	bl	sub_5143fee8
	ldr	r1, [sp, #12]
	add	r1, r0, r1
	str	r1, [r4, #20]
	str	r1, [sp, #8]
	ldr	r0, [fp, #404]
	ldr	r1, [fp, #408]
	mul	r0, r8, r0
	bl	sub_5143fee8
	add	sl, r0, sl
	str	sl, [r4, #40]
	mla	r0, r6, r9, sl
	str	r0, [r4, #60]
	ldr	r0, [fp, #404]
	ldr	r1, [fp, #408]
	mul	r0, r8, r0
	bl	sub_5143fee8
	ldr	r1, [sp, #8]
	add	r0, r0, r1
	str	r0, [r4, #80]
	ldr	r0, [fp, #404]
	ldr	r1, [fp, #408]
	mul	r0, r8, r0
	bl	sub_5143fee8
	add	r0, r0, sl
	str	r0, [r4, #100]
	mla	r0, r6, r9, r0
	str	r0, [r4, #120]
_51439fd4:
	ldr	lr, [sp, #24]
	str	lr, [r4, #260]
	str	r6, [r4, #280]
	add	r0, r7, #1
	str	r0, [r4, #200]
	mov	r0, r5
	bl	sub_5143945c
	mov	r0, #0
	b	_51439ba4
_51439ff8:
	mvn	r0, #3
	b	_51439ba4	// 0x51439ffc



/*
 *  5143a000
 */

var_5143a2b0:	.word	0x00010020
var_5143a2b4:	.word	0x5164eb4c
var_5143a2b8:	.word	0x5164aad8
var_5143a2bc:	.word	0x00010005
var_5143a2c0:	.word	0x76300000
var_5143a2c4:	.word	0x7e00f000
var_5143a2c8:	.word	0x00020002



sub_5143a4f0:
	stmdb	sp!, {r4, lr}
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc
	cmp	r0, #1	
	beq	_5143a520
	ldr	r0, var_5143a83c
	ldr	r1, var_5143a84c
	str	r1, [r0, #16]
	ldr	r1, [r0, #20]
	add	r1, r1, #1	
	str	r1, [r0, #20]
ret_5143a51c:
	ldmia	sp!, {r4, pc}
_5143a520:
	ldr	r1, var_5143a850
	ldr	r0, [r1, #304]
	orr	r0, r0, #1	
	str	r0, [r1, #304]
	b	ret_5143a51c 

sub_5143a534:
	stmdb	sp!, {r4, lr}
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc 
	cmp	r0, #1	
	beq	_5143a568
	ldr	r0, var_5143a83c
	ldr	r1, var_5143a854
	str	r1, [r0, #16]
	ldr	r1, [r0, #20]
	add	r1, r1, #1	
	str	r1, [r0, #20]
	mvn	r0, #0	
ret_5143a564:
	ldmia	sp!, {r4, pc}
_5143a568:
	ldr	r0, var_5143a858
	ldr	r4, [r0, #16]
	add	r0, r0, #0x5f00000
	ldr	r0, [r0]
	tst	r0, #1	
	bne	_5143a5b4 
	bl	sub_5143a4f0 
	movs	r0, r4, lsl #1
	bmi	_5143a594
	mov	r0, #30	// 0x1e
	bl	sub_514014f4
_5143a594:
	add	r0, pc, #704	// 0x2c0	// !!!! PC relative 0x5143a594 + 0x2c0
	bl	SimpleDebugPrint
	add	r0, pc, #732	// 0x2dc	// !!!! PC relative 0x5143a59c + 0x2dc
	bl	SimpleDebugPrint
	add	r0, pc, #688	// 0x2b0	// !!!! PC relative 0x5143a5a4 + 0x2b0
	bl	SimpleDebugPrint 
	mov	r0, #0	
	b	ret_5143a564 
_5143a5b4:
	mov	r0, #1	
	b	ret_5143a564 	// 0x5143a5b8



sub_5143a718:
	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
	mov	r4, r2
	mov	r5, r3
	ldr	r6, [sp, #24]
	mov	r8, r1
	mov	r7, r0
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc
	cmp	r0, #1
	beq	_5143a75c
	ldr	r0, var_5143a83c
	ldr	r1, var_5143a8b8
	str	r1, [r0, #16]
	ldr	r1, [r0, #20]
	add	r1, r1, #1	
	str	r1, [r0, #20]
ret_5143a758:
	ldmia	sp!, {r4, r5, r6, r7, r8, pc}
_5143a75c:
	ldr	r1, var_5143a850
	ldr	r0, [r1, #304]
	cmp	r7, #0
	bne	_5143a80c
	bic	r0, r0, #3840	// 0xf00
	bic	r0, r0, #254	// 0xfe
	cmp	r4, #0	
	beq	_5143a7b8
	cmp	r4, #1	
	bne	_5143a78c
	orr	r0, r0, #4	
	b	_5143a7b8
_5143a78c:
	cmp	r4, #2	
	bne	_5143a79c
	orr	r0, r0, #8	
	b	_5143a7b8
_5143a79c:
	cmp	r4, #3	
	bne	_5143a7ac
	orr	r0, r0, #12	// 0xc
	b	_5143a7b8
_5143a7ac:
	cmp	r4, #4
	bne	_5143a7b8
	orr	r0, r0, #0x10
_5143a7b8:
	cmp	r5, #0
	bne	_5143a7c8
	orr	r0, r0, #0x20
	b	_5143a804
_5143a7c8:
	cmp	r5, #1	
	bne	_5143a7d8
	orr	r0, r0, #0x40
	b	_5143a804
_5143a7d8:
	cmp	r5, #2	
	bne	_5143a7e8
	orr	r0, r0, #0x200
	b	_5143a804
_5143a7e8:
	cmp	r5, #3	
	bne	_5143a7f8
	orr	r0, r0, #0x400
	b	_5143a804
_5143a7f8:
	cmp	r5, #4	
	bne	_5143a804
	orr	r0, r0, #0x800
_5143a804:
	orr	r0, r0, #0x2
	b	_5143a91c
_5143a80c:
	cmp	r7, #1	
	bne	_5143a8f0
	bic	r0, r0, #0x1f000
	cmp	r6, #0	
	beq	_5143a8d8
	cmp	r6, #1	
	bne	_5143a8bc
	orr	r0, r0, #0x8000
	b	_5143a8d8	// 0x5143a82c

var_5143a830:	.word	0x00010003
var_5143a834:	.word	0x00010004
var_5143a838:	.word	0x00010006
var_5143a83c:	.word	0x51446d5c
var_5143a840:	.word	0x00010007
var_5143a844:	.word	0x00010008
var_5143a848:	.word	0x00010009
var_5143a84c:	.word	0x0001003e
var_5143a850:	.word	0x77100000
var_5143a854:	.word	0x00010054
var_5143a858:	.word	0x71200000
var_5143a85c:	.word	0x3d3d3d3d
var_5143a860:	.word	0x3d3d3d3d
var_5143a864:	.word	0x3d3d3d3d
var_5143a868:	.word	0x3d3d3d3d
var_5143a86c:	.word	0x3d3d3d3d
var_5143a870:	.word	0x3d3d3d3d
var_5143a874:	.word	0x3d3d3d3d
var_5143a878:	.word	0x3d3d3d3d
var_5143a87c:	.word	0x0000000a
var_5143a880:	.word	0x65746e49
var_5143a884:	.word	0x70757272
var_5143a888:	.word	0x61772074
var_5143a88c:	.word	0x69642073
var_5143a890:	.word	0x6c626173
var_5143a894:	.word	0x2e2e2e65
var_5143a898:	.word	0x7968572e
var_5143a89c:	.word	0x2e3f3f3f
var_5143a8a0:	.word	0x52202e2e
var_5143a8a4:	.word	0x74657365
var_5143a8a8:	.word	0x676e6974
var_5143a8ac:	.word	0x2e2e2e20
var_5143a8b0:	.word	0x2e2e2e2e
var_5143a8b4:	.word	0x00000a2e
var_5143a8b8:	.word	0x0001000a

_5143a8bc:
	cmp	r6, #2	
	bne	_5143a8cc 
	orr	r0, r0, #0x10000
	b	_5143a8d8
_5143a8cc:
	cmp	r6, #3	
	bne	_5143a8d8
	orr	r0, r0, #0x18000
_5143a8d8:
	orr	r0, r0, #0x1000
	orr	r0, r0, #0x2
	orr	r0, r0, #0xc
	orr	r0, r0, #0x40
	orr	r0, r0, #0x200
	b	_5143a91c
_5143a8f0:
	cmp	r7, #2	
	bne	_5143a91c
	bic	r0, r0, #0xe0000
	cmp	r8, #0	
	bne	_5143a90c
	orr	r0, r0, #0x80000
	b	_5143a918
_5143a90c:
	cmp	r8, #1	
	bne	_5143a918
	orr	r0, r0, #0x40000
_5143a918:
	orr	r0, r0, #0x20000
_5143a91c:
	str	r0, [r1, #304]
	b	ret_5143a758	// 0x5143a920

sub_5143a924:
	stmdb	sp!, {r4, lr}
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc
	cmp	r0, #1	
	beq	_5143a958
	ldr	r0, var_5143a83c
	ldr	r1, var_5143b13c
	str	r1, [r0, #16]
	ldr	r1, [r0, #20]
	add	r1, r1, #1	
	str	r1, [r0, #20]
	mvn	r0, #0	
ret_5143a954:
	ldmia	sp!, {r4, pc}
_5143a958:
	bl	sub_514173f0
	mov	r0, #0
	b	ret_5143a954 // 0x5143a960

sub_5143a964:
	stmdb	sp!, {r4, lr}
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc
	cmp	r0, #1	
	beq	_5143a994
	ldr	r0, var_5143a83c
	ldr	r1, var_5143b140
	str	r1, [r0, #16]
	ldr	r1, [r0, #20]
	add	r1, r1, #1
	str	r1, [r0, #20]
ret_5143a990:
	ldmia	sp!, {r4, pc}
_5143a994:
	ldr	r1, var_5143b144
	mov	r0, #8
	str	r0, [r1, #12]
	b	ret_5143a990 // 0x5143a9a0

sub_5143a9a4:
	stmdb	sp!, {r4, lr}
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc
	cmp	r0, #1
	beq	_5143a9d4
	ldr	r0, var_5143a83c
	ldr	r1, var_5143b148
	str	r1, [r0, #16]
	ldr	r1, [r0, #20]
	add	r1, r1, #1
	str	r1, [r0, #20]
ret_5143a9d0:
	ldmia	sp!, {r4, pc}
_5143a9d4:
	ldr	r1, var_5143a850
	ldr	r0, [r1]
	orr	r0, r0, #3	
	str	r0, [r1]
	b	ret_5143a9d0	// 0x5143a9e4




sub_5143ab50:
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	ldr	ip, [sp, #36]
	ldr	r4, [sp, #40]
	ldr	lr, [sp, #32]
	and	r5, r0, #15	// 0xf
	and	r6, r1, #15	// 0xf
	and	r7, r2, #15	// 0xf
	and	r8, r3, #15	// 0xf
	and	r9, lr, #15	// 0xf
	and	sl, ip, #15	// 0xf
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc 
	cmp	r0, #1
	beq	_5143aba8
	ldr	r0, var_5143a83c
	ldr	r1, var_5143b158
	str	r1, [r0, #16]
	ldr	r1, [r0, #20]
	add	r1, r1, #1	
	str	r1, [r0, #20]
	mvn	r0, #0
ret_5143aba4:
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
_5143aba8:
	cmp	r4, #0	
	bne	_5143abb8
	mvn	r0, #2	
	b	ret_5143aba4
_5143abb8:
	cmp	r4, #1	
	bne	_5143abc8
	mov	r0, #88	// 0x58
	b	_5143abec
_5143abc8:
	cmp	r4, #2	
	bne	_5143abd8
	mov	r0, #104	// 0x68
	b	_5143abec
_5143abd8:
	cmp	r4, #3	
	bne	_5143abe8
	mov	r0, #120	// 0x78
	b	_5143abec
_5143abe8:
	mov	r0, #136	// 0x88
_5143abec:
	mov	r1, r5, lsl #20
	orr	r1, r1, r6, lsl #16
	orr	r1, r1, r7, lsl #12
	orr	r1, r1, r8, lsl #8
	orr	r1, r1, r9, lsl #4
	orr	r1, r1, sl
	ldr	r2, var_5143b15c
	add	r3, r4, r4, lsl #1
	add	r2, r2, r3, lsl #3
	str	r0, [r2, #16]
	str	r1, [r2, #20]
	mov	r0, #1	
	strb	r0, [r2, #1]
	mov	r0, #0	
	b	ret_5143aba4	// 0x5143ac24

sub_5143ac28:
	stmdb	sp!, {r4, lr}
	mov	r4, r0
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc
	cmp	r0, #1	
	beq	_5143ac5c 
	ldr	r0, var_5143a83c 
	ldr	r1, var_5143b160
	str	r1, [r0, #16]
	ldr	r1, [r0, #20]
	add	r1, r1, #1
	str	r1, [r0, #20]
ret_5143ac58:
	ldmia	sp!, {r4, pc}
_5143ac5c:
	mov	r0, #1
	mov	r3, #0
_5143ac64:
	cmp	r0, #1
	bne	_5143ac74
	mov	r1, #320	// 0x140 ==> W1KEYCON0 (Color key control register)
	b	_5143ac98
_5143ac74:
	cmp	r0, #2	
	bne	_5143ac84
	mov	r1, #328	// 0x148 ==> W2KEYCON0 (Color key control register)
	b	_5143ac98
_5143ac84:
	cmp	r0, #3	
	bne	_5143ac94
	mov	r1, #336	// 0x150 ==> W3KEYCON0 (Color key control register)
	b	_5143ac98
_5143ac94:
	mov	r1, #344	// 0x158 ==> W4KEYCON0 (Color key control register)
_5143ac98:
	add	r1, r1, #0x70000000
	add	r1, r1, #0x7100000
	ldr	r2, [r1]	// read from WxKEYCON0 register 
	cmp	r4, #0
	beq	_5143acb8 
	orr	r2, r2, #0x2000000
	str	r2, [r1]
	b	_5143acbc 
_5143acb8:
	str	r3, [r1]
_5143acbc:
	add	r0, r0, #1
	cmp	r0, #5	
	blt	_5143ac64
	b	ret_5143ac58	// 0x5143acc8

sub_5143accc:
	stmdb	sp!, {r4, lr}
	mov	r4, r0
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc 
	cmp	r0, #1	
	beq	_5143ad00
	ldr	r0, var_5143a83c
	ldr	r1, var_5143b164
	str	r1, [r0, #16]
	ldr	r1, [r0, #20]
	add	r1, r1, #1	
	str	r1, [r0, #20]
ret_5143acfc:
	ldmia	sp!, {r4, pc}
_5143ad00:
	mov	r0, #0
_5143ad04:
	cmp	r0, #0
	bne	_5143ad14
	mov	r1, #384	// 0x180 ==> WIN0MAP (Window color control)
	b	_5143ad48 
_5143ad14:
	cmp	r0, #1
	bne	_5143ad24 
	mov	r1, #388	// 0x184 ==> WIN1MAP (Window color control)
	b	_5143ad48
_5143ad24:
	cmp	r0, #2
	bne	_5143ad34
	mov	r1, #392	// 0x188 ==> WIN2MAP (Window color control)
	b	_5143ad48
_5143ad34:
	cmp	r0, #3
	bne	_5143ad44
	mov	r1, #396	// 0x18c ==> WIN3MAP (Window color control)
	b	_5143ad48
_5143ad44:
	mov	r1, #400	// 0x190 ==> WIN4MAP (Window color control)
_5143ad48:
	add	r2, r1, #0x70000000
	add	r2, r2, #0x7100000
	ldr	r1, [r2]	// read from register WINxMAP register
	cmp	r4, #0	
	beq	_5143ad68
	orr	r1, r1, #0x1000000
	str	r1, [r2]
	b	_5143ad70
_5143ad68:
	bic	r1, r1, #0x1000000
	str	r1, [r2]
_5143ad70:
	add	r0, r0, #1	
	cmp	r0, #5	
	blt	_5143ad04
	b	ret_5143acfc 	// 0x5143ad7c

sub_5143ad80:
	stmdb	sp!, {r4, lr}
	sub	sp, sp, #24	// 0x18
	mov	r4, r0
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc
	cmp	r0, #1	
	beq	_5143adbc
	ldr	r0, var_5143a83c
	ldr	r1, var_5143b168
	str	r1, [r0, #16]
	ldr	r1, [r0, #20]
	add	r1, r1, #1	
	str	r1, [r0, #20]
_5143adb4:
	add	sp, sp, #24	// 0x18
ret_5143adb8:
	ldmia	sp!, {r4, pc}
_5143adbc:
	ldr	r0, var_5143a850
	ldr	r1, [r0, #32]
	str	r1, [sp, #4]
	ldr	r1, [r0, #36]
	str	r1, [sp, #8]
	ldr	r1, [r0, #40]
	str	r1, [sp, #12]
	ldr	r1, [r0, #44]
	str	r1, [sp, #16]
	ldr	r1, [r0, #48]
	str	r1, [sp, #20]
	cmp	r4, #0
	beq	_5143ae30
_5143adf0:
	ldr	r1, [sp, #4]
	orr	r1, r1, #1
	str	r1, [r0, #32]
	ldr	r1, [sp, #8]
	orr	r1, r1, #1
	str	r1, [r0, #36]
	ldr	r1, [sp, #12]
	orr	r1, r1, #1
	str	r1, [r0, #40]
	ldr	r1, [sp, #16]
	orr	r1, r1, #1
	str	r1, [r0, #44]
	ldr	r1, [sp, #20]
	orr	r1, r1, #1
	str	r1, [r0, #48]
	b	_5143adb4
_5143ae30:
	ldr	r1, [sp, #4]
	bic	r1, r1, #1
	str	r1, [r0, #32]
	ldr	r1, [sp, #8]
	bic	r1, r1, #1
	str	r1, [r0, #36]
	ldr	r1, [sp, #12]
	bic	r1, r1, #1
	str	r1, [r0, #40]
	ldr	r1, [sp, #16]
	bic	r1, r1, #1
	str	r1, [r0, #44]
	ldr	r1, [sp, #20]
	bic	r1, r1, #1
	str	r1, [r0, #48]
	b	_5143adb4 	// 0x5143ae6c

sub_5143ae70:
	stmdb	sp!, {r4, lr}
	mov	r4, r0
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc 
	cmp	r0, #1	
	beq	_5143aea4
	ldr	r0, var_5143a83c
	ldr	r1, var_5143b16c 
	str	r1, [r0, #16]
	ldr	r1, [r0, #20]
	add	r1, r1, #1
	str	r1, [r0, #20]
ret_5143aea0:
	ldmia	sp!, {r4, pc}
_5143aea4:
	cmp	r4, #0	
	bne	_5143aeb4 
	mov	r0, #0	
	b	_5143aec8 
_5143aeb4:
	cmp	r4, #4	
	bne	_5143aec4 
	mov	r0, #12	// 0xc
	b	_5143aec8
_5143aec4:
	mov	r0, #4
_5143aec8:
	ldr	r2, var_5143a850 
	ldr	r1, [r2]
	bic	r1, r1, #12	// 0xc
	orr	r0, r1, r0
	str	r0, [r2]
	cmp	r4, #1	
	bne	_5143aef4
ret_5143aee4:
	ldmia	sp!, {r4, lr}
	mov	r1, #8	
	mov	r0, #30	// 0x1e
	b	sub_51436a48 
_5143aef4:
	cmp	r4, #2	
	bne	_5143af0c 
ret_5143aefc:
	ldmia	sp!, {r4, lr}
	mov	r1, #7	
	mov	r0, #30	// 0x1e
	b	sub_51436a48
_5143af0c:
	cmp	r4, #3	
	bne	ret_5143aea0
ret_5143af14:
	ldmia	sp!, {r4, lr}
	mov	r1, #3	
	mov	r0, #30	// 0x1e
	b	sub_51436a48 

sub_5143af24:
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	mov	r6, r2
	mov	r8, r0
	.word	0xed2d8b02 	//	fstmdbd	sp!, {d8}
	mov	r7, r3
	mov	r9, r1
	ldr	r4, [sp, #40]
	.word	0xed9f8b8a 	//	fldd	d8, [pc, #552]	// FLOAT VAR 
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc
	cmp	r0, #1
	beq	_5143af74 
	ldr	r0, var_5143a83c
	ldr	r1, var_5143b178
	str	r1, [r0, #16]
	ldr	r1, [r0, #20]
	add	r1, r1, #1
	str	r1, [r0, #20]
ret_5143af6c:
	.word	0xecbd8b02	// 	fldmiad	sp!, {d8}
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
_5143af74:
	cmp	r4, #0	
	mov	r5, #1000	// 0x3e8
	bne	_5143afa0
	mov	r0, #0	
	bl	sub_5143ae70 
	mov	r0, #66	// 0x42
	bl	SYSCON_related_a
	mul	r0, r5, r0
	.word	0xee080a10 	//	fmsr	s16, r0
	.word	0xeeb88b48 	//	fuitod	d8, s16
	b	_5143b040
_5143afa0:
	cmp	r4, #1	
	bne	_5143afb8
	mov	r0, #1
	bl	sub_5143ae70
	.word	0xed9f8b71 	//	fldd	d8, [pc, #452]	// FLOAT VAR 
	b	_5143b040
_5143afb8:
	cmp	r4, #2
	bne	_5143b01c
	mov	r0, #2
	bl	sub_5143ae70
	mov	r0, #63	// 0x3f
	bl	SYSCON_related_a
	mov	r4, r0
	ldr	r1, var_5143b184
	cmp	r4, r1
	bne	_5143aff0
	mul	r0, r5, r4
	.word	0xee080a10 	//	fmsr	s16, r0
	.word	0xeeb88b48 	//	fuitod	d8, s16
	b	_5143affc 
_5143aff0:
	mul	r0, r5, r4
	.word	0xee080a10 	//	fmsr	s16, r0
	.word	0xeeb88b48 	//	fuitod	d8, s16
_5143affc:
	add	r0, pc, #388	// 0x184	// !!!! PC relative 0x5143affc + 0x184
	bl	SimpleDebugPrint
	mov	r1, r4
	add	r0, pc, #412	// 0x19c	// !!!! PC relative 0x5143b008 + 0x19c
	bl	SimpleDebugPrint
	ldr	r0, var_5143b1cc
	bl	SimpleDebugPrint
	b	_5143b040
_5143b01c:
	cmp	r4, #3
	bne	_5143b034
	mov	r0, #3
	bl	sub_5143ae70 
	.word	0xed9f8b67 	//	fldd	d8, [pc, #412]	// FLOAT VAR 
	b	_5143b040
_5143b034:
	cmp	r4, #4	
	bne	_5143b040
	.word	0xed9f8b65 	//	fldd	d8, [pc, #404]	// FLOAT VAR 
_5143b040:
	ldr	r0, var_5143b1e0
	ldr	r1, [r0, #12]
	ldr	r2, [r0, #16]
	add	r1, r1, r2
	ldr	r2, [r0, #20]
	add	r1, r1, r2
	add	r1, r1, r8
	add	r1, r1, #3
	ldrd	r2, [r0]
	ldr	r0, [r0, #8]
	add	r2, r2, r3
	add	r0, r2, r0
	add	r0, r0, r9
	add	r0, r0, #3
	mul	r0, r1, r0
	mov	r1, #55	// 0x37
	.word	0xed9f1b57 	//	fldd	d1, [pc, #348]	// FLOAT VAR 
	mul	r0, r1, r0
	.word	0xee000a10 	//	fmsr	s0, r0
	.word	0xeeb80b40 	//	fuitod	d0, s0
	.word	0xee880b00 	//	fdivd	d0, d8, d0
	.word	0xee300b41 	//	fsubd	d0, d0, d1
	.word	0xed9f1b53 	//	fldd	d1, [pc, #332]
	.word	0xee300b01 	//	faddd	d0, d0, d1
	.word	0xed9f1b53 	//	fldd	d1, [pc, #332]
	.word	0xee200b01 	//	fmuld	d0, d0, d1
	.word	0xed9f1b53 	//	fldd	d1, [pc, #332]
	.word	0xee200b01 	//	fmuld	d0, d0, d1
	.word	0xeebd8bc0 	//	ftosizd	s16, d0
	.word	0xee180a10 	//	fmrs	r0, s16
	str	r0, [r6]
	cmp	r0, #1	
	bcc	_5143b0cc
	mov	r2, #1
	b	_5143b0d0
_5143b0cc:
	mov	r2, #0
_5143b0d0:
	str	r2, [r7]
	ldr	r1, [r6]
	add	r0, pc, #292	// 0x124	// !!!! PC relative 0x5143b0d8 + 0x124
	bl	SimpleDebugPrint
	b	ret_5143af6c	// 0x5143b0e0


/*
 *  5143b000
 */

sub_5143b0e4:
	stmdb	sp!, {r4, lr}
	mov	r4, r0
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc 
	cmp	r0, #1
	beq	_5143b118
	ldr	r0, var_5143a83c 
	ldr	r1, var_5143b228
	str	r1, [r0, #16]
	ldr	r1, [r0, #20]
	add	r1, r1, #1
	str	r1, [r0, #20]
ret_5143b114:
	ldmia	sp!, {r4, pc}
_5143b118:
	ldr	r1, var_5143a850
	ldr	r0, [r1]
	cmp	r4, #0	
	beq	_5143b130
	bic	r0, r0, #1
	b	_5143b134
_5143b130:
	bic	r0, r0, #3
_5143b134:
	str	r0, [r1]
	b	ret_5143b114	// 0x5143b138

var_5143b13c:	.word	0x0001000b
var_5143b140:	.word	0x0001000c
var_5143b144:	.word	0x74108000
var_5143b148:	.word	0x0001000e
var_5143b14c:	.word	0x00010045
var_5143b150:	.word	0x0001003f
var_5143b154:	.word	0x00010042
var_5143b158:	.word	0x0001002b
var_5143b15c:	.word	0x5164abb4
var_5143b160:	.word	0x0001002a
var_5143b164:	.word	0x00010029
var_5143b168:	.word	0x00010028
var_5143b16c:	.word	0x00010036
var_5143b170:	.word	0x00000000
var_5143b174:	.word	0x00000000
var_5143b178:	.word	0x0001001d
var_5143b17c:	.word	0x80000000
var_5143b180:	.word	0x41974b22
var_5143b184:	.word	0x000411aa
var_5143b188:	.word	0x3d3d3d0a
var_5143b18c:	.word	0x3d3d3d3d
var_5143b190:	.word	0x3d3d3d3d
var_5143b194:	.word	0x3d3d3d3d
var_5143b198:	.word	0x3d3d3d3d
var_5143b19c:	.word	0x3d3d3d3d
var_5143b1a0:	.word	0x3d3d3d3d
var_5143b1a4:	.word	0x3d3d3d3d
var_5143b1a8:	.word	0x00000a3d
var_5143b1ac:	.word	0x44434c20
var_5143b1b0:	.word	0x756f5320
var_5143b1b4:	.word	0x20656372
var_5143b1b8:	.word	0x204b4c43
var_5143b1bc:	.word	0x4d203e2d
var_5143b1c0:	.word	0x284c4c50
var_5143b1c4:	.word	0x0a296425
var_5143b1c8:	.word	0x00000000
var_5143b1cc:	.word	0x5143a85c
var_5143b1d0:	.word	0x00000000
var_5143b1d4:	.word	0x4166e360
var_5143b1d8:	.word	0x00000000
var_5143b1dc:	.word	0x4179bfcc
var_5143b1e0:	.word	0x5164ed24
var_5143b1e4:	.word	0x00000000
var_5143b1e8:	.word	0x3ff00000
var_5143b1ec:	.word	0x00000000
var_5143b1f0:	.word	0x3fe00000
var_5143b1f4:	.word	0x00000000
var_5143b1f8:	.word	0x40240000
var_5143b1fc:	.word	0x9999999a
var_5143b200:	.word	0x3fb99999
var_5143b204:	.word	0x6b6c4375
var_5143b208:	.word	0x206c6156
var_5143b20c:	.word	0x7830203d
var_5143b210:	.word	0x2c207825
var_5143b214:	.word	0x6c437520
var_5143b218:	.word	0x7269446b
var_5143b21c:	.word	0x30203d20
var_5143b220:	.word	0x20782578
var_5143b224:	.word	0x0000000a
var_5143b228:	.word	0x00010051

sub_5143b22c:
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub	sp, sp, #20	// 0x14
	mov	r4, #0	
	bl	load_0x5A0B0004_to_R0
	mov	r8, r0
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc 
	ldr	r7, var_5143a83c
	cmp	r0, #1	
	beq	_5143b274
	ldr	r0, var_5143b56c
	str	r0, [r7, #16]
	ldr	r0, [r7, #20]
	add	r0, r0, #1	
	str	r0, [r7, #20]
	mvn	r0, #0	
_5143b26c:
	add	sp, sp, #20	// 0x14
ret_5143b270:
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, pc}
_5143b274:
	ldr	r5, var_5143a2b4
	mov	r6, #0
	strb	r6, [r5, #436]
	str	r6, [r5, #440]
	strb	r6, [r5, #460]
	strb	r6, [r5, #461]
	strb	r6, [r5, #462]
	mov	r0, #4
	str	r0, [r5, #444]
	mov	r9, #2
	add	r0, r5, #472	// 0x1d8
	bl	sub_514176dc
	mov	r0, #480	// 0x1e0 hresolution
	str	r0, [r5, #380]
	mov	r0, #800	// 0x320 vresolution
	str	r0, [r5, #384]
	str	r6, [r5, #428]
	mov	r0, r6
	str	r6, [r5, #432]
	ldr	r1, [r8, #48]
	ldr	r6, var_5143a850
	cmp	r1, #2
	bcc	_5143b2dc
	mov	r1, #240	// 0xf0
	str	r1, [r6, #4]
	b	_5143b2e4 
_5143b2dc:
	mov	r1, #144	// 0x90
	str	r1, [r6, #4]
_5143b2e4:
	ldr	r1, var_5143b1e0
	ldr	r2, [r1]
	mov	r3, r2, lsl #24
	and	r2, r2, #255	// 0xff
	orr	r3, r3, r2, lsl #16
	ldr	r2, [r1, #4]
	and	ip, r2, #255	// 0xff
	orr	r3, r3, ip, lsl #8
	ldr	ip, [r1, #8]
	and	ip, ip, #255	// 0xff
	orr	r3, r3, ip
	str	r3, [r6, #16]
	ldr	r3, [r1, #12]
	mov	r2, r2, lsl #24
	and	r3, r3, #255	// 0xff
	orr	r2, r2, r3, lsl #16
	ldr	r3, [r1, #16]
	ldr	r1, [r1, #20]
	and	r3, r3, #255	// 0xff
	and	r1, r1, #255	// 0xff
	orr	r2, r2, r3, lsl #8
	orr	r1, r2, r1
	str	r1, [r6, #20]
	ldr	r1, var_5143b570
	str	r1, [r6, #24]
	str	r0, [r6, #368]
	mov	r0, #0	
	bl	sub_5143b0e4
_5143b354:
	ldr	r0, [r6]
	tst	r0, #3	
	beq	_5143b378
	mov	r0, #10	// 0xa
	bl	sub_51430f80
	cmp	r4, #2000	// 0x7d0
	bls	_5143b410
	ldr	r0, var_5143b574
	str	r0, [r7, #16]
_5143b378:
	str	r9, [sp]
	ldr	r0, [r5, #380]
	ldr	r1, [r5, #384]
	add	r3, sp, #12	// 0xc
	add	r2, sp, #16	// 0x10
	bl	sub_5143af24
	ldr	r1, [sp, #16]
	ldr	r0, [r5, #428]
	and	r1, r1, #255	// 0xff
	orr	r0, r0, r1, lsl #6
	ldr	r1, [sp, #12]
	and	r1, r1, #1	
	orr	r0, r0, r1, lsl #4
	ldr	r1, [r5, #444]
	orr	r4, r0, r1
	ldr	r1, var_5143b578
	mov	r0, #2	
	str	r0, [r1, #296]
	add	r0, pc, #436	// 0x1b4	// !!!! PC relative 0x5143b3c0 + 0x1b4
	bl	SimpleDebugPrint
	ldr	r2, [sp, #16]
	mov	r1, r4
	add	r0, pc, #464	// 0x1d0	// !!!! PC relative 0x5143b3d0 + 0x1d0
	bl	SimpleDebugPrint
	add	r0, pc, #412	// 0x19c	// !!!! PC relative 0x5143b3d8 + 0x19c
	bl	SimpleDebugPrint
	str	r4, [r6]
	ldr	r0, [r6, #304]
	orr	r0, r0, #32	// 0x20
	str	r0, [r6, #304]
	mov	r0, #0	
	bl	sub_5143ad80 
	mov	r0, #0	
	bl	sub_5143accc 
	mov	r0, #0	
	bl	sub_5143ac28 
	mov	r4, #1	
	b	_5143b418
_5143b410:
	add	r4, r4, #1
	b	_5143b354
_5143b418:
	cmp	r4, #1	
	bne	_5143b428
	mov	r3, #1	
	b	_5143b44c
_5143b428:
	cmp	r4, #2	
	bne	_5143b438
	mov	r3, #2	
	b	_5143b44c
_5143b438:
	cmp	r4, #3	
	bne	_5143b448
	mov	r3, #3	
	b	_5143b44c
_5143b448:
	mov	r3, #4	
_5143b44c:
	mov	r2, #0	
	str	r2, [sp]
	strd	r2, [sp, #4]
	mov	r3, #0	
	mov	r1, #0	
	mov	r0, #0	
	bl	sub_5143ab50 
	add	r4, r4, #1
	cmp	r4, #5	
	bcc	_5143b418
	mov	r0, #0	
	b	_5143b26c	// 0x5143b478

sub_5143b47c:
	stmdb	sp!, {r3, r4, r5, lr}
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc
	ldr	r4, var_5143a83c
	cmp	r0, #1
	beq	_5143b4ac
	ldr	r0, var_5143b5cc
	str	r0, [r4, #16]
	ldr	r0, [r4, #20]
	add	r0, r0, #1
	str	r0, [r4, #20]
ret_5143b4a8:
	ldmia	sp!, {r3, r4, r5, pc}
_5143b4ac:
	bl	sub_5143b22c
	ldr	r1, var_5143b5d0
	mov	r0, #30	// 0x1e
	bl	sub_51401880
	mov	r3, #1
	str	r3, [sp]
	mov	r3, #0
	mov	r2, #0
	mov	r1, #0
	mov	r0, #1
	bl	sub_5143a718
	bl	sub_5143a4f0 
	mov	r0, #30	// 0x1e
	bl	sub_514014f4
	bl	sub_5143a9a4
	mov	r0, #0	
	str	r0, [r4, #52]
	ldr	r0, var_5143b5d4
	ldr	r1, [r0]
	ldr	r1, [r1, #2100]
	ldr	r0, [r0]
	orr	r1, r1, #32	// 0x20
	str	r1, [r0, #2100]
	b	ret_5143b4a8	// 0x5143b508
 
sub_5143b50c:
	stmdb	sp!, {r4, lr}
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc
	cmp	r0, #1	
	beq	_5143b540
	ldr	r0, var_5143a83c
	ldr	r1, var_5143b5d8
	str	r1, [r0, #16]
	ldr	r1, [r0, #20]
	add	r1, r1, #1	
	str	r1, [r0, #20]
	mvn	r0, #0	
ret_5143b53c:
	ldmia	sp!, {r4, pc}
_5143b540:
	bl	sub_514176d4
	bl	sub_5143b47c
	mov	r0, #0	
	b	ret_5143b53c	// 0x5143b54c

sub_5143b550:
	ldr	r3, var_5143b5dc
	add	r2, r3, r2, lsl #2
	ldr	r3, [r2, #260]
	str	r3, [r0]
	ldr	r0, [r2, #280]
	str	r0, [r1]
	bx	lr	// 0x5143b568

var_5143b56c:	.word	0x00010011
var_5143b570:	.word	0x0018f9df
var_5143b574:	.word	0x00020011
var_5143b578:	.word	0x7e00f000
var_5143b57c:	.word	0x3d3d3d3d
var_5143b580:	.word	0x3d3d3d3d
var_5143b584:	.word	0x3d3d3d3d
var_5143b588:	.word	0x3d3d3d3d
var_5143b58c:	.word	0x3d3d3d3d
var_5143b590:	.word	0x3d3d3d3d
var_5143b594:	.word	0x3d3d3d3d
var_5143b598:	.word	0x3d3d3d3d
var_5143b59c:	.word	0x3d3d3d3d
var_5143b5a0:	.word	0x3d3d3d3d
var_5143b5a4:	.word	0x0000000a
var_5143b5a8:	.word	0x64695675
var_5143b5ac:	.word	0x526e6f63
var_5143b5b0:	.word	0x3d206765
var_5143b5b4:	.word	0x25783020
var_5143b5b8:	.word	0x202c2078
var_5143b5bc:	.word	0x6b6c4375
var_5143b5c0:	.word	0x206c6156
var_5143b5c4:	.word	0x7830203d
var_5143b5c8:	.word	0x000a7825
var_5143b5cc:	.word	0x00010013
var_5143b5d0:	.word	0x5143aac0
var_5143b5d4:	.word	0x514431e4
var_5143b5d8:	.word	0x0001000d
var_5143b5dc:	.word	0x5164eb4c



/*
 *  5143c000
 */

var_5143c28c:	.word	0x00010012
var_5143c290:	.word	0x00020012
var_5143c294:	.word	0x51446d5c
var_5143c298:	.word	0x00010014
var_5143c29c:	.word	0x00020014
var_5143c2a0:	.word	0x00010039
var_5143c2a4:	.word	0x77100000
var_5143c2a8:	.word	0x00010015
var_5143c2ac:	.word	0x00010016
var_5143c2b0:	.word	0x00010017
var_5143c2b4:	.word	0x5164ac2c
var_5143c2b8:	.word	0x00010018
var_5143c2bc:	.word	0x00010019
var_5143c2c0:	.word	0x0001001a
var_5143c2c4:	.word	0x0001001b
var_5143c2c8:	.word	0x0001001c
var_5143c2cc:	.word	0x57600000
var_5143c2d0:	.word	0x20657355
var_5143c2d4:	.word	0x7420666f
var_5143c2d8:	.word	0x20736968
var_5143c2dc:	.word	0x636e7566
var_5143c2e0:	.word	0x6e6f6974
var_5143c2e4:	.word	0x20736920
var_5143c2e8:	.word	0x72706544
var_5143c2ec:	.word	0x74616365
var_5143c2f0:	.word	0x3a3a6465
var_5143c2f4:	.word	0x206f4420
var_5143c2f8:	.word	0x20746f6e
var_5143c2fc:	.word	0x20657375
var_5143c300:	.word	0x73696874
var_5143c304:	.word	0x49504120
var_5143c308:	.word	0x0000200a
var_5143c30c:	.word	0x646e694b
var_5143c310:	.word	0x7520796c
var_5143c314:	.word	0x53206573
var_5143c318:	.word	0x4d5f5041
var_5143c31c:	.word	0x6f6c6c61
var_5143c320:	.word	0x20292863
var_5143c324:	.word	0x20646e61
var_5143c328:	.word	0x5f504153
var_5143c32c:	.word	0x65657246
var_5143c330:	.word	0x69202928
var_5143c334:	.word	0x6574736e
var_5143c338:	.word	0x200a6461
var_5143c33c:	.word	0x00000000



sub_5143c5e8:
	stmdb	sp!, {r4, r5, r6, lr}
	mov	r4, r0
	mov	r5, r1
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc
	ldr	r6, var_5143c294
	cmp	r0, #1
	beq	_5143c620
	ldr	r0, var_5143d21c
	str	r0, [r6, #16]
	ldr	r0, [r6, #20]
	add	r0, r0, #1
	str	r0, [r6, #20]
ret_5143c61c:
	ldmia	sp!, {r4, r5, r6, pc}
_5143c620:
	bl	sub_5143a534
	cmp	r0, #0
	bne	_5143c634
	ldr	r0, var_5143d220
	str	r0, [r6, #16]
_5143c634:
	cmp	r4, #0	
	bne	_5143c644
	mov	r0, #32	// 0x20
	b	_5143c678
_5143c644:
	cmp	r4, #1	// 0x1
	bne	_5143c654
	mov	r0, #36	// 0x24
	b	_5143c678
_5143c654:
	cmp	r4, #2	// 0x2
	bne	_5143c664 
	mov	r0, #40	// 0x28
	b	_5143c678
_5143c664:
	cmp	r4, #3	// 0x3
	bne	_5143c674
	mov	r0, #44	// 0x2c
	b	_5143c678 
_5143c674:
	mov	r0, #48	// 0x30
_5143c678:
	ldr	r3, var_5143d224
	add	r1, r4, r4, lsl #1
	str	r0, [r3, r1, lsl #2]
	add	r1, r3, r1, lsl #2
	str	r5, [r1, #4]
	mov	r2, #1
	strb	r2, [r1, #8]
	cmp	r4, #0
	mov	ip, #0
	bne	_5143c6c8
	add	r2, r0, #0x70000000
	add	r2, r2, #0x7100000
	ldr	r1, [r2]
	cmp	r5, #0
	beq	_5143c6bc 
	orr	r1, r1, #1
	b	_5143c6c0 
_5143c6bc:
	bic	r1, r1, #1
_5143c6c0:
	str	r1, [r2]
	strb	ip, [r3, #8]
_5143c6c8:
	cmp	r4, #4
	bne	ret_5143c61c
	add	r1, r0, #0x70000000
	add	r1, r1, #0x7100000
	ldr	r0, [r1]
	cmp	r5, #0	
	beq	_5143c6ec
	orr	r0, r0, #1
	b	_5143c6f0
_5143c6ec:
	bic	r0, r0, #1
_5143c6f0:
	str	r0, [r1]
	ldr	r0, var_5143d224 
	strb	ip, [r0, #56]
	b	ret_5143c61c 	// 0x5143c6fc







/*
 *  5143d000
 */

var_5143d210:	.word	0x0001001e
var_5143d214:	.word	0x0001001f
var_5143d218:	.word	0x5164aa4c
var_5143d21c:	.word	0x00010022
var_5143d220:	.word	0x000a0022
var_5143d224:	.word	0x5164ac90
var_5143d228:	.word	0x00010023
var_5143d22c:	.word	0x00010024
var_5143d230:	.word	0x00010025
var_5143d234:	.word	0x77100020
var_5143d238:	.word	0x00010026
var_5143d23c:	.word	0x77100024
var_5143d240:	.word	0x00010027
var_5143d244:	.word	0x51446d98
var_5143d248:	.word	0x0001002c
var_5143d24c:	.word	0x0001002d
var_5143d250:	.word	0x0001002e
var_5143d254:	.word	0x5164abb4
var_5143d258:	.word	0x0001002f
var_5143d25c:	.word	0x00010031
var_5143d260:	.word	0x0000ffff
var_5143d264:	.word	0x00010032
var_5143d268:	.word	0x00010033
var_5143d26c:	.word	0x00010034
var_5143d270:	.word	0x00010035



var_5143db00:	.word	0x00010037
var_5143db04:	.word	0x51446d5c
var_5143db08:	.word	0x77100000
var_5143db0c:	.word	0x00010038
var_5143db10:	.word	0x0001003a
var_5143db14:	.word	0x0001003b
var_5143db18:	.word	0x0001003c
var_5143db1c:	.word	0x5164eb4c
var_5143db20:	.word	0x514431e4
var_5143db24:	.word	0x0001003d
var_5143db28:	.word	0x00010040
var_5143db2c:	.word	0x00010041
var_5143db30:	.word	0x00020041
var_5143db34:	.word	0x00010043
var_5143db38:	.word	0x3849200a
var_5143db3c:	.word	0x6e492030
var_5143db40:	.word	0x72726574
var_5143db44:	.word	0x20747075
var_5143db48:	.word	0x74756f52
var_5143db4c:	.word	0x2e656e69
var_5143db50:	.word	0x00000a20
var_5143db54:	.word	0x00010044
var_5143db58:	.word	0x4946200a
var_5143db5c:	.word	0x49204f46
var_5143db60:	.word	0x7265746e
var_5143db64:	.word	0x74707572
var_5143db68:	.word	0x756f5220
var_5143db6c:	.word	0x656e6974
var_5143db70:	.word	0x000a202e
var_5143db74:	.word	0x00010046
var_5143db78:	.word	0x00010047
var_5143db7c:	.word	0x00010048



 
sub_5143dd4c:
	stmdb	sp!, {r4, lr}
	mov	r0, #30	// 0x1e
	bl	sub_51433dbc 
	cmp	r0, #1	
	beq	_5143dd80
	ldr	r0, var_5143db04 
	ldr	r1, var_5143e068 
	str	r1, [r0, #16]
	ldr	r1, [r0, #20]
	add	r1, r1, #1	
	str	r1, [r0, #20]
	mvn	r0, #0	
ret_5143dd7c:
	ldmia	sp!, {r4, pc}
_5143dd80:
	mov	r0, #1	
	bl	sub_51438cc8
	bl	sub_514173f0
	bl	sub_514173e0
	bl	sub_5143b50c
	mov	r0, #0
	b	ret_5143dd7c 	// 0x5143dd98 




/*
 *  5143e000
 */

var_5143e060:	.word	0x00010049
var_5143e064:	.word	0x0001004a
var_5143e068:	.word	0x00010050
var_5143e06c:	.word	0x0001004c
var_5143e070:	.word	0x6f727245
var_5143e074:	.word	0x6d492072
var_5143e078:	.word	0x20656761
var_5143e07c:	.word	0x62207369
var_5143e080:	.word	0x65676769
var_5143e084:	.word	0x68742072
var_5143e088:	.word	0x74206e61
var_5143e08c:	.word	0x62206568
var_5143e090:	.word	0x65666675
var_5143e094:	.word	0x553a3a72
var_5143e098:	.word	0x76206573
var_5143e09c:	.word	0x75747269
var_5143e0a0:	.word	0x73206c61
var_5143e0a4:	.word	0x65657263
var_5143e0a8:	.word	0x00000a6e
var_5143e0ac:	.word	0x0001004d
var_5143e0b0:	.word	0x0001004e



/*
 *  5143f000
 */

sub_5143f0a8:
	and	r3, r2, #255	// 0xff
	orr	r2, r3, r3, lsl #8
	orr	r2, r2, r2, lsl #16
	b	_5143f180	// 0x5143f0b4

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
_5143f180:
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

_spin_forever:
	b	_spin_forever

/*
 *
 */

vvar_51403204:	.word	0x51446da0
vvar_51403208:	.word	0x51446da0
vvar_5140320c:	.word	0x00000000
vvar_51403210:	.word	0x00207f9c
vvar_51403214:	.word	0x51446da0

vvar_51402258:	.word	0x514449A8

/*
 *
 */

_init_start_qi:
	stmdb   sp!, {r3-r5,lr}
	MOV     R1, #1
	MOV     R0, #0x16
	BL      value_table_sub_B
	MOV     R1, #1
	MOV     R0, #0x16
	BL      value_table_sub_A
	MOV     R1, #1
	MOV     R0, #0x16
	BL      value_table_sub_B
	MOV     R1, #1
	MOV     R0, #0xB0 // '¦'
	BL      value_table_sub_B
	MOV     R1, #1
	MOV     R0, #0xB0 // '¦'
	BL      value_table_sub_A
	MOV     R1, #1
	MOV     R0, #0xB0 // '¦'
	BL      value_table_sub_B
	MOV     R1, #2
	MOV     R0, #0x69 // 'i'
	BL	sub_514381c4
	MOV	R1, #0
	MOV	R0, #0x69 // 'i'
	BL	value_table_sub_A

	ldr	r0, vvar_51403204	// initial content: 0x51446da0
	ldr	r1, vvar_51403208	// initial content: 0x51446da0
	cmp	R0, R1
	beq	_init_no_copy_needed
	add	r1, r0, #0
	ldr	r0, vvar_51403208	// initial content: 0x51446da0
	ldr	r2, vvar_5140320c	// initial content: 0
	bl	memcopy_R2bytes_fromR0_toR1	// okay
_init_no_copy_needed:
	ldr	r2, vvar_51403210 	// =0x207F9C
	ldr	r0, vvar_51403214 	// initial content: 0x51446da0
	mov	r1, #0
	bl	memclear_R2bytes_withR1_atR0
	bl	sub_514152f8
	bl	load_0x5A0B0004_to_R0	// load_0x5A0B0004_to_R0
	mov	r4, r0
	bl	sub_514029b0
	str	r0, [R4,#0x30]
	BL      OneNAND_Init
//	LDR     R1, [R4,#0x30]
//	ADR     R0, aBoothwcheckD__ // "BootHWCheck: %d...\n"
//	BL      SimpleDebugPrint
	MOV     R0, #0x69 // 'i'
	bl	value_table_sub_C
//	CMP     R0, #0
//	BEQ     loc_51403064

//	LDR     R0, [R4,#0x30]
//	CMP     R0, #2
//	BCC     loc_51403064

	MOV     R1, SP
	MOV     R0, #0xF
	bl      PMIC_LUT2_read
//	ADR     R0, aNoBattery  // "NO battery\n"
//	BL      SimpleDebugPrint

//	BL      SelectBootingMode
	MOV     R0, #1
	bl      PMIC_set_reg_SRAMEN_MVTEN_LDOAEN
	MOV     R0, #0x7D0
	BL      sub_51430f80
	BL      LCD_InitWin // 0x51401B28

/*
	adr	r2, _pmu_write_var
	mov	r0, #0x78	// write to PMU
	mov	r1, #0x44	// reg = CARD1EN 
	mov	r3, #1		// why 1 ?
	bl	pmic_write_I2C
//	cmp	r0, #0
	b	_spin_forever
*/

	bl	pmic_reading_writing_B
	b	_spin_forever
//	ldr	pc, _start_oldboot



	MOV     R0, #0
	STR     R0, [R4,#0x24]
	ldr	r0, vvar_51402258 // =0x514449A8
	ldrb    r0, [r0]
	CMP     R0, #0x10

	MOV     R1, #0
	MOV     R0, #2
	bl      sub_5141ab40	// I2C_something
	bl	Download_Mode_MSG
//	BL      sub_514131A0
//	B       loc_514030E8

//	MOV     R0, #8
//	B       sub_5141804C

//	BL      sub_514185F4
//	BL      Baseband_Init



//	bl	_wait_10s
//	ldr	pc, _start_armboot
	ldr	pc, _start_oldboot


_pmu_write_var:
	.word	0xf
_start_armboot:
	.word 	start_qi
_start_oldboot:
	.word 	0x51400000
