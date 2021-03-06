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

	bl	JetDroid_mode_MSG
	bl	jump_Baseband_Init
	bl	_wait_10s
	b	_continue_nucleus


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

asc_spacer:
	.ascii	"------------------------------"
	.byte	0
	.align	4

asc_jetdroid:
	.ascii	"   \t    JetDroid mode  \t     "
	.byte	0
	.align	4

/*
 *  Vars
 */

color_white:	.word	0xFFFF	
color_yellow:	.word	0xFFE0	
color_red:	.word	0xF800	

/*
 *  Display output
 */

JetDroid_mode_MSG: //0x514184B8
	stmfd	sp!, {r4,lr}
	mov	r0, #0x7D0
	bl	jump_sub_51430f80
	bl	jump_sub_51417fa0
	mov	r0, #0
	bl	jump_sub_51417f24
	mov	R3, #0
	ldr	r2, color_red
	mov	r1, #1	// line
	adr	r0, asc_spacer // "--------------------------------"
	bl	jump_LCD_printf	// 0x514182D4
	mov	R3, #0
	ldr	r2, color_white
	mov	r1, #2	// line
	adr	r0, asc_jetdroid // "   \t    JetDroid mode  \t      "
	bl	jump_LCD_printf
	ldr	r2, color_red
	mov	r1, #3	// line
	adr	r0, asc_spacer  // "--------------------------------"
	bl	jump_LCD_printf
	ldmfd	sp!, {R4,lr}
	mov	r0, #8
	ldr	pc, adr_sub_5141804c //b	sub_5141804C

/*
 * Waiting (short, long, infinite)
 */

_wait_10s:
	mov	r0, #0x20000000			// approx 10 sec wait
_wait10loop:
	subs	r0, r0, #1
	cmp	r0, #0
	bne	_wait10loop
	bx	lr

_wait_5s:
	mov	r0, #0x10000000			// approx 10 sec wait
_wait5loop:
	subs	r0, r0, #1
	cmp	r0, #0
	bne	_wait5loop
	bx	lr

_spin_forever:
	b	_spin_forever


/*
 * Long Distance Jumps
 */

adr_OneNAND_Init:	.word	0x51401C3C
jump_OneNAND_Init:
	ldr	pc, adr_OneNAND_Init	

adr_LCD_InitWin:	.word	0x51401B28
jump_LCD_InitWin:
	ldr	pc, adr_LCD_InitWin	

adr_LaunchNucleus:	.word	0x514023A8 
jump_LaunchNucleus:
	ldr	pc, adr_LaunchNucleus

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

adr_LCD_printf:	.word	0x514182D4
jump_LCD_printf:
	ldr	pc, adr_LCD_printf	

adr_LCD_clear_screen:	.word	0x5141847C
jump_LCD_clear_screen:
	ldr	pc, adr_LCD_clear_screen

adr_Samsung_boot_logo:	.word	0x51418498
jump_Samsung_boot_logo:
	ldr	pc, adr_Samsung_boot_logo

adr_MSG_UPLOAD_data_to_pc:	.word	0x5141852C
jump_MSG_UPLOAD_data_to_pc:
	ldr	pc, adr_MSG_UPLOAD_data_to_pc	

adr_LCD_blue_screen:	.word	0x5141864C
jump_LCD_blue_screen:
	ldr	pc, adr_LCD_blue_screen

adr_Baseband_Init:	.word	0x5141983C
jump_Baseband_Init:
	ldr	pc, adr_Baseband_Init	

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
	b	_spin_forever
_continue_qiboot:
	ldr	pc, _start_armboot
	b	_spin_forever

_start_armboot:
	.word 	start_qi
_start_oldboot:
	.word 	0x51400000
