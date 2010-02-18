/*
 * Original and derived works:
 * (C) Copyright 2007 OpenMoko, Inc.
 *
 * SmartQ clock setup and DDR settings:
 * (C) Copyright 2007 Chronolytics Inc. 
 * (C) Copyright 2007 David F. Carlson <dave at chronolytics dot com>
 *
 * Configuration settings for:
 *   SmartQ5/7 s3c6410 @ 666MHz with DDR333 Qimonda-HYB25DC512128CF-6
 *   
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

/* 
**  NOTE: support for CS=1 found on SMKD-6410 et al. is vestigial.
**  NOTE: code has been left in-situ for folks who are forward porting
**  NOTE: to other chips/configs.
*/
#ifndef JET
#define S3C6410_POP_A 1
#endif

#define set_pll(mdiv, pdiv, sdiv)	(1<<31 | mdiv<<16 | pdiv<<8 | sdiv)

/* Pick 1 of these clocks */
#define CONFIG_CLK_800_266_66	// FIXME: Is this correct?
// #define CONFIG_CLK_666_166_66
// #define CONFIG_CLK_666_133_66  
// #define CONFIG_CLK_532_133_66  

#if defined(CONFIG_CLK_800_266_66) /* FIN 12MHz, Fout 800MHz */
// 	 ARMCLK,  HCLKX2,	APLL,	PDIV,	ARM_DIV, HCLKX2_DIV */
// 	{800*MHZ, 266 *MHZ, 	400, 	3, 	0, 	 2},

#define APLL_MDIV       400
#define	Startup_PCLKdiv		3
#undef  CONFIG_SYNC_MODE /* ASYNC MODE */

#elif defined(CONFIG_CLK_666_166_66) /* FIN 12MHz, Fout 666MHz */

#define APLL_MDIV       333
#define	Startup_PCLKdiv		4
// #undef  CONFIG_SYNC_MODE /* ASYNC MODE */
#define CONFIG_SYNC_MODE

#elif defined(CONFIG_CLK_666_133_66) /* FIN 12MHz, Fout 666MHz */

#define APLL_MDIV       333
#define	Startup_PCLKdiv		3
#undef  CONFIG_SYNC_MODE /* ASYNC MODE */

#elif defined(CONFIG_CLK_532_133_66) /* FIN 12MHz, Fout 532MHz */

#define APLL_MDIV       266
#define	Startup_PCLKdiv		3
#define CONFIG_SYNC_MODE

#endif

/* input clock of PLL */
#define CONFIG_SYS_CLK_FREQ     12000000  /* 12MHz input clock */


/* fixed MPLL 533MHz */
#define MPLL_MDIV	266
#define MPLL_PDIV	3
#define MPLL_SDIV	1

/* for 666MHz/533MHz */
#define APLL_PDIV       3
#define APLL_SDIV       1

#define Startup_APLLdiv         0
#define Startup_HCLKdiv		1
#define Startup_MPLLdiv		1
#define Startup_HCLKx2div      	1

#define Startup_APLL	(CONFIG_SYS_CLK_FREQ/(APLL_PDIV<<APLL_SDIV)*APLL_MDIV)
#define Startup_MPLL    ((CONFIG_SYS_CLK_FREQ)/(MPLL_PDIV<<MPLL_SDIV)*MPLL_MDIV)

#if defined(CONFIG_SYNC_MODE)
#define Startup_HCLK    (Startup_APLL/(Startup_HCLKx2div+1)/(Startup_HCLKdiv+1))
#else
#define Startup_HCLK    (Startup_MPLL/(Startup_HCLKx2div+1)/(Startup_HCLKdiv+1))
#endif

/* convert tXXX to memory clks */
#define nSecToClk(nS)  (((Startup_HCLK / 1000 * (nS)) - 1) / 1000000 + 1)

