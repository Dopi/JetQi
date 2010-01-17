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



