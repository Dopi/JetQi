/*
 * (C) Copyright 2007 OpenMoko, Inc.
 *
 * Configuation settings for the OPENMOKO Neo GTA02 Linux GSM phone
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */

#define __ASM_MODE__
#define __ASSEMBLY__

#include <s3c6410.h>

#define TEXT_BASE 0x53000000

#ifndef SMARTQ
#define S3C6410_POP_A 1
#endif

#define set_pll(mdiv, pdiv, sdiv)	(1<<31 | mdiv<<16 | pdiv<<8 | sdiv)

/* fixed MPLL 533MHz */
#define MPLL_MDIV	266
#define MPLL_PDIV	3
#define MPLL_SDIV	1

#define Startup_APLLdiv		0
#define APLL_MDIV	266
#define APLL_PDIV	3
#define APLL_SDIV	1
#define	Startup_PCLKdiv		3
#define Startup_HCLKdiv		1
#define Startup_MPLLdiv		1
#define Startup_HCLKx2div	1
#define Startup_APLL	(12000000/(APLL_PDIV<<APLL_SDIV)*APLL_MDIV)
#define Startup_HCLK	(Startup_APLL/(Startup_HCLKx2div+1)/(Startup_HCLKdiv+1))

#define CLK_DIV_VAL	((Startup_PCLKdiv<<12)|(Startup_HCLKx2div<<9)|(Startup_HCLKdiv<<8)|(Startup_MPLLdiv<<4)|Startup_APLLdiv)
#define APLL_VAL	set_pll(APLL_MDIV, APLL_PDIV, APLL_SDIV)
#define MPLL_VAL	set_pll(MPLL_MDIV, MPLL_PDIV, MPLL_SDIV)
#if S3C6410_POP_A

#define DMC1_MEM_CFG		0x00210011	/* Supports one CKE control, Chip1, Burst4, Row/Column bit */
#define DMC1_MEM_CFG2		0xB41
#define DMC1_CHIP0_CFG		0x150FC
#define DMC1_CHIP1_CFG		0x154FC
#define DMC_DDR_32_CFG		0x0		/* 32bit, DDR */

/* Memory Parameters */
/* DDR Parameters */
#define DDR_tREFRESH		5865		/* ns */
#define DDR_tRAS		50		/* ns (min: 45ns)*/
#define DDR_tRC 		68		/* ns (min: 67.5ns)*/
#define DDR_tRCD		23		/* ns (min: 22.5ns)*/
#define DDR_tRFC		133		/* ns (min: 80ns)*/
#define DDR_tRP 		23		/* ns (min: 22.5ns)*/
#define DDR_tRRD		20		/* ns (min: 15ns)*/
#define DDR_tWR 		20		/* ns (min: 15ns)*/
#define DDR_tXSR		125		/* ns (min: 120ns)*/
#define DDR_CASL		3		/* CAS Latency 3 */

#else

#define DMC1_MEM_CFG		0x00010012	/* Supports one CKE control, Chip1, Burst4, Row/Column bit */
#define DMC1_MEM_CFG2		0xB45
#define DMC1_CHIP0_CFG		0x150F8
#define DMC_DDR_32_CFG		0x0 		/* 32bit, DDR */

/* Memory Parameters */
/* DDR Parameters */
#define DDR_tREFRESH		7800		/* ns */
#define DDR_tRAS		45		/* ns (min: 45ns)*/
#define DDR_tRC 		68		/* ns (min: 67.5ns)*/
#define DDR_tRCD		23		/* ns (min: 22.5ns)*/
#define DDR_tRFC		80		/* ns (min: 80ns)*/
#define DDR_tRP 		23		/* ns (min: 22.5ns)*/
#define DDR_tRRD		15		/* ns (min: 15ns)*/
#define DDR_tWR 		15		/* ns (min: 15ns)*/
#define DDR_tXSR		120		/* ns (min: 120ns)*/
#define DDR_CASL		3		/* CAS Latency 3 */

#endif


/*
 * mDDR memory configuration
 */
#define DMC_DDR_BA_EMRS 	2
#define DMC_DDR_MEM_CASLAT	3
#define DMC_DDR_CAS_LATENCY	(DDR_CASL<<1)						//6   Set Cas Latency to 3
#define DMC_DDR_t_DQSS		1							// Min 0.75 ~ 1.25
#define DMC_DDR_t_MRD		2							//Min 2 tck
#define DMC_DDR_t_RAS		(((Startup_HCLK / 1000 * DDR_tRAS) - 1) / 1000000 + 1)	//7, Min 45ns
#define DMC_DDR_t_RC		(((Startup_HCLK / 1000 * DDR_tRC) - 1) / 1000000 + 1) 	//10, Min 67.5ns
#define DMC_DDR_t_RCD		(((Startup_HCLK / 1000 * DDR_tRCD) - 1) / 1000000 + 1) 	//4,5(TRM), Min 22.5ns
#define DMC_DDR_schedule_RCD	((DMC_DDR_t_RCD - 3) << 3)
#define DMC_DDR_t_RFC		(((Startup_HCLK / 1000 * DDR_tRFC) - 1) / 1000000 + 1) 	//11,18(TRM) Min 80ns
#define DMC_DDR_schedule_RFC	((DMC_DDR_t_RFC - 3) << 5)
#define DMC_DDR_t_RP		(((Startup_HCLK / 1000 * DDR_tRP) - 1) / 1000000 + 1) 	//4, 5(TRM) Min 22.5ns
#define DMC_DDR_schedule_RP	((DMC_DDR_t_RP - 3) << 3)
#define DMC_DDR_t_RRD		(((Startup_HCLK / 1000 * DDR_tRRD) - 1) / 1000000 + 1)	//3, Min 15ns
#define DMC_DDR_t_WR		(((Startup_HCLK / 1000 * DDR_tWR) - 1) / 1000000 + 1)	//Min 15ns
#define DMC_DDR_t_WTR		2
#define DMC_DDR_t_XP		2							//1tck + tIS(1.5ns)
#define DMC_DDR_t_XSR		(((Startup_HCLK / 1000 * DDR_tXSR) - 1) / 1000000 + 1)	//17, Min 120ns
#define DMC_DDR_t_ESR		DMC_DDR_t_XSR
#define DMC_DDR_REFRESH_PRD	(((Startup_HCLK / 1000 * DDR_tREFRESH) - 1) / 1000000) 	// TRM 2656
#define DMC_DDR_USER_CONFIG	1							// 2b01 : mDDR