/* selects whether HCLK/PCLK are derived from APLL (=1) or MPLL (=0) */
#define DMC_OTHERS_SYNCACK      (0xf << 8) /* read only acknowledge of sync */
#define DMC_OTHERS_SYNCMUXSEL	(1<<6) 
/* sync=1 async=0 */
#define DMC_OTHERS_SYNCMODE     (1<<7)  /* sync mode request to ARM */
#define DMC_OTHERS_SYNCVICPORT  (1<<5)  /* Nice: undocument bits */

#define CLK_DIV_VAL	((Startup_PCLKdiv<<12)|(Startup_HCLKx2div<<9)|(Startup_HCLKdiv<<8)|(Startup_MPLLdiv<<4)|Startup_APLLdiv<<0)
#define APLL_VAL	set_pll(APLL_MDIV, APLL_PDIV, APLL_SDIV)
#define MPLL_VAL	set_pll(MPLL_MDIV, MPLL_PDIV, MPLL_SDIV)

/* These are the fields for the DMC CFG register */
/* device column pins */
#define CFG_COL_11		(0)
#define CFG_COL_12		(1)
#define CFG_COL_13		(2)
#define CFG_COL_14		(3)

/* device row pins */
#define CFG_ROW_8		(0)
#define CFG_ROW_9		(1)
#define CFG_ROW_10		(2)
#define CFG_ROW_11		(3)
#define CFG_ROW_12		(4)

/* CFG burst length */
#define CFG_BL_4		(0x2)
#define CFG_BL_8		(0x3)

/* These are the fields for the DMC CFG2 register */
#define CFG2_RD_DELAY_SDR	(0x0 << 11)
#define CFG2_RD_DELAY_LPDDR	(0x1 << 11)
#define CFG2_RD_DELAY_DDR	(0x2 << 11)

#define CFG2_TYPE_SDR		(0x0 << 8 )
#define CFG2_TYPE_DDR		(0x1 << 8 )
#define CFG2_TYPE_LPDDR		(0x3 << 8 )

#define CFG2_WIDTH_16		(0x0 << 6 )
#define CFG2_WIDTH_32		(0x1 << 6 )

/* common JEDEC commands */
#define CMD_PRE_CHARGE		(0x0 << 18)
#define CMD_AUTO		(0x1 << 18)
#define CMD_MODE		(0x2 << 18)  /* aka MR  */
#define CMD_EXTMODE		(0x3 << 18)  /* aka EMR */

/* common (?) RAM command states */
#define MEMC_CMD_GO		(0)
#define MEMC_CMD_SLEEP		(1)
#define MEMC_CMD_WAKEUP		(2)
#define MEMC_CMD_PAUSE		(3)
#define MEMC_CMD_CONFIG		(4)


#if S3C6410_POP_A

#define DMC1_MEM_CFG		0x00210011	/* Supports one CKE control, Chip1, Burst4, Row/Column bit */
#define DMC1_MEM_CFG2		0xB41
#define DMC1_CHIP0_CFG		0x150FC
#define DMC1_CHIP1_CFG		0x154FC

/* Memory Parameters */
/* DDR Parameters */
#define RAM_tREFRESH		5865		/* ns */
#define RAM_tRAS		50		/* ns (min: 45ns)*/
#define RAM_tRC 		68		/* ns (min: 67.5ns)*/
#define RAM_tRCD		23		/* ns (min: 22.5ns)*/
#define RAM_tRFC		133		/* ns (min: 80ns)*/
#define RAM_tRP 		23		/* ns (min: 22.5ns)*/
#define RAM_tRRD		20		/* ns (min: 15ns)*/
#define RAM_tWR 		20		/* ns (min: 15ns)*/
#define RAM_tXSR		125		/* ns (min: 120ns)*/

#define RAM_clk_tCAS		3		/* CAS Latency 3 */

#else
#if 0
#include smartq_ram.h
#endif
#endif

