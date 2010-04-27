/*
 * (C) Copyright 2009 
 * Author: Dopi <dopi711@googlemail.com>
 *
 * bootloader specific code
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
 *
 */

#include <s3c6410.h>
#include "boot_loader_interface.h"

#define LCD_color_white		0xFFFF	
#define LCD_color_yellow	0xFFE0	
#define LCD_color_red		0xF800	

int	LCD_line_pointer = 1;

void jump_OneNAND_Init (void)
{
asm volatile (
	"ldr	pc, adr_OneNAND_Init\n\t"
	"adr_OneNAND_Init:	.word	0x51401C3C\n\t"
);
}

void jump_LCD_InitWin (void)
{
asm volatile (
	"ldr	pc, adr_LCD_InitWin\n\t"
	"adr_LCD_InitWin:	.word	0x51401B28"
);
}

void jump_LaunchNucleus (void)
{
//	char *jump_addr;
//	jump_addr = (char*) 0x514023A8;
asm volatile (
//	"ldr	pc, %[pointer]"
//	: : [pointer] "X" (&jump_addr)
	"ldr	pc, adr_LaunchNucleus\n\t"
	"adr_LaunchNucleus:	.word	0x514023A8"
);
}	

int LCD_print (char *string, int color, int line_number )
{
	int res;
	register char *out_string asm("r0") = string;
	register int out_line asm("r1") = line_number;
	register int out_color asm("r2") = color;
	
	out_string = out_string; out_line = out_line; out_color = out_color;	// pretend to use these vars

	asm volatile(
		//"mov	r0, %[A]\n\t"
		//"mov	r1, %[B]\n\t"
		//"mov	r2, %[C]\n\t"
		"mov	R3, #0\n\t"
		"bl	jump_LCD_print\n\t"
		: [result] "=r" (res) 
		: [A] "r" (out_string), [B] "r" (out_line), [C] "r" (out_color)
		: "lr"
	);
	return res;
}	

int LCD_print_newline (char *string, int color)
{
	int res;
	res=LCD_print( string, color, LCD_line_pointer);
	LCD_line_pointer++;
	return res;
}

void ctest_JetDroid_mode_MSG(void)
{
	LCD_print("------------------------------", LCD_color_red, 1);
	LCD_print("   \t   JetDroid mode  \t     ", LCD_color_white, 2);
	LCD_print("------------------------------", LCD_color_red, 3);

	LCD_line_pointer=4;
}

void MSG_PMIC_setup(void)
{
	LCD_print_newline("Setting up PMIC ...", LCD_color_white);
}

void enable_MSG(void)
{
	LCD_print_newline("Enable.", LCD_color_white);
}

void disable_MSG(void)
{
	LCD_print_newline("Disable.", LCD_color_white);
}



void jump_LCD_print (void)
{
asm volatile (
//	"ldr	pc, adr_LCD_print\n\t"
	"stmfd	sp!, {r1,r4,lr}\n\t"
	"ldr	r4, adr_LCD_print\n\t"
	"blx	r4\n\t"
	"ldmfd	sp!, {r1,r4,pc}\n\t"
	"adr_LCD_print:	.word	0x514182D4\n\t"
);
}	

void jump_MSG_UPLOAD_data_to_pc (void)
{
asm volatile (
	"ldr	pc, adr_MSG_UPLOAD_data_to_pc\n\t"
	"adr_MSG_UPLOAD_data_to_pc:	.word	0x5141852C"
);
}	

void jump_LCD_clear_screen (void)
{
asm volatile (
	"ldr	pc, adr_LCD_clear_screen\n\t"
	"adr_LCD_clear_screen:	.word	0x5141847C"
);
}

void jump_Samsung_boot_logo (void)
{
asm volatile (
	"ldr	pc, adr_Samsung_boot_logo\n\t"
	"adr_Samsung_boot_logo:	.word	0x51418498"
);
}

void jump_LCD_blue_screen (void)
{
asm volatile (
	"ldr	pc, adr_LCD_blue_screen\n\t"
	"adr_LCD_blue_screen:	.word	0x5141864C"
);
}

void jump_Baseband_Init (void)
{
asm volatile (
	"stmfd	sp!, {r1-r4,lr}\n\t"
	"ldr	r0, adr_Baseband_Init\n\t"
	"blx	r0\n\t"
	"ldmfd	sp!, {r1-r4,pc}\n\t"
	"adr_Baseband_Init:	.word	0x5141983C"
);
}





void wait_10s (void)
{
asm volatile (
	"mov	r0, #0x20000000\n\t"	// approx 10 sec wait
	"_wait10loop:"
	"subs	r0, r0, #1\n\t"
	"cmp	r0, #0\n\t"
	"bne	_wait10loop"
	: : : "r0"
);
}

void wait_5s (void)
{
asm volatile (
	"mov	r0, #0x10000000\n\t"	// approx 5 sec wait
	"_wait5loop:"
	"subs	r0, r0, #1\n\t"
	"cmp	r0, #0\n\t"
	"bne	_wait5loop"
	: : : "r0"
);
}

void spin_forever (void)
{
	while(1==1){
	}
/*
asm volatile (
	"_spin_forever:"
	"b	_spin_forever"
);
*/
}

