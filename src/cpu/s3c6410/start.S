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

//_start:	b       start_code
_start:
loc_0:					// CODE XREF: ROM:00040418j
		B	loc_20		// Clear	R0
// ---------------------------------------------------------------------------

loc_4:					// CODE XREF: ROM:loc_4j
		B	loc_4
// ---------------------------------------------------------------------------

loc_8:					// CODE XREF: ROM:loc_8j
		B	loc_8
// ---------------------------------------------------------------------------

loc_C:					// CODE XREF: ROM:loc_Cj
		B	loc_C
// ---------------------------------------------------------------------------

loc_10:					// CODE XREF: ROM:loc_10j
		B	loc_10
// ---------------------------------------------------------------------------

loc_14:					// CODE XREF: ROM:loc_14j
		B	loc_14
// ---------------------------------------------------------------------------

loc_18:					// CODE XREF: ROM:loc_18j
		B	loc_18
// ---------------------------------------------------------------------------

loc_1C:					// CODE XREF: ROM:loc_1Cj
		B	loc_1C
// ---------------------------------------------------------------------------

loc_20:					// CODE XREF: ROM:loc_0j
					// DATA XREF: ROM:off_3F308o
		MOV	R0, #0		// Clear	R0
		MCR	p15, 0,	R0,c7,c7

loc_28:					// DATA XREF: ROM:off_3F304o
		MRC	p15, 0,	R0,c1,c0

loc_2C:					// DATA XREF: ROM:off_3F300o
		ORR	R0, R0,	#0x1000
		MCR	p15, 0,	R0,c1,c0
		LDR	R0, =0x70000013	// R0 = SROM Bank control register adress
		MCR	p15, 0,	R0,c15,c2, 4
		LDR	R0, =0x7E004000	// R0 = Watchdog	timer control register adress
		MOV	R1, #0
		STR	R1, [R0]	// clear	Watchdog timer control register
		LDR	R0, =0x71200014
//		MOVL	R1, 0xFFFFFFFF
		LDR	R1, =0xFFFFFFFF
		STR	R1, [R0]
		LDR	R0, =0x71300014
//		MOVL	R1, 0xFFFFFFFF
		LDR	R1, =0xFFFFFFFF
		STR	R1, [R0]
		LDR	R0, =0x7F0081D4
		LDR	R1, =0x55555555
		STR	R1, [R0]
		BL	sub_1D8
//		LDR	R1, =(loc_FFFC+3)
		LDR	R1, =(0xFFFC+3)