#define RAM_clk_tREFRESH	nSecToClk(RAM_tREFRESH)	/* clk */
#define RAM_clk_tRAS		nSecToClk(RAM_tRAS)	/* clk */
#define RAM_clk_tRC		nSecToClk(RAM_tRC)	/* clk */
#define RAM_clk_tRCD		nSecToClk(RAM_tRCD)	/* clk */
#define RAM_clk_tRFC		nSecToClk(RAM_tRFC)	/* clk */
#define RAM_clk_tRP 		nSecToClk(RAM_tRP)	/* clk */
#define RAM_clk_tRRD		nSecToClk(RAM_tRRD)	/* clk */
#define RAM_clk_tWR 		nSecToClk(RAM_tWR)	/* clk */
#define RAM_clk_tXSR		nSecToClk(RAM_tXSR)	/* clk */


/*
 * mDDR memory configuration
 */
#define DMC_DDR_BA_EMRS 	2
#define DMC_DDR_CAS_LATENCY	(RAM_clk_tCAS << 1)	//  Set Cas Latency
#define RAM_clk_tDQSS	1		// Min 0.75 ~ 1.25
#define RAM_clk_tMRD		2		//Min 2 tck

#define DMC_DDR_schedule_RCD	((RAM_clk_tRCD - 3) << 3)
#define DMC_DDR_RCD		(DMC_DDR_schedule_RCD | RAM_clk_tRCD)

#define DMC_DDR_schedule_RFC	((RAM_clk_tRFC - 3) << 5)
#define DMC_DDR_RFC		(DMC_DDR_schedule_RFC | RAM_clk_tRFC)

#define DMC_DDR_schedule_RP	((RAM_clk_tRP - 3) << 3)
#define DMC_DDR_RP		(DMC_DDR_schedule_RP | RAM_clk_tRP)
#define RAM_clk_tWTR		2
#define RAM_clk_tXP		2	//1tck + tIS(1.5ns)
#define RAM_clk_tESR		RAM_clk_tXSR


.globl _start, processor_id, is_jtag
#if 0 // JET_START
_start:	b       start_code
#else
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

