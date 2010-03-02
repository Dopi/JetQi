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
_51402a0c:
	ldmia	sp!, {r4, r5, r6, pc}
_51402a10:
	cmp	r4, #0
	bne	_51402a30
	cmp	r5, #1	
	bne	_51402a30
	cmp	r0, #0	
	bne	_51402a30
	mov	r0, #2	
	b	_51402a0c
_51402a30:
	orrs	r1, r1, r0
	bne	_51402a40
	mov	r0, #3	
	b	_51402a0c
_51402a40:
	cmp	r4, #0
	bne	_51402a60
	cmp	r5, #1	
	bne	_51402a60
	cmp	r0, #1	
	bne	_51402a60
	mov	r0, #4	
	b	_51402a0c 
_51402a60:
	cmp	r4, #1
	bne	_51402a80
	cmp	r5, #0	
	bne	_51402a80
	cmp	r0, #0	
	bne	_51402a80
	mov	r0, #5	
	b	_51402a0c
_51402a80:
	cmp	r4, #1
	bne	_51402aa0
	cmp	r5, #0	
	bne	_51402aa0
	cmp	r0, #1	
 	bne	_51402aa0
	mov	r0, #6	
	b	_51402a0c
_51402aa0:
	cmp	r4, #1
	bne	_51402ac0
	cmp	r5, #1	
	bne	_51402ac0
	cmp	r0, #0	
	bne	_51402ac0
	mov	r0, #7	
	b	_51402a0c
_51402ac0:
	mov	r0, #0	
	b	_51402a0c



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
	BL      sub_514381c4
	MOV     R1, #0
	MOV     R0, #0x69 // 'i'
	BL      sub_51438078
	ldr     r0, var_51403204
	ldr     r1, var_51403208
	cmp     R0, R1
	BEQ     loc_51403000

	add     r1, r0, #0
	ldr     r0, var_51403208
	ldr     r2, var_5140320c
	bl      sub_5142fd38	// okay

loc_51403000:
	ldr     r2, var_51403210 // =0x207F9C
	ldr     r0, var_51403214 // =0x51446DA0 ???
	mov     r1, #0
	bl      sub_5142fd5c

//	ldr	r4,_oldstart
//	mov	pc, r4

	bl      sub_514152f8
	bl      sub_51415374	// load_0x5A0B0004_to_R0
	mov     r4, r0
	BL      sub_514029B0
	STR     R0, [R4,#0x30]
	BL      sub_51401C3C
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

/*
 * 
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
 * 
 */

var_5141543c:	.word	0x5a0b0000
var_51415440:	.word	0xb0078aed
var_51415444:	.word	0xb00717e3
var_51415448:	.word	0x5a0b0004

/* 
 * 
 */

sub_5142fd38:
	mov     r3, #0
	mov     ip, r2,lsr#2
_5142fd40:
	cmp     r3, ip
	bcs     locret_5142fd58
	ldr     r2, [r1,r3,lsl#2]
	str     r2, [r0,r3,lsl#2]
	add     r3, r3, #1
	b       _5142fd40
locret_5142fd58: 
	bx      lr


sub_5142fd5c:	
	mov	r3, #0
	mov	r2, r2, lsr #2
_5142fd64:
	cmp	r3, r2
	bcs	locret_5142fd78 
	str	r1, [r0, r3, lsl #2]
	add	r3, r3, #1
	b	_5142fd64 
locret_5142fd78:
	bx	lr



/*
 *  
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
 *	Subroutines
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


sub_51433bb4:
	mrc     p15, 0, R0,c1,c0
	orr     R0, R0, #0x800
	mcr     p15, 0, R0,c1,c0
	bx      lr



















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
