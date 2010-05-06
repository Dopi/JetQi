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
 * INIT 2
 *
 * 51402f7c
 */

_init2:
	b	_init_start_qi

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
	mov	r1, #1
	mov	r0, #0x16
	bl	jump_GPIO_LUT_sub_B
	mov	r1, #1
	mov	r0, #0x16
	bl	jump_GPIO_LUT_sub_A
	mov	r1, #1
	mov	r0, #0x16
	bl	jump_GPIO_LUT_sub_B
	mov	r1, #1
	mov	r0, #0xB0 // '¦'
	bl	jump_GPIO_LUT_sub_B
	mov	r1, #1
	mov	r0, #0xB0 // '¦'
	bl	jump_GPIO_LUT_sub_A
	mov	r1, #1
	mov	r0, #0xB0 // '¦'
	bl	jump_GPIO_LUT_sub_B
	mov	r1, #2
	mov	r0, #0x69 // 'i'
	BL	jump_GPIO_LUT_sub_D
	MOV	r1, #0
	MOV	r0, #0x69 // 'i'
	BL	jump_GPIO_LUT_sub_A

	ldr	r0, vvar_51403204	// initial content: 0x51446da0
	ldr	r1, vvar_51403208	// initial content: 0x51446da0
	cmp	r0, R1
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
	bl	jump_sub_514152f8
	bl	load_0x5A0B0004_to_R0	// load_0x5A0B0004_to_R0
	mov	r4, r0
	bl	jump_more_GPIO_setup
	str	r0, [R4,#0x30]
	bl	jump_OneNAND_Init
	ldr	r1, [r4, #0x30]
//	adr	r0, aBoothwcheckD__ // "BootHWCheck: %d...\n"
//	bl	SimpleDebugPrint
	mov	r0, #0x69 // 'i'
	bl	jump_GPIO_LUT_sub_C
	cmp	r0, #0
	beq	_battery_okay

	ldr	r0, [r4, #0x30]
	cmp	r0, #2
	bcc	_battery_okay

	mov	r1, SP
	mov	r0, #0xF
	bl	jump_PMIC_LUT2_read
//	adr	r0, aNoBattery  // "NO battery\n"
//	bl	SimpleDebugPrint

_battery_okay:
	bl	jump_SelectBootingMode
	mov	r0, #1
	bl	jump_PMIC_set_reg_SRAMEN_MVTEN_LDOAEN
	mov	r0, #0x7D0
	bl	jump_sub_51430f80
	bl	jump_LCD_InitWin // 0x51401B28
	mov	r0, #0
	str	r0, [R4,#0x24]
	ldr	r0, vvar_51402258 // =0x514449A8

	bl	LCD_init2
	b	start_qi
//	b	qi_cstart
init2_end:
	b	init2_end



LCD_init2:
	stmfd	sp!, {r4,lr}
	mov	r0, #0x7D0
	bl	jump_sub_51430f80
	bl	jump_sub_51417fa0
	mov	r0, #0
	bl	jump_sub_51417f24
//	ldr	r2, color_red
//	adr	r0, asc_spacer // "--------------------------------"
//	bl	LCD_write_line_newline
	ldmfd	sp!, {R4,lr}
	mov	r0, #8
	ldr	pc, adr_sub_5141804c //b	sub_5141804C

PMIC_setup:
	stmfd	sp!, {r4,lr}

	//
	//	WRITE
	//

	// PMIC_set_reg_SIMLTEN
	mov	r1, #0
	mov	r0, #0xF7
	bl	jump_PMIC_LUT2_write // REG_SEQ6CNFG (SEQ6T)
	mov	r1, #0x69
	bl	PMIC_write_print_result

	// PMIC_config_SEQ34567_enable_LDOD_RFTXL_RFRXL_RFRXH_REFOUT (called from DRV_modem_reset called from BBinit)
	mov	R1, #0
	mov	R0, #0xF8
	bl	jump_PMIC_LUT2_write // REG_SEQ6CNFG (SEQ6SRC)
	mov	r1, #0x69
	bl	PMIC_write_print_result

	// PMIC_setup_SIMLTEN_SEQ6 (called from BBinit)
	mov	r1, #0x15
	mov	r0, #0x9B 
	bl	jump_PMIC_LUT2_write // REG_SIMLTTV (SIMLTTV)
	mov	r1, #0x3E
	bl	PMIC_write_print_result

/*
	mov	r1, #0x2D 
	mov	r0, #0xAC 
	bl	jump_PMIC_LUT2_write // REG_CARD1TV (CARD1TV)
	mov	r1, #0x46
	bl	PMIC_write_print_result

	mov	r1, #0x0 
	mov	r0, #0xAA
	bl	jump_PMIC_LUT2_write // REG_CARD1FSEQ (CARD1FSEQPU)
	mov	r1, #0x45
	bl	PMIC_write_print_result

	mov	r1, #0x0 
	mov	r0, #0xAB
	bl	jump_PMIC_LUT2_write // REG_CARD1FSEQ (CARD1FSEQPD)
	mov	r1, #0x45
	bl	PMIC_write_print_result
*/

	//
	//	READ
	//

	mov	r2, #1
	mov	r1, SP
	mov	r0, #0x3a
	bl	jump_PMIC_LUT1_read // read from REG_SIMLTEN
	mov	r1, #0x3c
	ldr	r2, [SP]
	bl	PMIC_read_print_result

	mov	r2, #1
	mov	r1, SP
	mov	r0, #0x3b
	bl	jump_PMIC_LUT1_read // read from REG_SIMLTFSEQ
	mov	r1, #0x3d
	ldr	r2, [SP]
	bl	PMIC_read_print_result

	mov	r2, #1
	mov	r1, SP
	mov	r0, #0x3c
	bl	jump_PMIC_LUT1_read // read from REG_SIMLTTV
	mov	r1, #0x3e
	ldr	r2, [SP]
	bl	PMIC_read_print_result

	//
	//	ENABLE SIM LDO
	//

	// set SRC
	mov	r1, #7
	mov	r0, #0x97		// REG_SIMLTEN (SIMLTENSRC)
//	mov	r0, #0xA8		// REG_CARD1EN (CARD1ENSRC)
//	mov	r0, #0xAE		// REG_CARD2EN (CARD2ENSRC)
	bl	jump_PMIC_LUT2_write 	

	// enable LDO
	mov	r1, #1
	mov	r0, #0x98 		// REG_SIMLTEN (SIMLTEN)
//	mov	r0, #0xA9 		// REG_CARD1EN (CARD1EN)
//	mov	r0, #0xAE 		// REG_CARD2EN (CARD2EN)
	bl	jump_PMIC_LUT2_write 

	// print register
	mov	r2, #1
	mov	r1, SP
	mov	r0, #0x3a		// read from REG_SIMLTEN
//	mov	r0, #0x42		// read from REG_CARD1EN
//	mov	r0, #0x45		// read from REG_CARD2EN
	bl	jump_PMIC_LUT1_read 
	mov	r1, #0x3c		// REG_SIMLTEN
//	mov	r1, #0x44		// REG_CARD1EN
//	mov	r1, #0x48		// REG_CARD2EN
	ldr	r2, [SP]
	bl	PMIC_read_print_result

/*
PMIC_setup_loop:
	bl	wait_10s
	// increment counter
	ldr	r0, _LDO_source
	add	r0, r0, #1
	str	r0, _LDO_source
	cmp	r0, #8
	blt	PMIC_setup_loop
*/
	ldmfd	sp!, {R4,pc}
	
_LDO_source:	.word	0

/*
 *
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
	bx      lr	// 0x51433b80

sub_51433bb4:
	mrc     p15, 0, R0,c1,c0
	orr     R0, R0, #0x800
	mcr     p15, 0, R0,c1,c0
	bx      lr	// 0x51433bc0

load_0x5A0B0004_to_R0:	// sub_51415374:
	ldr	r0, var_51415448
	bx	lr	// 0x51415378


read_from_0x5a0b0034_to_R0:	// sub_514153bc:
	ldr	r0, var_51415448
	ldr	r0, [r0, #48]
	bx	lr	// 0x514153c4

var_51415448:	.word	0x5a0b0004

memcopy_R2bytes_fromR0_toR1:	// sub_5142fd38:
	mov	r3, #0
	mov	ip, r2,lsr#2
_5142fd40:
	cmp     r3, ip
	bcs     ret_5142fd58
	ldr     r2, [r1,r3,lsl#2]
	str	r2, [r0,r3,lsl#2]
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
 *  Text
 */

asc_PMIC_write:
	.ascii	"PMIC write to 0x"
asc_PMIC_write_value:
	.ascii	"00 .... "
asc_PMIC_write_result:
	.ascii	"OKAY"
	.byte	0
	.align	4

asc_PMIC_read:
	.ascii	"PMIC read 0x"
asc_PMIC_read_register:
	.ascii	"00 = 0x"
asc_PMIC_read_value:
	.ascii	"00  "
asc_PMIC_read_result:
	.ascii	"OKAY"
	.byte	0
	.align	4

asc_OKAY:
	.ascii	"OKAY"
asc_FAIL:
	.ascii	"FAIL"

asc_enable:
	.ascii	"enable"
	.byte	0
	.align	4

asc_disable:
	.ascii	"disable"
	.byte	0
	.align	4


/*
 *  Vars
 */

color_white:	.word	0xFFFF	
color_yellow:	.word	0xFFE0	
color_red:	.word	0xF800	

line_pointer:	.word	0


/*
 *  Display output
 */

PMIC_write_print_result:
// arguments: R0: 0=fail,1=success, R1: target register
	stmfd	sp!, {r2-r7,lr}
	cmp	r0, #1
	beq	_PMIC_write_print_result_cont
	ldr	r0, asc_FAIL
	str	r0, asc_PMIC_write_result
_PMIC_write_print_result_cont:
	// convert first digit to ACSII
	mov	r0, r1, lsr#4		
	and	r0, r0, #0xf
	cmp	r0, #0xa
	blt	_PMIC_write_print_result_A
	add	r0, r0, #7
_PMIC_write_print_result_A:
	add	r0, r0, #0x30
	strb	r0, asc_PMIC_write_value

	// convert second digit to ACSII
	and	r0, r1, #0xf
	cmp	r0, #0xa
	blt	_PMIC_write_print_result_B
	add	r0, r0, #7
_PMIC_write_print_result_B:
	add	r0, r0, #0x30
	strb	r0, asc_PMIC_write_value + 1

	// print output
	ldr	r2, color_white
	adr	r0, asc_PMIC_write
	bl	LCD_write_line_newline
	ldmfd	sp!, {r2-r7,pc}


PMIC_read_print_result:
// arguments: R0: 0=fail,1=success, R1: read register, R2: register value
	stmfd	sp!, {r2-r7,lr}
	cmp	r0, #1
	beq	_PMIC_read_print_result_cont
	ldr	r0, asc_FAIL
	str	r0, asc_PMIC_read_result
_PMIC_read_print_result_cont:
	// convert first digit to ACSII
	mov	r0, r1, lsr#4		
	and	r0, r0, #0xf
	cmp	r0, #0xa
	blt	_PMIC_read_print_result_A
	add	r0, r0, #7
_PMIC_read_print_result_A:
	add	r0, r0, #0x30
	strb	r0, asc_PMIC_read_register

	// convert second digit to ACSII
	and	r0, r1, #0xf
	cmp	r0, #0xa
	blt	_PMIC_read_print_result_B
	add	r0, r0, #7
_PMIC_read_print_result_B:
	add	r0, r0, #0x30
	strb	r0, asc_PMIC_read_register + 1

	mov	r1,r2
	// convert first digit to ACSII
	mov	r0, r1, lsr#4		
	and	r0, r0, #0xf
	cmp	r0, #0xa
	blt	_PMIC_read_print_result_C
	add	r0, r0, #7
_PMIC_read_print_result_C:
	add	r0, r0, #0x30
	strb	r0, asc_PMIC_read_value

	// convert second digit to ACSII
	and	r0, r1, #0xf
	cmp	r0, #0xa
	blt	_PMIC_read_print_result_D
	add	r0, r0, #7
_PMIC_read_print_result_D:
	add	r0, r0, #0x30
	strb	r0, asc_PMIC_read_value + 1

	// print output
	ldr	r2, color_white
	adr	r0, asc_PMIC_read
	bl	LCD_write_line_newline
	ldmfd	sp!, {r2-r7,pc}



LCD_write_line:
	mov	R3, #0
	ldr	r1, line_pointer
	b	jump_LCD_print	// 0x514182D4

LCD_write_line_newline:
	mov	R3, #0
	ldr	r1, line_pointer
	add	r1, #1
	str	r1, line_pointer
	b	jump_LCD_print	// 0x514182D4

/*
enable_MSG:
	stmfd	sp!, {r4,lr}
	ldr	r2, color_white
	adr	r0, asc_enable
	bl	LCD_write_line_newline
	ldmfd	sp!, {R4,pc}

disable_MSG:
	stmfd	sp!, {r4,lr}
	ldr	r2, color_white
	adr	r0, asc_disable
	bl	LCD_write_line_newline
	ldmfd	sp!, {R4,pc}

*/
/*
 * Long Distance Jumps
 */



adr_more_GPIO_setup:	.word	0x514029b0
jump_more_GPIO_setup:
	ldr	pc, adr_more_GPIO_setup	

adr_SelectBootingMode:	.word	0x51402B90
jump_SelectBootingMode:
	ldr	pc, adr_SelectBootingMode	

adr_sub_514152F8:	.word	0x514152F8
jump_sub_514152f8:
	ldr	pc, adr_sub_514152F8	

adr_sub_51417f24:	.word	0x51417f24
jump_sub_51417f24:
	ldr	pc, adr_sub_51417f24

adr_sub_51417fa0:	.word	0x51417fa0
jump_sub_51417fa0:
	ldr	pc, adr_sub_51417fa0

adr_sub_5141804c:	.word	0x5141804c
jump_sub_5141804c:
	ldr	pc, adr_sub_5141804c

adr_PMIC_LUT1_write:	.word	0x51419D64
jump_PMIC_LUT1_write:
	ldr	pc, adr_PMIC_LUT1_write 

adr_PMIC_LUT1_read:	.word	0x51419DA0
jump_PMIC_LUT1_read:
	ldr	pc, adr_PMIC_LUT1_read	

adr_PMIC_LUT2_write:	.word	0x51419C90
jump_PMIC_LUT2_write:
	ldr	pc, adr_PMIC_LUT2_write

adr_PMIC_LUT2_read:	.word	0x51419d0c
jump_PMIC_LUT2_read:
	ldr	pc, adr_PMIC_LUT2_read

adr_PMIC_set_reg_SRAMEN_MVTEN_LDOAEN:	.word	0x5141AF20
jump_PMIC_set_reg_SRAMEN_MVTEN_LDOAEN:
	ldr	pc, adr_PMIC_set_reg_SRAMEN_MVTEN_LDOAEN	

adr_sub_51430f80:	.word	0x51430f80
jump_sub_51430f80:
	ldr	pc, adr_sub_51430f80

adr_GPIO_LUT_sub_A:	.word	0x51438078 
jump_GPIO_LUT_sub_A:
	ldr	pc, adr_GPIO_LUT_sub_A

adr_GPIO_LUT_sub_B:	.word	0x514380F8
jump_GPIO_LUT_sub_B:
	ldr	pc, adr_GPIO_LUT_sub_B

adr_GPIO_LUT_sub_C:	.word	0x51438160
jump_GPIO_LUT_sub_C:
	ldr	pc, adr_GPIO_LUT_sub_C

adr_GPIO_LUT_sub_D:	.word	0x514381C4 
jump_GPIO_LUT_sub_D:
	ldr	pc, adr_GPIO_LUT_sub_D


/*
 *
 */

_continue_nucleus:
//	ldr	pc, _start_oldboot
	bl	jump_LCD_clear_screen
	bl	jump_Samsung_boot_logo
	bl	jump_LaunchNucleus
	b	spin_forever
_continue_qiboot:
	ldr	pc, _start_armboot
	b	spin_forever

_start_armboot:
	.word 	start_qi
_start_oldboot:
	.word 	0x51400000