l_120:	ldr	r0, [pc, #656]	// 0x3b8	// load OneNAND SFR adr (0x70100000) in r0
	ldr	r1, [pc, #656]	// 0x3bc	// 0x000040e0
	str	r1, [r0]
	ldr	r0, [pc, #652]	// 0x3c0	// =0x70100140
	mov	r1, #1
	str	r1, [r0]
	mov	r6, #4
	ldr	r7, [pc, #640]	// 0x3c4	// =0x51400000
	mov	r4, #0
	mov	r3, #1
l_148:	mov	r2, #553648128	// 0x21000000
	add	r2, r2, r4, lsl #12
	mov	r8, #128	// 0x80
	add	r2, r2, r3, lsl #6
l_158:	ldm	r2, {r9, sl, fp, ip}		// MEMCOPY ????
	stmia	r7!, {r9, sl, fp, ip}		// MEMCOPY ????
	subs	r8, r8, #1
	bne	l_158		// 0x158
	cmp	r3, #0
	bne	l_1a0		// 0x1a0
	ldr	r9, [r2]
	lsl	r9, r9, #16
	lsr	r9, r9, #16
	ldr	r2, [pc, #496]	// 0x374
	cmp	r9, r2
	beq	l_1a0		// 0x1a0
	add	r6, r6, #1
	sub	r7, r7, #2048	// 0x800
	ldr	r0, [pc, #544]	// 0x3b8	// load OneNAND SFR adr (0x70100000) in r0
	mov	r1, #1024	// 0x400
	str	r1, [r0, #80]	// 0x50
	b	l_1b8		// 0x1b8
l_1a0:	ldr	r0, [pc, #528]	// 0x3b8
	mov	r1, #1024	// 0x400
	str	r1, [r0, #80]	// 0x50
	add	r3, r3, #1
	cmp	r3, #64	// 0x40
	blt	l_148		// 0x148
l_1b8:	add	r4, r4, #1
	mov	r3, #0
	cmp	r4, r6
	blt	l_148		// 0x148
	ldr	r0, [pc, #500]	// 0x3c4	// r0 = 0x51400000
//	mov	pc, r0				// jump to 0x51400000
	b	_waitstart
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
_3b8:	.long	0x70100000
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


#endif
_keypad_base:
	.long	0x7E00A000
_gpio_base:
	.long	0x7F008000
_const_fff:
	.long	0xfff
//_const_111:
//	.long	0x111
//_keypad_row_const:
//	.long	0x33333333

/* if we are injected by JTAG, the script sets _istag content to nonzero */
is_jtag:
	.word	0

/* it's at a fixed address (+0x8) so we can breakpoint it in the JTAG script
 * we need to go through this hassle because before this moment, SDRAM is not
 * working so we can't prep it from JTAG
 */

_start_armboot:
	.word 	start_qi

_TEXT_BASE:
	.word	TEXT_BASE

_waitstart:
	ldr	r0, _gpio_base

//	ldr	r1, _keypad_row_const
//	str	r1, [r0, #0x804]		// set GPKCON1 to keypad row input
	
//	ldr	r1, [r0, #0x80C]		// load from GPKPUD
//	mov	r1, r1, lsl#2
//	mov	r1, r1, lsr#2
//	mov	r0, #0x2
//	orr	r1, r1, r0, lsl#30		//
//	str	r1, [r0, #0x80C]		// store to GPKPUD

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

SetupGPIO_L:
	ldr	r1, _gpio_base
//	mov	r2, #0
SetupGPIO_L_R0_b0is1:
	ldr     r0, [r1,#0x81C] // r1 = GPLPUD (Port L Pull-up/down Register)
	bic     r0, r0, #3
	orr     r0, r0, #2
	str     r0, [r1,#0x81C] // set bit 1 (#2) and clear bit 0 of GPLPUP
	                        // ==> pull-up enabled for GPL0
	ldr     r0, [r1,#0x810] // GPLCON0
	bic     r0, r0, #0xF
	str     r0, [r1,#0x810] // clear lower 4 bits of GPLCON0 (Port L Configuration Register)
	                        // ==> GPL0 set as input
SetupGPIO_L_R0_b1is0:
	ldr     r0, [r1,#0x818] // GPLDAT
	bic     r0, r0, #6
//	orr     r0, r0, r2
	str     r0, [r1,#0x818] // clear bits 2:1 (#2+#4) of GPLDAT
	                        // ==> Output 0 on GPL2, GPL1
	ldr     r0, [r1,#0x810] // GPLCON0
	bic     r0, r0, #0xFF0
	orr     r0, r0, #0x110
	str     r0, [r1,#0x810] // Set bits 7-4 of GPLCON0 to 0001

_key_scan:
	ldr	r0, _keypad_base		// store Keypad base register in r0
	ldr	r0, [r0,#0xC]			// Read from KEYIFROW
	and	r0, r0, #0xff			// mask out only lower 8 bits
	mov	r0, r0, lsr#0			// shift r0 to right
	and	r0, r0, #1			// mask out last bit 
	cmp	r0, #0x0			// r0 = 1 ?
//	beq	_endwait			// yes ==> no waiting
	bne	_endwait			// yes ==> no waiting

	mov	r0, #0x20000000			// approx 10 sec wait
//	mov	r0, #0x10000000			// approx 5 sec wait
_waitloop:
	subs	r0, r0, #1
	cmp	r0, #0
	bne	_waitloop
_endwait:

	ldr	r1, _gpio_base
	ldr     r0, [r1,#0x81C] // r0 = GPLPUD (Port L Pull-up/down Register)
	bic     r0, r0, #0x3F
	str     r0, [r1,#0x81C] // clear lower 6 bits of GPLPUP
	                        // ==> disable pull-up/down for GPL0, GPL1, GPL2
	ldr     r0, [r1,#0x818] // GPLDAT
	bic     r0, r0, #7
	str     r0, [r1,#0x818] // clear bit 1 (#2) of GPLDAT
	                        // ==> Output 0 on GPL1
	ldr     r0, [r1,#0x810] // GPLCON0
	ldr	r1, _const_fff
	bic     r0, r0, r1
	orr     r0, r0, #0x100
	orr     r0, r0, #0x11
	str     r0, [r1,#0x810] // Set bits 11-0 of GPLCON0 to 0001

	ldr	r0, _3c4	// 0x3c4	// r0 = 0x51400000
	mov	pc, r0				// jump to 0x51400000


_steppingstone_done:
	ldr	pc, _start_armboot

/*
 * These are defined in the board-specific linker script.
 */
.globl _bss_start
_bss_start:
	.word __bss_start

.globl _bss_end
_bss_end:
	.word _end

/*
 * we have a stack in steppingstone because we can want to run full memory
 * memory tests
 */

//	.fill   128
	.fill   0x400-0xC0-36
.globl _ss_stack
_ss_stack:

start_code:
#if 0
#ifdef S3C6410_POP_A
	/*
	 * set the cpu to SVC32 mode
	 */
	mrs	r0,cpsr
	bic	r0,r0,#0x1f
	orr	r0,r0,#0xd3
	msr	cpsr,r0
#endif 

	/*
	 * flush v4 I/D caches
	 */
	mov	r0, #0
	mcr	p15, 0, r0, c7, c7, 0	/* flush v3/v4 cache */
	mcr	p15, 0, r0, c8, c7, 0	/* flush v4 TLB */

//#if 0
	/*
	 * disable MMU stuff and caches
	 */
	mrc	p15, 0, r0, c1, c0, 0
	bic	r0, r0, #0x00002300	@ clear bits 13, 9:8 (--V- --RS)
	bic	r0, r0, #0x00000087	@ clear bits 7, 2:0 (B--- -CAM)
	orr	r0, r0, #0x00000002	@ set bit 2 (A) Align
	orr	r0, r0, #0x00005000	@ Enable I and D-Cache
	mcr	p15, 0, r0, c1, c0, 0

	/* Peri port setup */
	ldr	r0, =0x70000000
	orr	r0, r0, #0x13
	mcr	p15,0,r0,c15,c2,4       @ 256M(0x70000000-0x7fffffff)

	/* SDRAM */

	ldr	r0, =ELFIN_MEM_SYS_CFG			@Memory sussystem address 0x7e00f120
	mov	r1, #0xd				@ Xm0CSn2 = NFCON CS0, Xm0CSn3 = NFCON CS1
	str	r1, [r0]

	ldr	r0, =ELFIN_DMC1_BASE			@DMC1 base address 0x7e001000

	ldr	r1, =MEMC_CMD_CONFIG
	str	r1, [r0, #INDEX_DMC_MEMC_CMD]

	ldr	r1, =RAM_clk_tREFRESH
	str	r1, [r0, #INDEX_DMC_REFRESH_PRD]

	ldr	r1, =DMC_DDR_CAS_LATENCY
	str	r1, [r0, #INDEX_DMC_CAS_LATENCY]

	ldr	r1, =RAM_clk_tDQSS
	str	r1, [r0, #INDEX_DMC_T_DQSS]

	ldr	r1, =RAM_clk_tMRD
	str	r1, [r0, #INDEX_DMC_T_MRD]

	ldr	r1, =RAM_clk_tRAS
	str	r1, [r0, #INDEX_DMC_T_RAS]

	ldr	r1, =RAM_clk_tRC
	str	r1, [r0, #INDEX_DMC_T_RC]

	ldr	r1, =DMC_DDR_RCD
	str	r1, [r0, #INDEX_DMC_T_RCD]

	ldr	r1, =DMC_DDR_RFC
	str	r1, [r0, #INDEX_DMC_T_RFC]

	ldr	r1, =DMC_DDR_RP
	str	r1, [r0, #INDEX_DMC_T_RP]

	ldr	r1, =RAM_clk_tRRD
	str	r1, [r0, #INDEX_DMC_T_RRD]

	ldr	r1, =RAM_clk_tWR
	str	r1, [r0, #INDEX_DMC_T_WR]

	ldr	r1, =RAM_clk_tWTR
	str	r1, [r0, #INDEX_DMC_T_WTR]

	ldr	r1, =RAM_clk_tXP
	str	r1, [r0, #INDEX_DMC_T_XP]

	ldr	r1, =RAM_clk_tXSR
	str	r1, [r0, #INDEX_DMC_T_XSR]

	ldr	r1, =RAM_clk_tESR
	str	r1, [r0, #INDEX_DMC_T_ESR]

	ldr	r1, =DMC1_MEM_CFG
	str	r1, [r0, #INDEX_DMC_MEMORY_CFG]

	ldr	r1, =DMC1_MEM_CFG2
	str	r1, [r0, #INDEX_DMC_MEMORY_CFG2]

	ldr	r1, =DMC1_CHIP0_CFG
	str	r1, [r0, #INDEX_DMC_CHIP_0_CFG]

	ldr	r1, =DMC_DDR_32_CFG
	str	r1, [r0, #INDEX_DMC_USER_CONFIG]

	@DMC0 DDR Chip 0 configuration direct command reg
	ldr	r1, =DMC_NOP0
	str	r1, [r0, #INDEX_DMC_DIRECT_CMD]

	@Precharge All
	ldr	r1, =DMC_PA0
	str	r1, [r0, #INDEX_DMC_DIRECT_CMD]

	@Auto Refresh	2 times
	ldr	r1, =DMC_AR0
	str	r1, [r0, #INDEX_DMC_DIRECT_CMD]
	str	r1, [r0, #INDEX_DMC_DIRECT_CMD]R1

	@MRS
	ldr	r1, =DMC_mDDR_EMR0
	str	r1, [r0, #INDEX_DMC_DIRECT_CMD]

	@Mode Reg
	ldr	r1, =DRAM_MODE
	str	r1, [r0, #INDEX_DMC_DIRECT_CMD]

#if S3C6410_POP_A
	ldr	r1, =DMC1_CHIP1_CFG
	str	r1, [r0, #INDEX_DMC_CHIP_1_CFG]

	@DMC0 DDR Chip 0 configuration direct command reg
	ldr	r1, =DMC_NOP1
	str	r1, [r0, #INDEX_DMC_DIRECT_CMD]

	@Precharge All
	ldr	r1, =DMC_PA1
	str	r1, [r0, #INDEX_DMC_DIRECT_CMD]

	@Auto Refresh	2 time
	ldr	r1, =DMC_AR1
	str	r1, [r0, #INDEX_DMC_DIRECT_CMD]
	str	r1, [r0, #INDEX_DMC_DIRECT_CMD]

	@MRS
	ldr	r1, =DMC_mDDR_EMR1
	str	r1, [r0, #INDEX_DMC_DIRECT_CMD]

	@Mode Reg
	ldr	r1, =DMC_mDDR_MR1
	str	r1, [r0, #INDEX_DMC_DIRECT_CMD]
#endif

	@Enable DMC1
	ldr	r1, =MEMC_CMD_GO
	str	r1, [r0, #INDEX_DMC_MEMC_CMD]

1:
	ldr	r1, [r0, #INDEX_DMC_MEMC_STATUS]
	mov	r2, #0x3
	and	r1, r1, r2
	cmp	r1, #0x1
	bne	1b
	nop

	ldr	r0, =ELFIN_CLOCK_POWER_BASE	@0x7e00f000

#ifdef  CONFIG_SYNC_MODE
	ldr	r1, [r0, #OTHERS_OFFSET]
	mov	r2, #DMC_OTHERS_SYNCMUXSEL
	orr	r1, r1, r2
	str	r1, [r0, #OTHERS_OFFSET]

	nop
	nop
	nop
	nop
	nop

	mov	r2, #DMC_OTHERS_SYNCMODE
	orr	r1, r1, r2
	str	r1, [r0, #OTHERS_OFFSET]

check_sync_ack:
	ldr	r1, [r0, #OTHERS_OFFSET]
	mov	r2, #DMC_OTHERS_SYNCACK
	and	r1, r1, r2
	cmp	r1, #DMC_OTHERS_SYNCACK
	bne	check_sync_ack

#else /* ASYNC mode */

        nop
        nop
        nop
        nop
        nop

        ldr     r1, [r0, #OTHERS_OFFSET]
        bic     r1, r1, #(DMC_OTHERS_SYNCMODE|DMC_OTHERS_SYNCMUXSEL)
        orr     r1, r1, #DMC_OTHERS_SYNCMUXSEL
        str     r1, [r0, #OTHERS_OFFSET]

wait_for_async:
        ldr     r1, [r0, #OTHERS_OFFSET]
        and     r1, r1, #DMC_OTHERS_SYNCACK
        cmp     r1, #0x0
        bne     wait_for_async

        ldr     r1, [r0, #OTHERS_OFFSET]
        bic     r1, r1, #DMC_OTHERS_SYNCMUXSEL
        str     r1, [r0, #OTHERS_OFFSET]
#endif


	mov	r1, #0xff00
	orr	r1, r1, #0xff
	str	r1, [r0, #APLL_LOCK_OFFSET]
	str	r1, [r0, #MPLL_LOCK_OFFSET]
	str	r1, [r0, #EPLL_LOCK_OFFSET]
/* CLKUART(=66.5Mhz) = CLKUART_input(532/2=266Mhz) / (UART_RATIO(3)+1) */
/* CLKUART(=50Mhz) = CLKUART_input(400/2=200Mhz) / (UART_RATIO(3)+1) */
/* Now, When you use UART CLK SRC by EXT_UCLK1, We support 532MHz & 400MHz value */

	ldr   	r1, [r0, #CLK_DIV2_OFFSET]
	bic	r1, r1, #0x70000
	orr	r1, r1, #0x30000
	str	r1, [r0, #CLK_DIV2_OFFSET]


	ldr   	r1, [r0, #CLK_DIV0_OFFSET]	/*Set Clock Divider*/
	bic	r1, r1, #0x30000
	bic	r1, r1, #0xff00
	bic	r1, r1, #0xff
	ldr	r2, =CLK_DIV_VAL
	orr	r1, r1, r2
	str	r1, [r0, #CLK_DIV0_OFFSET]

	ldr	r1, =APLL_VAL
	str	r1, [r0, #APLL_CON_OFFSET]
	ldr	r1, =MPLL_VAL
	str	r1, [r0, #MPLL_CON_OFFSET]

	ldr	r1, =0x80200203			/* FOUT of EPLL is 96MHz */
	str	r1, [r0, #EPLL_CON0_OFFSET]
	ldr	r1, =0x0
	str	r1, [r0, #EPLL_CON1_OFFSET]

	ldr	r1, [r0, #CLK_SRC_OFFSET]	/* APLL, MPLL, EPLL select to Fout */

	ldr	r2, =0x2007
	orr	r1, r1, r2

	str	r1, [r0, #CLK_SRC_OFFSET]

	/* wait at least 200us to stablize all clock */
	mov	r1, #0x10000
3:	subs	r1, r1, #1
	bne	3b

#ifdef CONFIG_SYNC_MODE                    /* Synchronization for VIC port */

	ldr	r1, [r0, #OTHERS_OFFSET]
	orr	r1, r1, #DMC_OTHERS_SYNCVICPORT
	str	r1, [r0, #OTHERS_OFFSET]
#else
        ldr     r1, [r0, #OTHERS_OFFSET]
        bic     r1, r1, #DMC_OTHERS_SYNCVICPORT
        str     r1, [r0, #OTHERS_OFFSET]

#endif


	/* set GPIO to enable UART */
	@ GPIO setting for UART
	ldr	r0, =ELFIN_GPIO_BASE
	ldr	r1, =0x2222
#ifdef SMARTQ
	str	r1, [r0, #GPACON_OFFSET]
	ldr	r0, =ELFIN_UART_BASE + ELFIN_UART0_OFFSET	@0x7F005c00 uart 0
#else
	str	r1, [r0, #GPBCON_OFFSET]
	ldr	r0, =ELFIN_UART_BASE + ELFIN_UART3_OFFSET	@0x7F005c00 uart 3
#endif
	mov	r1, #0x0
	str	r1, [r0, #UFCON_OFFSET]
	str	r1, [r0, #UMCON_OFFSET]

	mov	r1, #0x3                	@was 0.
	str	r1, [r0, #ULCON_OFFSET]

	ldr	r1, =0xe45			/* UARTCLK SRC = 11 => EXT_UCLK1*/

	str	r1, [r0, #UCON_OFFSET]

	ldr	r1, =0x22
	str	r1, [r0, #UBRDIV_OFFSET]

	ldr	r1, =0x1FFF
	str	r1, [r0, #UDIVSLOT_OFFSET]

	/* resuming? */

		ldr     r0, =(ELFIN_CLOCK_POWER_BASE+RST_STAT_OFFSET)
		ldr     r1, [r0]
		bic     r1, r1, #0xfffffff7
		cmp     r1, #0x8
		beq     wakeup_reset

	/* no, cold boot */

	ldr	r0, =ELFIN_UART_BASE + ELFIN_UART3_OFFSET
	ldr	r1, =0x55
	str	r1, [r0, #UTXH_OFFSET]		@'U'
								/* >> CFG_VIDEO_LOGO_MAX_SIZE */
#define CFG_GBL_DATA_SIZE		128			/* size in bytes reserved for initial data */


	ldr	r0, _TEXT_BASE		/* upper 128 KiB: relocated uboot   */
	sub	r0, r0, #CFG_GBL_DATA_SIZE 	/* bdinfo                        */
	sub	sp, r0, #12		/* leave 3 words for abort-stack    */
clear_bss:
	ldr	r0, _bss_start		/* find start of bss segment        */
	ldr	r1, _bss_end		/* stop here                        */
	mov 	r2, #0x00000000	/* clear                            */

clbss_l:
	str	r2, [r0]			/* clear loop...                    */
	add	r0, r0, #4
	cmp	r0, r1
	ble	clbss_l

	b	_steppingstone_done

	/* resume */

wakeup_reset:

	ldr	r0, =ELFIN_UART_BASE + ELFIN_UART3_OFFSET
	ldr	r1, =0x4b4b4b4b
	str	r1, [r0, #UTXH_OFFSET]

	/*Clear wakeup status register*/
	ldr	r0, =(ELFIN_CLOCK_POWER_BASE+WAKEUP_STAT_OFFSET)
	ldr	r1, [r0]
	str	r1, [r0]

#if 0
		/*LED test*/
		ldr     r0, =ELFIN_GPIO_BASE
		ldr     r1, =0x3000
		str     r1, [r0, #GPNDAT_OFFSET]
#endif

	/*Load return address and jump to kernel*/
	ldr	r0, =(ELFIN_CLOCK_POWER_BASE+INF_REG0_OFFSET)
	ldr	r1, [r0]	/* r1 = physical address of s3c6400_cpu_resume function*/
	mov	pc, r1		/*Jump to kernel (sleep-s3c6400.S)*/
	nop
	nop

4:
	b 4b
#endif
