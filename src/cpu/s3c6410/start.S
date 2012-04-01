/*
 * Original and derived works:
 * (C) Copyright 2007 OpenMoko, Inc.
 * (C) Copyright 2007 Chronolytics Inc. 
 * (C) Copyright 2007 David F. Carlson <dave at chronolytics dot com>
 *
 * Jet (GT-S8000/8003) modifications
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

.globl _start, processor_id, is_jtag

_start:
	b	l_20		// 0x20
l_4:	b	l_4		// 0x4
l_8:	b	l_8		// 0x8
l_c:	b	l_c		// 0xc
l_10:	b	l_10		// 0x10
l_14:	b	l_14		// 0x14
l_18:	b	l_18		// 0x18
l_1c:	b	l_1c		// 0x1c
l_20:	mov	r0, #0
	mcr	15, 0, r0, cr7, cr7, 0	/* flush v3/v4 cache */
//	mcr	p15, 0, r0, c7, c7, 0	/* flush v3/v4 cache */
//	mcr	p15, 0, r0, c8, c7, 0	/* flush v4 TLB */
	mrc	15, 0, r0, cr1, cr0, 0
	orr	r0, r0, #4096	// 0x1000
	mcr	15, 0, r0, cr1, cr0, 0
	ldr	r0, [pc, #800]	// 0x35c	// R0 = SROM Bank control register adress
	mcr	15, 0, r0, cr15, cr2, 4
	ldr	r0, [pc, #796]	// 0x360	// R0 = Watchdog timer control register adress
	mov	r1, #0
	str	r1, [r0]			// clear Watchdog timer control register
	ldr	r0, [pc, #788]	// 0x364	// r0 = 0x71200014
	mvn	r1, #0				// r1 = 0xFFFFFFFF
	str	r1, [r0]			// store 0xFFFFFFFF to 0x71200014
	ldr	r0, [pc, #780]	// 0x368	// r0 = 0x71300014
	mvn	r1, #0				// r1 = 0xFFFFFFFF
	str	r1, [r0]			// store 0xFFFFFFFF to 0x71300014
	ldr	r0, [pc, #772]	// 0x36c	// r0 = 0x7F0081D4
	ldr	r1, [pc, #772]	// 0x370	// r1 = 0x55555555
	str	r1, [r0]			// store 0x55555555 to 0x7F0081D4

	bl	s_1d8		// 0x1d8	// JUMP TO OTHER Control reg setting

	ldr	r1, [pc, #764]	// 0x374	// r1 = 0x0000ffff
	ldr	r2, [pc, #764]	// 0x378	// r2 = 0x00000e13
	ldr	r0, [pc, #764]	// 0x37c	// LOAD APLL_LOCK adr (0x7E00F000) in R0
	str	r1, [r0]			// Read APLL_LOCK to R1
	str	r1, [r0, #4]
	str	r2, [r0, #8]
	ldr	r0, [pc, #752]	// 0x380	// Load CLK_DIV0 reg adr (0x7E00F020) in R0
	ldr	r1, [r0]			// Read CLK_DIV0 to R1
	bic	r1, r1, #196608	// 0x30000	// R1 = R1 AND !(0x30000)
	bic	r1, r1, #65280	// 0xff00	// R1 = R1 AND !(0x0FF00)
	bic	r1, r1, #255	// 0xff		// R1 = R1 AND !(0x000FF
	ldr	r2, [pc, #736]	// 0x384
	orr	r1, r1, r2			// R1 = R1 | 0x7501
	str	r1, [r0]			// Write R1 to CLK_DIV0
	ldr	r0, [pc, #728]	// 0x388	// Load APLL_CON reg adr in R0
	ldr	r1, [pc, #728]  // 0x38c	// =0x81900301
	str	r1, [r0]			// Write 0x81900301 to APLL_CON
	ldr	r0, [pc, #724]	// 0x390	// load MPLL_CON reg adr (0x7E00F010) in R0
	ldr	r1, [pc, #724]	// 0x394	// =0x81840303
	str	r1, [r0]			// Write 0x81840303 to MPLL_CON
	ldr	r0, [pc, #720]	// 0x398	// load EPLL_CON1 reg ard (0x7E00F018) in R0 
	ldr	r1, [pc, #720]	// 0x39c	// =0xC49C
	str	r1, [r0]			// write 0xC39C to EPLL_CON1
	ldr	r0, [pc, #716]	// 0x3a0	// load EPLL_CON0 reg adr (0x7E00F014) in R0
	ldr	r1, [pc, #716]	// 0x3a4	// =0x80200103
	str	r1, [r0]			// write 0x80200103 to EPLL_CON0
	ldr	r0, [pc, #712]	// 0x3a8	// load CLK_SRC reg adr (0x7E00F01C) in R0
	ldr	r1, [r0]			// Read CLK_SRC content to R1
	orr	r1, r1, #7			// R1 = R1 | 7
	str	r1, [r0]			// Store R1 to CLK_SRC
	ldr	r0, [pc, #700]	// 0x3ac	// =0x7E00F120
	mov	r1, #0
	bic	r1, r1, #128	// 0x80
	str	r1, [r0]

	bl	s_21c		// 0x21c	// JUMP To DRAM INIT

	ldr	r0, [pc, #684]	// 0x3b0	// load RST_STAT reg adr (0x7E00F904) in r0
	ldr	r1, [r0]			// load RESET STATUS REGISTER content to R1
	and	r1, r1, #72	// 0x48
	and	r2, r1, #72	// 0x48
	cmp	r2, #0
	beq	l_120		// 0x120
	ldr	r0, [pc, #664]	// 0x3b4	// r0 = INFORM2 Information register2 (0x7E00FA08)
	ldr	r1, [r0]			// load from INFORM2 to r1 
	mov	pc, r1				// JUMP to adr in R1

l_120:	ldr	r0, _MEM_CFG0	// 0x3b8	// load OneNAND MEM_CFG0 reg adr (0x70100000) R/W Bank0 Memory Device Configuration Register in r0
	ldr	r1, [pc, #656]	// 0x3bc	
	str	r1, [r0] 			// store 0x000040e0 to MEM_CFG0
	ldr	r0, [pc, #652]	// 0x3c0	// load OneNAND TRANS_SPARE0 reg adr (0x70100140) in r0
	mov	r1, #1
	str	r1, [r0]			// store 1 to TRANS_SPARE0
	mov	r6, #4
	ldr	r7, [pc, #640]	// 0x3c4	// copy target = 0x51400000
	mov	r4, #0
	mov	r3, #1				// start at index 0x800 => copy from 0x21000800
_copy_loop1:
	mov	r2, #0x21000000
	add	r2, r2, r4, lsl #12
	mov	r8, #128	// 0x80		// loop2 counter = 0x80 ==> copy 2048 byte
	add	r2, r2, r3, lsl #6		// r2 = 0x21000000 + (R4 << 12) + (R3 << 6)
_copy_loop2:	
	ldm	r2, {r9, sl, fp, ip}		// load 4*4 bytes from [R2]
	stmia	r7!, {r9, sl, fp, ip}		// store 4*4 bytes to [R7]++
	subs	r8, r8, #1			// decrement loop2 counter
	bne	_copy_loop2		 	// END copy_loop2 
	cmp	r3, #0
	bne	l_1a0		// 0x1a0
	ldr	r9, [r2]
	lsl	r9, r9, #16
	lsr	r9, r9, #16			// clear upper 16 bits of r9
	ldr	r2, [pc, #496]	// 0x374 	// =0x0000ffff
	cmp	r9, r2
	beq	l_1a0		// 0x1a0
	add	r6, r6, #1
	sub	r7, r7, #0x800	
	ldr	r0, _MEM_CFG0	// 0x3b8	// load OneNAND MEM_CFG0 reg adr (0x70100000) in r0
	mov	r1, #0x400
	str	r1, [r0, #0x50]			// store 0x400 in INT_ERR_ACK0 (0x70100050) Bank0 Int. Err. Ack. Reg.	
	b	l_1b8		
l_1a0:	
	ldr	r0, _MEM_CFG0	// 0x3b8	// load OneNAND MEM_CFG0 reg adr (0x70100000) in r0
	mov	r1, #0x400
	str	r1, [r0, #0x50]	  		// store 0x400 in INT_ERR_ACK0 (0x70100050) Bank0 Int. Err. Ack. Reg.
	add	r3, r3, #1
	cmp	r3, #64	// 0x40
	blt	_copy_loop1	// 0x148
l_1b8:	
	add	r4, r4, #1
	mov	r3, #0
	cmp	r4, r6
	blt	_copy_loop1	// 0x148

	ldr	r0, [pc, #500]	// 0x3c4	// r0 = 0x51400000
//	mov	pc, r0				// jump to 0x51400000
	b	_modstart
	bl	l_1d4		// 0x1d4
l_1d4:	b	l_1d4		// 0x1d4	// Infinite Loop

s_1d8:	ldr	r0, [pc, #488]	// 0x3c8	// r0 = OTHERS control register (0x7E00F900)
	ldr	r1, [r0]			// read from OTHERS control register to r1
	orr	r1, r1, #64	// 0x40		
	str	r1, [r0]			// store r1 in OTHERS control register
	nop	{0}
	nop	{0}
	nop	{0}
	nop	{0}
	nop	{0}
	ldr	r1, [r0]			// read OTHERS control register again
	orr	r1, r1, #128	// 0x80
	str	r1, [r0]			// store r1 in OTHERS control register
l_208:	ldr	r1, [r0]			// read OTHERS control register again
	and	r1, r1, #3840	// 0xf00
	cmp	r1, #3840	// 0xf00
	bne	l_208		// 0x208
	mov	pc, lr				// RETURN

s_21c:	ldr	r0, [pc, #424]	// 0x3cc
	mov	r1, #4
	str	r1, [r0, #4]
	mov	r1, #520	// 0x208
	str	r1, [r0, #16]
	mov	r1, #6
	str	r1, [r0, #20]
	mov	r1, #1
	str	r1, [r0, #24]
	mov	r1, #2
	str	r1, [r0, #28]
	mov	r1, #7
	str	r1, [r0, #32]
	mov	r1, #9
	str	r1, [r0, #36]	// 0x24
	mov	r1, #3
	mov	r2, #0
	orr	r1, r1, r2
	str	r1, [r0, #40]	// 0x28
	mov	r1, #17
	mov	r2, #448	// 0x1c0
	orr	r1, r1, r2
	str	r1, [r0, #44]	// 0x2c
	mov	r1, #3
	mov	r2, #0
	orr	r1, r1, r2
	str	r1, [r0, #48]	// 0x30
	mov	r1, #3
	str	r1, [r0, #52]	// 0x34
	mov	r1, #3
	str	r1, [r0, #56]	// 0x38
	mov	r1, #2
	str	r1, [r0, #60]	// 0x3c
	mov	r1, #2
	str	r1, [r0, #64]	// 0x40
	mov	r1, #17
	str	r1, [r0, #68]	// 0x44
	mov	r1, #17
	str	r1, [r0, #72]	// 0x48
	ldr	r1, [pc, #272]	// 0x3d0
	str	r1, [r0, #12]
	ldr	r1, [pc, #268]	// 0x3d4
	str	r1, [r0, #76]	// 0x4c
	ldr	r1, [pc, #264]	// 0x3d8
	str	r1, [r0, #512]	// 0x200
	ldr	r1, [pc, #260]	// 0x3dc
	str	r1, [r0, #516]	// 0x204
	mov	r1, #0
	str	r1, [r0, #772]	// 0x304
	mov	r1, #786432	// 0xc0000
	str	r1, [r0, #8]
	mov	r1, #0
	str	r1, [r0, #8]
	mov	r1, #262144	// 0x40000
	str	r1, [r0, #8]
	str	r1, [r0, #8]
	mov	r1, #655360	// 0xa0000
	str	r1, [r0, #8]
	ldr	r1, [pc, #212]	// 0x3e0
	str	r1, [r0, #8]
	mov	r1, #1835008	// 0x1c0000
	str	r1, [r0, #8]
	mov	r1, #1048576	// 0x100000
	str	r1, [r0, #8]
	mov	r1, #1310720	// 0x140000
	str	r1, [r0, #8]
	str	r1, [r0, #8]
	mov	r1, #1703936	// 0x1a0000
	str	r1, [r0, #8]
	ldr	r1, [pc, #172]	// 0x3e4
	str	r1, [r0, #8]
	mov	r1, #0
	str	r1, [r0, #4]
l_340:	ldr	r1, [r0]
	mov	r2, #3
	and	r1, r1, r2
	cmp	r1, #1
	bne	l_340		// 0x340
	nop	{0}
	mov	pc, lr		// RET

/*
 * Constants
 */
_35c:	.long	0x70000013
_360:	.long	0x7e004000
_364:	.long	0x71200014
_368:	.long	0x71300014
_36c:	.long	0x7f0081d4
_370:	.long	0x55555555
_374:	.long	0x0000ffff
_378:	.long	0x00000e13
_37c:	.long	0x7e00f000
_380:	.long	0x7e00f020
_384:	.long	0x00007501
_388:	.long	0x7e00f00c
_38c:	.long	0x81900301
_390:	.long	0x7e00f010
_394:	.long	0x81840303
_398:	.long	0x7e00f018
_39c:	.long	0x0000c49c
_3a0:	.long	0x7e00f014
_3a4:	.long	0x80200103
_3a8:	.long	0x7e00f01c
_3ac:	.long	0x7e00f120
_3b0:	.long	0x7e00f904
_3b4:	.long	0x7e00fa08
_MEM_CFG0:
	.long	0x70100000
_3bc:	.long	0x000040e0
_3c0:	.long	0x70100140
_3c4:	.long	0x51400000
_3c8:	.long	0x7e00f900
_3cc:	.long	0x7e001000
_3d0:	.long	0x40224019
_3d4:	.long	0x00000b41
_3d8:	.long	0x000150f8
_3dc:	.long	0x000158f8
_3e0:	.long	0x00080034
_3e4:	.long	0x00180034

/* 
 * If we are injected by JTAG, the script sets _istag content to nonzero 
 */
is_jtag:
	.word	0

/*
 * These are defined in the board-specific linker script.
 */
.globl _bss_start
_bss_start:
	.word __bss_start

.globl _bss_end
_bss_end:
	.word _end

/* it's at a fixed address (+0x8) so we can breakpoint it in the JTAG script
 * we need to go through this hassle because before this moment, SDRAM is not
 * working so we can't prep it from JTAG
 */
_TEXT_BASE:
	.word	TEXT_BASE
_old_new_base:
	.word	0x51400000 + 0x48000 - 0x800

/*
 * More constants
 */
_keypad_base:
	.long	0x7E00A000
_gpio_base:
	.long	0x7F008000
_const_fff:
	.long	0xfff

/*
 * Modified bootcode start
 */
_modstart:
	ldr	r0, _gpio_base
	ldr	r1, [r0,#0x810] // R1 = GPLCON0
	mov	r1, r1,lsr#12
	mov	r1, r1,lsr#12   // clear lower 12 bits of R1
	orr	r1, r1, #0x300
	orr	r1, r1, #0x33   // R1 = R1 + 0x333
	str	r1, [r0,#0x810] // Store R1 in GPLCON0
		                // Set GPL0,GPL1,GPL2 to keypad COL0,COL1,COL2
	ldr	r1, [r0,#0x804] // R1 = GPKCON1
	mov	r1, r1,lsr#12
	mov	r1, r1,lsl#12   // clear lower 12 bits of R1
	orr	r1, r1, #0x300
	orr	r1, r1, #0x33   // R1 = R1 + 0x333
	str	r1, [r0,#0x804] // store R1 in GPKCON1
		                // Set GPK8, GPK9, GPK10 to keypad ROW0, ROW1, ROW2
_setupGPIO_L:
	ldr	r1, _gpio_base
	ldr     r0, [r1,#0x81C] // r1 = GPLPUD (Port L Pull-up/down Register)
	bic     r0, r0, #3
	orr     r0, r0, #2
	str     r0, [r1,#0x81C] // set bit 1 (#2) and clear bit 0 of GPLPUP
	                        // ==> pull-up enabled for GPL0

	ldr     r0, [r1,#0x818] // GPLDAT
	bic     r0, r0, #6
	str     r0, [r1,#0x818] // clear bits 2:1 (#2+#4) of GPLDAT
	                        // ==> Output 0 on GPL2, GPL1
	ldr     r0, [r1,#0x810] // GPLCON0
	ldr	r2, _const_fff
	bic     r0, r0, r2
	orr     r0, r0, #0x110
	str     r0, [r1,#0x810] // Set bits 11-4 of GPLCON0 to 00010001
				// clear lower 4 bits of GPLCON0 
	                        // ==> GPL0 set as input, GPL1, GPL2 as output
_key_scan:
	ldr	r0, _keypad_base		// store Keypad base register in r0
	ldr	r0, [r0,#0xC]			// Read from KEYIFROW
	and	r0, r0, #1			// mask out last bit 
	cmp	r0, #0x0			// r0 = 0 ?
	beq	_second_phase			// no ==> second phase
_continue_ssboot:
	ldr	r0, _3c4	// 0x3c4	// r0 = 0x51400000
	mov	pc, r0				// jump to 0x51400000

_second_phase:
	bl	jet_apps_patch_start
	b	_continue_ssboot		// skip second stage for now

_init_stack:
#define CFG_GBL_DATA_SIZE		128			/* size in bytes reserved for initial data */
	ldr	r0, _TEXT_BASE		/* upper 128 KiB: relocated uboot   */
	sub	r0, r0, #CFG_GBL_DATA_SIZE 	/* bdinfo                        */
	sub	sp, r0, #12		/* leave 3 words for abort-stack    */

_clear_bss:
	ldr	r0, _bss_start		/* find start of bss segment        */
	ldr	r1, _bss_end		/* stop here                        */
	mov 	r2, #0x00000000		/* clear                            */
_clbss_l:
	str	r2, [r0]		/* clear loop...                    */
	add	r0, r0, #4
	cmp	r0, r1
	ble	_clbss_l

_copy_to_text_base:
	ldr	r0, _TEXT_BASE
	ldr	r1, _old_new_base
	mov	r2, #0x10000
	mov	r3, #0
	mov	ip, r2,lsr#2
_copy_to_text_base_loop:
	cmp	r3, ip
	bcs	_steppingstone_done
	ldr	r2, [r1,r3,lsl#2]
	str	r2, [r0,r3,lsl#2]
	add	r3, r3, #1
	b	_copy_to_text_base_loop


_steppingstone_done:
	ldr	pc, _TEXT_BASE
//	ldr	pc, _old_new_base


/*
 *
 *  new jet apps patched code from Rebellos
 *
 */
//org 0x51000000 ;modify to correct EP

jet_apps_patch_start:
	stmfd	sp!, {lr}

	ldr	r0, src
	ldr	r1, dst
	bl	ARM32_SetBL

	ldmfd	sp!, {pc}

	.align 4
src:
	.word	0x51402508	 // NOP NOP NOP sequence in LaunchNucleus in S8000XEIG2 BL
dst:
	.word	AppsPatcher

AppsPatcher:
	stmfd	 sp!, {lr}
	LDR	 R0, hook_loc_a
	ADR	 R1, hook
	LDR	 R2, hook_size
	BL	 rebell_memcpy


	LDR	 R0, hook2_loc_a
	ADR	 R1, hook2
	LDR	 R2, hook2_size
	BL	 rebell_memcpy

	LDR	 R0, dumper_loc_a
	ADR	 R1, dumper
	LDR	 R2, dumper_size
	BL	 rebell_memcpy
	ldmfd	 sp!, {pc}

	.align 4
//	.dst                    dw _hook1


//void rebell_memcpy(int source(r0), int target(r1), int size(r2))
//returns num of bytes copied (always equal to size or just hangs on mem access violation)
rebell_memcpy:
	STMFD	SP!, {R3-R6,LR}

	MOV	R3, R2
	MOV	R2, R1
	MOV	R1, R0

	MOV	R0, R1
	MOV	R1, R2
	MOV	R2, R3

	MOV	R3, #0
rebell_memcpy_copyloop:
	ldrb	r4, [r0,r3] //src
	strb	r4, [r1,r3] //dst
	add	r3, r3, #1
	cmp	r3, r2
	BLT	rebell_memcpy_copyloop
	MOV	R0, R2
	LDMFD	SP!, {R3-R6,PC}


// ARM32_SetB, ARM32_SetBL
// void ARM32_SetB ( unsigned int src, unsigned int dst );
// void ARM32_SetBL ( unsigned int src, unsigned int dst );
ARM32_SetB:
	mov	r2, #0xEA000000
	b	@f
ARM32_SetBL:
	mov	r2, #0xEB000000
@@:
	rsb	r3, r0, r1
	sub	r3, r3, #8
	ubfx	r3, r3, #2, #24
	orr	r3, r2
	str	r3, [r0]
	bx	lr

	.THUMB

	.ALIGN 4
#define dumper_loc 0x507A5000
dumper_loc_a:
	.word dumper_loc
#define hook_loc 0x5012120E
hook_loc_a: 
	.word 	hook_loc


/*
 * we have a stack in steppingstone because we can want to run full memory
 * memory tests
 */
//		.fill   0x400 			// filled until 0x800 automatically by linker script
.globl _ss_stack
#define _ss_stack 0x800

