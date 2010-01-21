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
_0:	b	0x20
_4:	b	0x4
_8:	b	0x8
_c:	b	0xc
_10:	b	0x10
_14:	b	0x14
_18:	b	0x18
_1c:	b	0x1c
_20:	mov	r0, #0
_24:	mcr	15, 0, r0, cr7, cr7, 0	/* flush v3/v4 cache */
//	mcr	p15, 0, r0, c7, c7, 0	/* flush v3/v4 cache */
//	mcr	p15, 0, r0, c8, c7, 0	/* flush v4 TLB */
_28:	mrc	15, 0, r0, cr1, cr0, 0
_2c:	orr	r0, r0, #4096	// 0x1000
_30:	mcr	15, 0, r0, cr1, cr0, 0
_34:	ldr	r0, [pc, #800]	// 0x35c
_38:	mcr	15, 0, r0, cr15, cr2, 4
_3c:	ldr	r0, [pc, #796]	// 0x360
_40:	mov	r1, #0
_44:	str	r1, [r0]
_48:	ldr	r0, [pc, #788]	// 0x364
_4c:	mvn	r1, #0
_50:	str	r1, [r0]
_54:	ldr	r0, [pc, #780]	// 0x368
_58:	mvn	r1, #0
_5c:	str	r1, [r0]
_60:	ldr	r0, [pc, #772]	// 0x36c
_64:	ldr	r1, [pc, #772]	// 0x370
_68:	str	r1, [r0]
_6c:	bl	0x1d8
_70:	ldr	r1, [pc, #764]	// 0x374
_74:	ldr	r2, [pc, #764]	// 0x378
_78:	ldr	r0, [pc, #764]	// 0x37c
_7c:	str	r1, [r0]
_80:	str	r1, [r0, #4]
_84:	str	r2, [r0, #8]
_88:	ldr	r0, [pc, #752]	// 0x380
_8c:	ldr	r1, [r0]
_90:	bic	r1, r1, #196608	// 0x30000
_94:	bic	r1, r1, #65280	// 0xff00
_98:	bic	r1, r1, #255	// 0xff
_9c:	ldr	r2, [pc, #736]	// 0x384
_a0:	orr	r1, r1, r2
_a4:	str	r1, [r0]
_a8:	ldr	r0, [pc, #728]	// 0x388
_ac:	ldr	r1, [pc, #728]  // 0x38c
_b0:	str	r1, [r0]
_b4:	ldr	r0, [pc, #724]	// 0x390
_b8:	ldr	r1, [pc, #724]	// 0x394
_bc:	str	r1, [r0]
_c0:	ldr	r0, [pc, #720]	// 0x398
_c4:	ldr	r1, [pc, #720]	// 0x39c
_c8:	str	r1, [r0]
_cc:	ldr	r0, [pc, #716]	// 0x3a0
_d0:	ldr	r1, [pc, #716]	// 0x3a4
_d4:	str	r1, [r0]
_d8:	ldr	r0, [pc, #712]	// 0x3a8
_dc:	ldr	r1, [r0]
_e0:	orr	r1, r1, #7
_e4:	str	r1, [r0]
_e8:	ldr	r0, [pc, #700]	// 0x3ac
_ec:	mov	r1, #0
_f0:	bic	r1, r1, #128	// 0x80
_f4:	str	r1, [r0]
_f8:	bl	0x21c
_fc:	ldr	r0, [pc, #684]	// 0x3b0
_100:	ldr	r1, [r0]
_104:	and	r1, r1, #72	// 0x48
_108:	and	r2, r1, #72	// 0x48
_10c:	cmp	r2, #0
_110:	beq	0x120
_114:	ldr	r0, [pc, #664]	// 0x3b4
_118:	ldr	r1, [r0]
_11c:	mov	pc, r1
_120:	ldr	r0, [pc, #656]	// 0x3b8
_124:	ldr	r1, [pc, #656]	// 0x3bc
_128:	str	r1, [r0]
_12c:	ldr	r0, [pc, #652]	// 0x3c0
_130:	mov	r1, #1
_134:	str	r1, [r0]
_138:	mov	r6, #4
_13c:	ldr	r7, [pc, #640]	// 0x3c4
_140:	mov	r4, #0
_144:	mov	r3, #1
_148:	mov	r2, #553648128	// 0x21000000
_14c:	add	r2, r2, r4, lsl #12
_150:	mov	r8, #128	// 0x80
_154:	add	r2, r2, r3, lsl #6
_158:	ldm	r2, {r9, sl, fp, ip}
_15c:	stmia	r7!, {r9, sl, fp, ip}
_160:	subs	r8, r8, #1
_164:	bne	0x158
_168:	cmp	r3, #0
_16c:	bne	0x1a0
_170:	ldr	r9, [r2]
_174:	lsl	r9, r9, #16
_178:	lsr	r9, r9, #16
_17c:	ldr	r2, [pc, #496]	// 0x374
_180:	cmp	r9, r2
_184:	beq	0x1a0
_188:	add	r6, r6, #1
_18c:	sub	r7, r7, #2048	// 0x800
_190:	ldr	r0, [pc, #544]	// 0x3b8
_194:	mov	r1, #1024	// 0x400
_198:	str	r1, [r0, #80]	// 0x50
_19c:	b	0x1b8
_1a0:	ldr	r0, [pc, #528]	// 0x3b8
_1a4:	mov	r1, #1024	// 0x400
_1a8:	str	r1, [r0, #80]	// 0x50
_1ac:	add	r3, r3, #1
_1b0:	cmp	r3, #64	// 0x40
_1b4:	blt	0x148
_1b8:	add	r4, r4, #1
_1bc:	mov	r3, #0
_1c0:	cmp	r4, r6
_1c4:	blt	0x148
_1c8:	ldr	r0, [pc, #500]	// 0x3c4
_1cc:	mov	pc, r0
_1d0:	bl	0x1d4
_1d4:	b	0x1d4
_1d8:	ldr	r0, [pc, #488]	// 0x3c8
_1dc:	ldr	r1, [r0]
_1e0:	orr	r1, r1, #64	// 0x40
_1e4:	str	r1, [r0]
_1e8:	nop	{0}
_1ec:	nop	{0}
_1f0:	nop	{0}
_1f4:	nop	{0}
_1f8:	nop	{0}
_1fc:	ldr	r1, [r0]
_200:	orr	r1, r1, #128	// 0x80
_204:	str	r1, [r0]
_208:	ldr	r1, [r0]
_20c:	and	r1, r1, #3840	// 0xf00
_210:	cmp	r1, #3840	// 0xf00
_214:	bne	0x208
_218:	mov	pc, lr
_21c:	ldr	r0, [pc, #424]	// 0x3cc
_220:	mov	r1, #4
_224:	str	r1, [r0, #4]
_228:	mov	r1, #520	// 0x208
_22c:	str	r1, [r0, #16]
_230:	mov	r1, #6
_234:	str	r1, [r0, #20]
_238:	mov	r1, #1
_23c:	str	r1, [r0, #24]
_240:	mov	r1, #2
_244:	str	r1, [r0, #28]
_248:	mov	r1, #7
_24c:	str	r1, [r0, #32]
_250:	mov	r1, #9
_254:	str	r1, [r0, #36]	// 0x24
_258:	mov	r1, #3
_25c:	mov	r2, #0
_260:	orr	r1, r1, r2
_264:	str	r1, [r0, #40]	// 0x28
_268:	mov	r1, #17
_26c:	mov	r2, #448	// 0x1c0
_270:	orr	r1, r1, r2
_274:	str	r1, [r0, #44]	// 0x2c
_278:	mov	r1, #3
_27c:	mov	r2, #0
_280:	orr	r1, r1, r2
_284:	str	r1, [r0, #48]	// 0x30
_288:	mov	r1, #3
_28c:	str	r1, [r0, #52]	// 0x34
_290:	mov	r1, #3
_294:	str	r1, [r0, #56]	// 0x38
_298:	mov	r1, #2
_29c:	str	r1, [r0, #60]	// 0x3c
_2a0:	mov	r1, #2
_2a4:	str	r1, [r0, #64]	// 0x40
_2a8:	mov	r1, #17
_2ac:	str	r1, [r0, #68]	// 0x44
_2b0:	mov	r1, #17
_2b4:	str	r1, [r0, #72]	// 0x48
_2b8:	ldr	r1, [pc, #272]	// 0x3d0
_2bc:	str	r1, [r0, #12]
_2c0:	ldr	r1, [pc, #268]	// 0x3d4
_2c4:	str	r1, [r0, #76]	// 0x4c
_2c8:	ldr	r1, [pc, #264]	// 0x3d8
_2cc:	str	r1, [r0, #512]	// 0x200
_2d0:	ldr	r1, [pc, #260]	// 0x3dc
_2d4:	str	r1, [r0, #516]	// 0x204
_2d8:	mov	r1, #0
_2dc:	str	r1, [r0, #772]	// 0x304
_2e0:	mov	r1, #786432	// 0xc0000
_2e4:	str	r1, [r0, #8]
_2e8:	mov	r1, #0
_2ec:	str	r1, [r0, #8]
_2f0:	mov	r1, #262144	// 0x40000
_2f4:	str	r1, [r0, #8]
_2f8:	str	r1, [r0, #8]
_2fc:	mov	r1, #655360	// 0xa0000
_300:	str	r1, [r0, #8]
_304:	ldr	r1, [pc, #212]	// 0x3e0
_308:	str	r1, [r0, #8]
_30c:	mov	r1, #1835008	// 0x1c0000
_310:	str	r1, [r0, #8]
_314:	mov	r1, #1048576	// 0x100000
_318:	str	r1, [r0, #8]
_31c:	mov	r1, #1310720	// 0x140000
_320:	str	r1, [r0, #8]
_324:	str	r1, [r0, #8]
_328:	mov	r1, #1703936	// 0x1a0000
_32c:	str	r1, [r0, #8]
_330:	ldr	r1, [pc, #172]	// 0x3e4
_334:	str	r1, [r0, #8]
_338:	mov	r1, #0
_33c:	str	r1, [r0, #4]
_340:	ldr	r1, [r0]
_344:	mov	r2, #3
_348:	and	r1, r1, r2
_34c:	cmp	r1, #1
_350:	bne	0x340
_354:	nop	{0}
_358:	mov	pc, lr		// RET
_35c:	.long	0x70000013	// andvc	r0, r0, r3, lsl r0
_360:	.long	0x7e004000	// cdpvc	0, 0, cr4, cr0, cr0, 0
_364:	.long	0x71200014	// teqvc	r0, r4, lsl r0
_368:	.long	0x71300014	// teqvc	r0, r4, lsl r0
_36c:	.long	0x7f0081d4	// svcvc	0x000081d4
_370:	.long	0x55555555	// ldrbpl	r5, [r5, #-1365]	// 0x555
_374:	.long	0x0000ffff	// strdeq	pc, [r0], -pc
_378:	.long	0x00000e13	// andeq	r0, r0, r3, lsl lr
_37c:	.long	0x7e00f000	// cdpvc	0, 0, cr15, cr0, cr0, 0
_380:	.long	0x7e00f020	// cdpvc	0, 0, cr15, cr0, cr0, 1
_384:	.long	0x00007501	// andeq	r7, r0, r1, lsl #10
_388:	.long	0x7e00f00c	// cdpvc	0, 0, cr15, cr0, cr12, 0
_38c:	.long	0x81900301	// orrshi	r0, r0, r1, lsl #6
_390:	.long	0x7e00f010	// mcrvc	0, 0, pc, cr0, cr0, 0
_394:	.long	0x81840303	// orrhi	r0, r4, r3, lsl #6
_398:	.long	0x7e00f018	// mcrvc	0, 0, pc, cr0, cr8, 0
_39c:	.long	0x0000c49c	// muleq	r0, ip, r4
_3a0:	.long	0x7e00f014	// mcrvc	0, 0, pc, cr0, cr4, 0
_3a4:	.long	0x80200103	// eorhi	r0, r0, r3, lsl #2
_3a8:	.long	0x7e00f01c	// mcrvc	0, 0, pc, cr0, cr12, 0
_3ac:	.long	0x7e00f120	// mvfvcsp	f7, f0
_3b0:	.long	0x7e00f904	// cdpvc	9, 0, cr15, cr0, cr4, 0
_3b4:	.long	0x7e00fa08	// vmlavc.f32	s30, s0, s16
_3b8:	.long	0x70100000	// andsvc	r0, r0, r0
_3bc:	.long	0x000040e0	// andeq	r4, r0, r0, ror #1
_3c0:	.long	0x70100140	// andsvc	r0, r0, r0, asr #2
_3c4:	.long	0x51400000	// cmppl	r0, r0
_3c8:	.long	0x7e00f900	// cdpvc	9, 0, cr15, cr0, cr0, 0
_3cc:	.long	0x7e001000	// cdpvc	0, 0, cr1, cr0, cr0, 0
_3d0:	.long	0x40224019	// eormi	r4, r2, r9, lsl r0
_3d4:	.long	0x00000b41	// andeq	r0, r0, r1, asr #22
_3d8:	.long	0x000150f8	// strdeq	r5, [r1], -r8
_3dc:	.long	0x000158f8	// strdeq	r5, [r1], -r8
_3e0:	.long	0x00080034	// andeq	r0, r8, r4, lsr r0
_3e4:	.long	0x00180034	// andseq	r0, r8, r4, lsr r0
#endif

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
	.fill   0x800-0x400-0x48+72
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
	str	r1, [r0, #INDEX_DMC_DIRECT_CMD]

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