.globl _start, processor_id, is_jtag

_start:	b       start_code
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
	/*
	 * set the cpu to SVC32 mode
	 */
	mrs	r0,cpsr
	bic	r0,r0,#0x1f
	orr	r0,r0,#0xd3
	msr	cpsr,r0

	/*
	 * flush v4 I/D caches
	 */
	mov	r0, #0
	mcr	p15, 0, r0, c7, c7, 0	/* flush v3/v4 cache */
	mcr	p15, 0, r0, c8, c7, 0	/* flush v4 TLB */

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

	ldr	r1, =0x04
	str	r1, [r0, #INDEX_DMC_MEMC_CMD]

	ldr	r1, =DMC_DDR_REFRESH_PRD
	str	r1, [r0, #INDEX_DMC_REFRESH_PRD]

	ldr	r1, =DMC_DDR_CAS_LATENCY
	str	r1, [r0, #INDEX_DMC_CAS_LATENCY]

	ldr	r1, =DMC_DDR_t_DQSS
	str	r1, [r0, #INDEX_DMC_T_DQSS]

	ldr	r1, =DMC_DDR_t_MRD
	str	r1, [r0, #INDEX_DMC_T_MRD]

	ldr	r1, =DMC_DDR_t_RAS
	str	r1, [r0, #INDEX_DMC_T_RAS]

	ldr	r1, =DMC_DDR_t_RC
	str	r1, [r0, #INDEX_DMC_T_RC]

	ldr	r1, =DMC_DDR_t_RCD
	ldr	r2, =DMC_DDR_schedule_RCD
	orr	r1, r1, r2
	str	r1, [r0, #INDEX_DMC_T_RCD]

	ldr	r1, =DMC_DDR_t_RFC
	ldr	r2, =DMC_DDR_schedule_RFC
	orr	r1, r1, r2
	str	r1, [r0, #INDEX_DMC_T_RFC]

	ldr	r1, =DMC_DDR_t_RP
	ldr	r2, =DMC_DDR_schedule_RP
	orr	r1, r1, r2
	str	r1, [r0, #INDEX_DMC_T_RP]

	ldr	r1, =DMC_DDR_t_RRD
	str	r1, [r0, #INDEX_DMC_T_RRD]

	ldr	r1, =DMC_DDR_t_WR
	str	r1, [r0, #INDEX_DMC_T_WR]

	ldr	r1, =DMC_DDR_t_WTR
	str	r1, [r0, #INDEX_DMC_T_WTR]

	ldr	r1, =DMC_DDR_t_XP
	str	r1, [r0, #INDEX_DMC_T_XP]

	ldr	r1, =DMC_DDR_t_XSR
	str	r1, [r0, #INDEX_DMC_T_XSR]

	ldr	r1, =DMC_DDR_t_ESR
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

	@Auto Refresh	2 time
	ldr	r1, =DMC_AR0
	str	r1, [r0, #INDEX_DMC_DIRECT_CMD]
	str	r1, [r0, #INDEX_DMC_DIRECT_CMD]

	@MRS
	ldr	r1, =DMC_mDDR_EMR0
	str	r1, [r0, #INDEX_DMC_DIRECT_CMD]

	@Mode Reg
	ldr	r1, =DMC_mDDR_MR0
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
	mov	r1, #0x0
	str	r1, [r0, #INDEX_DMC_MEMC_CMD]

1:
	ldr	r1, [r0, #INDEX_DMC_MEMC_STATUS]
	mov	r2, #0x3
	and	r1, r1, r2
	cmp	r1, #0x1
	bne	1b
	nop

	ldr	r0, =ELFIN_CLOCK_POWER_BASE	@0x7e00f000

	ldr	r1, [r0, #OTHERS_OFFSET]
	mov	r2, #0x40
	orr	r1, r1, r2
	str	r1, [r0, #OTHERS_OFFSET]

	nop
	nop
	nop
	nop
	nop

	ldr	r2, =0x80
	orr	r1, r1, r2
	str	r1, [r0, #OTHERS_OFFSET]

2:
	ldr	r1, [r0, #OTHERS_OFFSET]
	ldr	r2, =0xf00
	and	r1, r1, r2
	cmp	r1, #0xf00
	bne	2b

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

	ldr	r1, [r0, #OTHERS_OFFSET]
	orr	r1, r1, #0x20
	str	r1, [r0, #OTHERS_OFFSET]


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