void disable_SD_LDO (void)
{
asm volatile (
	"stmfd	sp!, {r0-r1}\n\t"
//	"stmfd	sp!, {lr}\n\t"

	"mov	r1, #0x07F000000\n\t"
	"add	r1, r1, #0x8000\n\t"

	// set pull-up on MMC_CDn1/GPG6
	"ldr	r0, [r1, #0xc0]\n\t"		// read Port G Configuration Register
	"and	r0, r0, #0xf0ffffff\n\t" 	// clear bits 24-27	==> GPG6 is input
	"str	r0, [r1, #0xc0]	\n\t"		// write Port G Configuration Register

	"ldr	r0, [r1, #0xc8]\n\t"		// read Port G Pull-up/down Register
	"and	r0, r0, #0xffffe7ff\n\t" 	// clear bits 12-13	
	"orr	r0, r0, #0x00001000\n\t"	// set bit 13 ==> GPG6 pull-up enabled
	"str	r0, [r1, #0xc8]\n\t"		// write Port G Pull-up/down Register
/*
	mov	r1, #0x07F000000
	add	r1, r1, #0x8800

	// set pull-up on MMC_CDn1/GPG6
	ldr	r0, [r1, #0x04]		// read Port K Configuration Register 1
	and	r0, r0, #0xfffffff0 	// clear bits 0-3	==> GPK8 is input
	str	r0, [r1, #0x04]		// write Port K Configuration Register 1

	ldr	r0, [r1, #0x0c]		// read Port K Pull-up/down Register
	and	r0, r0, #0xfffcffff 	// clear bits 16-17	
	orr	r0, r0, #0x00010000	// set bit 13 ==> GPK8 pull-down enabled
	str	r0, [r1, #0x0c]		// write Port K Pull-up/down Register
*/
	"ldmfd	sp!, {r0-r1}\n\t"
//	"ldmfd	sp!, {pc}\n\t"
);

	LCD_print_newline("Disabled SD-card LDO", LCD_color_white);
}

void enable_SD_LDO (void)
{
asm volatile (
	"stmfd	sp!, {r0-r1}\n\t"

	"mov	r1, #0x07F000000\n\t"
	"add	r1, r1, #0x8000\n\t"

	// set pull-down on MMC_CDn1/GPG6
	"ldr	r0, [r1, #0xc0]\n\t"		// read Port G Configuration Register
	"and	r0, r0, #0xf0ffffff\n\t" 	// clear bits 24-27	==> GPG6 is input
	"str	r0, [r1, #0xc0]\n\t"		// write Port G Configuration Register

	"ldr	r0, [r1, #0xc8]\n\t"		// read Port G Pull-up/down Register
	"and	r0, r0, #0xffffe7ff\n\t" 	// clear bits 12-13	
	"orr	r0, r0, #0x00000800\n\t"	// set bit 12 ==> GPG6 pull-down enabled
	"str	r0, [r1, #0xc8]\n\t"		// write Port G Pull-up/down Register
/*
	mov	r1, #0x07F000000
	add	r1, r1, #0x8800

	// set pull-up on MMC_CDn1/GPG6
	ldr	r0, [r1, #0x04]		// read Port K Configuration Register 1
	and	r0, r0, #0xfffffff0 	// clear bits 0-3	==> GPK8 is input
	str	r0, [r1, #0x04]		// write Port K Configuration Register 1

	ldr	r0, [r1, #0x0c]		// read Port K Pull-up/down Register
	and	r0, r0, #0xfffcffff 	// clear bits 16-17	
	orr	r0, r0, #0x00020000	// set bit 13 ==> GPK8 pull-up enabled
	str	r0, [r1, #0x0c]		// write Port K Pull-up/down Register
*/
	"ldmfd	sp!, {r0-r1}\n\t"
//	: : "r0", "r1"
);
	LCD_print_newline("Enabled SD-card LDO", LCD_color_white);
}

void qi_cstart(void)
{
	//LCD_init2();		// this is still in ASM
	ctest_JetDroid_mode_MSG();

	LCD_print_newline("Initializing baseband ...", LCD_color_white);
	//jump_Baseband_Init();
	asm volatile (
		"stmfd	sp!, {r1-r4}\n\t"
		"ldr	r0, aadr_Baseband_Init\n\t"
		"blx	r0\n\t"
		"b	after_bb_init\n\t"
		"aadr_Baseband_Init:	.word	0x5141983C\n\t"
		"after_bb_init:\n\t"
		"ldmfd	sp!, {r1-r4}\n\t"
	);

	//MSG_PMIC_setup();
	//PMIC_setup();	
	enable_SD_LDO();

	LCD_print_newline("Now entering infinte loop ...", LCD_color_white);
	spin_forever();
}



/*
unsigned long ByteSwap(unsigned long val)
{
asm volatile (
        "eor     r3, %1, %1, ror #16\n\t"
        "bic     r3, r3, #0x00FF0000\n\t"
        "mov     %0, %1, ror #8\n\t"
        "eor     %0, %0, r3, lsr #8"
        : "=r" (val)
        : "0"(val)
        : "r3" 
);
return val;
}
*/