//		LDR	R2, =(loc_E10+3)
		LDR	R2, =(0xE10+3)
		LDR	R0, =0x7E00F000
		STR	R1, [R0]
		STR	R1, [R0,#4]
		STR	R2, [R0,#8]
		LDR	R0, =0x7E00F020
		LDR	R1, [R0]
//		BIC	R1, R1,	#loc_30000
		BIC	R1, R1,	#0x30000
		BIC	R1, R1,	#0xFF00
		BIC	R1, R1,	#0xFF
//		LDR	R2, =(loc_7500+1)
		LDR	R2, =(0x7500+1)
		ORR	R1, R1,	R2
		STR	R1, [R0]
		LDR	R0, =0x7E00F00C
		LDR	R1, =0x81900301
		STR	R1, [R0]
		LDR	R0, =0x7E00F010
		LDR	R1, =0x81840303
		STR	R1, [R0]
		LDR	R0, =0x7E00F018
//		LDR	R1, =loc_C49C
		LDR	R1, =0xC49C
		STR	R1, [R0]
		LDR	R0, =0x7E00F014
		LDR	R1, =0x80200103
		STR	R1, [R0]
		LDR	R0, =0x7E00F01C
		LDR	R1, [R0]
		ORR	R1, R1,	#7
		STR	R1, [R0]
		LDR	R0, =0x7E00F120
		MOV	R1, #0
		BIC	R1, R1,	#0x80
		STR	R1, [R0]
		BL	sub_21C		// DRAM CONTROLLER INIT
					// load DRAM CONTROLLER STATUS REGISTER base adress in R0
		LDR	R0, =0x7E00F904	// RST_STAT

loc_100:					// DATA XREF: ROM:off_1AE3Co
					// ROM:off_C580o
		LDR	R1, [R0]	// Load RESET STATUS REGISTER content to	R1
		AND	R1, R1,	#0x48
		AND	R2, R1,	#0x48

loc_10C:					// DATA XREF: ROM:off_99E8o
		CMP	R2, #0
		BEQ	loc_120
		LDR	R0, =0x7E00FA08

loc_118:					// DATA XREF: ROM:off_389B8o
					// ROM:off_389D4o
		LDR	R1, [R0]
		MOV	PC, R1
// ---------------------------------------------------------------------------

loc_120:					// CODE XREF: ROM:00000110j
					// DATA XREF: ROM:off_CD24o
		LDR	R0, =0x70100000
//		LDR	R1, =loc_40E0
		LDR	R1, =0x40E0

loc_128:					// DATA XREF: ROM:off_D44Co
		STR	R1, [R0]
		LDR	R0, =0x70100140

loc_130:					// DATA XREF: ROM:off_30B04o
					// ROM:off_1AE44o
		MOV	R1, #1
		STR	R1, [R0]
		MOV	R6, #4

loc_13C:					// DATA XREF: ROM:off_133D0o
		LDR	R7, =0x51400000

loc_140:					// DATA XREF: ROM:off_A4CCo
		MOV	R4, #0

loc_144:					// DATA XREF: ROM:off_1B334o
		MOV	R3, #1

loc_148:					// CODE XREF: ROM:000001B4j
					// ROM:000001C4j
		MOV	R2, #0x21000000
		ADD	R2, R2,	R4,LSL#12

loc_150:					// DATA XREF: ROM:off_A4D0o
		MOV	R8, #0x80 // '€'

loc_154:					// DATA XREF: ROM:off_38A18o
		ADD	R2, R2,	R3,LSL#6

loc_158:					// CODE XREF: ROM:00000164j
		LDMIA	R2, {R9-R12}
		STMIA	R7!, {R9-R12}
		SUBS	R8, R8,	#1
		BNE	loc_158
		CMP	R3, #0

loc_16C:					// DATA XREF: ROM:off_38A64o
		BNE	loc_1A0

loc_170:					// DATA XREF: ROM:off_CD28o
		LDR	R9, [R2]
		MOV	R9, R9,LSL#16
		MOV	R9, R9,LSR#16
//		LDR	R2, =(loc_FFFC+3)
		LDR	R2, =(0xFFFC+3)
		CMP	R9, R2
		BEQ	loc_1A0
		ADD	R6, R6,	#1
		SUB	R7, R7,	#0x800
		LDR	R0, =0x70100000
		MOV	R1, #0x400

loc_198:					// DATA XREF: ROM:off_30DA8o
		STR	R1, [R0,#0x50]

loc_19C:					// DATA XREF: ROM:off_1AE38o
		B	loc_1B8
// ---------------------------------------------------------------------------

loc_1A0:					// CODE XREF: ROM:loc_16Cj
					// ROM:00000184j
		LDR	R0, =0x70100000
		MOV	R1, #0x400
		STR	R1, [R0,#0x50]

loc_1AC:					// DATA XREF: sub_14754:off_14854o
		ADD	R3, R3,	#1
		CMP	R3, #0x40 // '@'
		BLT	loc_148

loc_1B8:					// CODE XREF: ROM:loc_19Cj
		ADD	R4, R4,	#1
		MOV	R3, #0

loc_1C0:					// DATA XREF: ROM:off_A4D4o
		CMP	R4, R6
		BLT	loc_148
		LDR	R0, =0x51400000
		MOV	PC, R0
// ---------------------------------------------------------------------------

loc_1D0:					// DATA XREF: ROM:off_30DE0o
		BL	loc_1D4

loc_1D4:				// CODE XREF: ROM:loc_1D4j
		B	loc_1D4

// =============== S U B	R O U T	I N E =======================================


sub_1D8:					// CODE XREF: ROM:0000006Cp
					// DATA XREF: ROM:off_A4DCo
		LDR	R0, =0x7E00F900

loc_1DC:					// DATA XREF: ROM:off_186E8o
		LDR	R1, [R0]
		ORR	R1, R1,	#0x40
		STR	R1, [R0]
// loc_1E8

loc_1FC:					// DATA XREF: ROM:off_31D24o
		LDR	R1, [R0]

loc_200:					// DATA XREF: ROM:off_10190o
					// ROM:off_2DD20o
		ORR	R1, R1,	#0x80
		STR	R1, [R0]

loc_208:					// CODE XREF: sub_1D8+3Cj
		LDR	R1, [R0]
		AND	R1, R1,	#0xF00
		CMP	R1, #0xF00
		BNE	loc_208
		RET
// End of function sub_1D8


// =============== S U B	R O U T	I N E =======================================

// DRAM CONTROLLER INIT
// load DRAM CONTROLLER STATUS REGISTER base adress in R0

sub_21C:					// CODE XREF: ROM:000000F8p
		LDR	R0, =0x7E001000
		MOV	R1, #4
		STR	R1, [R0,#4]	// Store	#4 in P1MEMCCMD	(Config	Mode)
		MOV	R1, #0x208
		STR	R1, [R0,#0x10]	// Store	0x208 to REFRESH PERIOD	REGISTER (Refresh timing = 208 cycles)

loc_230:					// DATA XREF: ROM:off_A4E4o
		MOV	R1, #6
		STR	R1, [R0,#0x14]	// Store	#6 to CAS LATENCY REGISTER (reset value)
		MOV	R1, #1

loc_23C:					// DATA XREF: ROM:off_310A8o
		STR	R1, [R0,#0x18]	// Store	#1 to T_DQSS REGISTER (Reset Value)
		MOV	R1, #2
		STR	R1, [R0,#0x1C]	// Store	#2 to T_MRD REGISTER (Reset Value)
		MOV	R1, #7
		STR	R1, [R0,#0x20]	// Store	#7 to T_RAS REGISTER (Reset Value)
		MOV	R1, #9
		STR	R1, [R0,#0x24]	// Store	#9 to T_RC REGISTER (defines bank to bank delay	in clk cycles)

loc_258:					// DATA XREF: ROM:off_A4D8o
		MOV	R1, #3
		MOV	R2, #0
		ORR	R1, R1,	R2	// Load R1 with #3

loc_264:					// DATA XREF: ROM:off_310E0o
		STR	R1, [R0,#0x28]
		MOV	R1, #0x11
		MOV	R2, #0x1C0
		ORR	R1, R1,	R2
		STR	R1, [R0,#0x2C]

loc_278:					// DATA XREF: ROM:off_A4E8o
		MOV	R1, #3
		MOV	R2, #0
		ORR	R1, R1,	R2
		STR	R1, [R0,#0x30]
		MOV	R1, #3
		STR	R1, [R0,#0x34]

loc_290:					// DATA XREF: ROM:off_312B4o
		MOV	R1, #3
		STR	R1, [R0,#0x38]
		MOV	R1, #2
		STR	R1, [R0,#0x3C]
		MOV	R1, #2
		STR	R1, [R0,#0x40]
		MOV	R1, #0x11

loc_2AC:					// DATA XREF: ROM:off_A4ECo
		STR	R1, [R0,#0x44]
		MOV	R1, #0x11
		STR	R1, [R0,#0x48]
		LDR	R1, =0x40224019
		STR	R1, [R0,#0xC]
//		LDR	R1, =dword_B41	// Load 0x5CE28EE0 in R1
		LDR	R1, =0xB41	// Load 0x5CE28EE0 in R1

loc_2C4:					// DATA XREF: ROM:off_A4F0o
		STR	R1, [R0,#0x4C]	// Store	0x5CE28EE0 to MEMORY CONFIGURATION 2 REGISTER
//		LDR	R1, =loc_150F8
		LDR	R1, =0x150F8
		STR	R1, [R0,#0x200]
//		LDR	R1, =loc_150F8
		LDR	R1, =0x158F8
		STR	R1, [R0,#0x204]
		MOV	R1, #0

loc_2DC:					// DATA XREF: ROM:off_A4F4o
		STR	R1, [R0,#0x304]
		MOV	R1, #0xC0000
		STR	R1, [R0,#8]
		MOV	R1, #0

loc_2EC:					// DATA XREF: ROM:off_A4F8o
		STR	R1, [R0,#8]

loc_2F0:					// DATA XREF: ROM:off_A4FCo
//		MOV	R1, #loc_40000
		MOV	R1, #0x40000
		STR	R1, [R0,#8]
		STR	R1, [R0,#8]
		MOV	R1, #0xA0000
		STR	R1, [R0,#8]

loc_304:					// DATA XREF: ROM:off_46E4o
					// ROM:off_19A84o
		LDR	R1, =0x80034
		STR	R1, [R0,#8]
		MOV	R1, #0x1C0000
		STR	R1, [R0,#8]
		MOV	R1, #0x100000

loc_318:					// DATA XREF: ROM:off_A500o
		STR	R1, [R0,#8]

loc_31C:					// DATA XREF: ROM:off_186A0o
		MOV	R1, #0x140000
		STR	R1, [R0,#8]
		STR	R1, [R0,#8]
		MOV	R1, #0x1A0000
		STR	R1, [R0,#8]
		LDR	R1, =0x180034
		STR	R1, [R0,#8]
		MOV	R1, #0
		STR	R1, [R0,#4]

loc_340:					// CODE XREF: sub_21C+134j
		LDR	R1, [R0]
		MOV	R2, #3
		AND	R1, R1,	R2
		CMP	R1, #1
		BNE	loc_340
		NOP
		RET
// End of function sub_21C

// ---------------------------------------------------------------------------
dword_35C:	.long 0x70000013		// DATA XREF: ROM:00000034r
dword_360:	.long 0x7E004000		// DATA XREF: ROM:0000003Cr
dword_364:	.long 0x71200014		// DATA XREF: ROM:00000048r
dword_368:	.long 0x71300014		// DATA XREF: ROM:00000054r
dword_36C:	.long 0x7F0081D4		// DATA XREF: ROM:00000060r
dword_370:	.long 0x55555555		// DATA XREF: ROM:00000064r
//off_374:		.long loc_FFFC+3		// DATA XREF: ROM:00000070r
off_374:		.long 0xFFFC+3		// DATA XREF: ROM:00000070r
					// ROM:0000017Cr
//off_378:		.long loc_E10+3		// DATA XREF: ROM:00000074r
off_378:		.long 0xE10+3		// DATA XREF: ROM:00000074r
dword_37C:	.long 0x7E00F000		// DATA XREF: ROM:00000078r
dword_380:	.long 0x7E00F020		// DATA XREF: ROM:00000088r
//off_384:		.long loc_7500+1		// DATA XREF: ROM:0000009Cr
off_384:		.long 0x7500+1		// DATA XREF: ROM:0000009Cr
dword_388:	.long 0x7E00F00C		// DATA XREF: ROM:000000A8r
dword_38C:	.long 0x81900301		// DATA XREF: ROM:000000ACr
dword_390:	.long 0x7E00F010		// DATA XREF: ROM:000000B4r
dword_394:	.long 0x81840303		// DATA XREF: ROM:000000B8r
dword_398:	.long 0x7E00F018		// DATA XREF: ROM:000000C0r
//off_39C:		.long loc_C49C		// DATA XREF: ROM:000000C4r
off_39C:		.long 0xC49C		// DATA XREF: ROM:000000C4r
dword_3A0:	.long 0x7E00F014		// DATA XREF: ROM:000000CCr
dword_3A4:	.long 0x80200103		// DATA XREF: ROM:000000D0r
dword_3A8:	.long 0x7E00F01C		// DATA XREF: ROM:000000D8r
dword_3AC:	.long 0x7E00F120		// DATA XREF: ROM:000000E8r
dword_3B0:	.long 0x7E00F904		// DATA XREF: ROM:000000FCr
dword_3B4:	.long 0x7E00FA08		// DATA XREF: ROM:00000114r
dword_3B8:	.long 0x70100000		// DATA XREF: ROM:loc_120r
					// ROM:00000190r ...
//off_3BC:		.long loc_40E0		// DATA XREF: ROM:00000124r
off_3BC:		.long 0x40E0		// DATA XREF: ROM:00000124r
dword_3C0:	.long 0x70100140		// DATA XREF: ROM:0000012Cr
dword_3C4:	.long 0x51400000		// DATA XREF: ROM:loc_13Cr
					// ROM:000001C8r
dword_3C8:	.long 0x7E00F900		// DATA XREF: sub_1D8r
dword_3CC:	.long 0x7E001000		// DATA XREF: sub_21Cr
dword_3D0:	.long 0x40224019		// DATA XREF: sub_21C+9Cr
//off_3D4:		.long dword_B41		// DATA XREF: sub_21C+A4r
off_3D4:		.long 0xB41		// DATA XREF: sub_21C+A4r
//off_3D8:		.long loc_150F8		// DATA XREF: sub_21C+ACr
off_3D8:		.long 0x150F8		// DATA XREF: sub_21C+ACr
//off_3DC:		.long loc_158F8		// DATA XREF: sub_21C+B4r
off_3DC:		.long 0x158F8		// DATA XREF: sub_21C+B4r
dword_3E0:	.long 0x80034		// DATA XREF: sub_21C:loc_304r
dword_3E4:	.long 0x180034		// DATA XREF: sub_21C+114r
		.long 0, 0, 0, 0,	0
dword_3FC:	.long 0, 0, 0		// DATA XREF: ROM:off_32D4o
					// ROM:off_31D28o
dword_408:	.long 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0 // DATA XREF: sub_18E70:off_18F34o
dword_434:	.long 0			// DATA XREF: sub_7D7C:off_7F4Co
					// ROM:off_157DCo
dword_438:	.long 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0





/* if we are injected by JTAG, the script sets _istag content to nonzero */
is_jtag:
	.word	0

/* it's at a fixed address (+0x8) so we can breakpoint it in the JTAG script
 * we need to go through this hassle because before this moment, SDRAM is not
 * working so we can't prep it from JTAG
 */

_steppingstone_done:
	ldr	pc, _start_armboot

_start_armboot:
	.word 	start_qi

_TEXT_BASE:
	.word	TEXT_BASE

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

	.fill   128
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
