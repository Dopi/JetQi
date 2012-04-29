	.equ 	dumper_target_loc, 0x507A5000
	.equ	dumper_loc, dumper
	.equ	dumper_size_val, (dumper_end-dumper_begin)
	.global	dumper
	.global	dumper_loc
	.global	dumper_size_val

	.code 32

dumper:
//	.org	dumper_loc, 0
dumper_begin:
	stmfd	sp!, {r0-r10, lr}
	MOV	R8, R2
	MOV	R7, R1
	MOV	R6, R0
	LDR	R3, [R0, #4]
	CMP	R3, #6
	BNE	do_dump
	LDMFD	sp!, {r0-r10, pc}
do_dump:
	MOV	 R3, #0
	MOV	 R2, #0
	MOV	 R1, #0x4000
	MOV	 R0, #0
	BLX	jump_MemAllocTraceEx
	MOV	R5, R0

	MOV	R1, #0
	MOV	R2, #0
	MOV	R3, R5
	CMP	R8, #0
	ADREQ	R4, rx_head
	BEQ	headerloop
	CMPNE	R8, #1
	ADREQ	R4, tx_head
	BEQ	headerloop
	CMPNE	R8, #2
	ADREQ	R4, lrx_head
	ADRNE	R4, ltx_head
headerloop:
	ldrb 	R0, [R4, R1]
	add  	r1, r1, #1
	cmp 	r0, #0
#	strbne 	r0, [r3], #1
	strne 	r0, [r3], #1
	bne    headerloop

	MOV	R1, #0
	MOV	R2, #0
#	MOV     R3, R5
dumploop:
	LDRB	R4, [R6, R1]

#	UBFX	R0, R4, #4, #4
	lsr	R0, R4, #4
	and	R0, R0, #15

	CMP	R0, #10
	ADDCC	R0, R0, #48
	ADDCS	R0, R0, #(65-10)
	STRB	R0, [R3], #1

#	UBFX	R0, R4, #0, #4
	and	R0, R4, #15	

	CMP	R0, #10
	ADDCC	R0, R0, #48
	ADDCS	R0, R0, #(65-10)
	STRB	R0, [R3], #1
	MOV	R0, #' '
	STRB	R0, [R3], #1

	ADD	R1, R1, #1
	CMP	R1, R7
	BLT	dumploop
	MOV	R0, #0xA
	STRB	R0, [R3], #1

	MOV	R0, #0
	STRB	R0, [R3], #1
	mov	R0, R5

	BL	uart_print_string

	MOV	R3, #0
	MOV	R2, #0
	MOV	R1, R5
	MOV	R0, #0
	BLX	jump_MemFreeTraceEx

	LDMFD	sp!, {r0-r10, pc}
	.align 4
rx_head:
	.string	"rx_frame: "
	.byte	0
tx_head:	
	.string	"tx_frame: "
	.byte	0
ltx_head:
	.string	"ltx_frame: "
	.byte	0
lrx_head:
	.string	"lrx_frame: "
	.byte	0
	.align 4
uart_print_string:
	STMFD	SP!, {R4,LR}
	MOV	R4, R0
printloop:
	ldrb	R0, [R4]
	cmp	r0, #0
	blne	uart_print_byte
	ldrb	R0, [R4], #1
	cmp	r0, #0
	bne	printloop
	LDMFD	SP!, {R4,PC}

uart_print_byte:
	STMFD	SP!, {R4,LR}
	MOV	R4, R0
uart_wait:
	LDR	R0, uart_sfr
	LDR	R0, [R0,#0x10]
	TST	R0, #2
	BEQ	uart_wait
	LDR	R0, uart_sfr
	STR	R4, [R0,#0x20]
	LDMFD	SP!, {R4,PC}

uart_sfr:
	.word	0x7F005800 
#	from S8000 BL2

	.global	tx_hook
	.align 4
tx_hook:
	STMFD		SP!, {R1-R10,LR}
	BL		jump_getCurrentFramePtr
	LDR		R1, [R0, #0x8]
	ADD		R1, #0xC
	MOV		R2, #1
//	BL		dumper_loc
	BL		dumper_begin

	MOV		R0, #0x1000 
	#replaced opcode

	LDMFD		SP!, {R1-R10,PC}

/* 
 *
 * long distance jumps
 *
 */

// MemAllocTraceEx (thumb) 
	.equ	MemAllocTraceEx, 0x5025A3D4
	.global adr_MemAllocTraceEx
adr_MemAllocTraceEx:
	.word	MemAllocTraceEx
	.global jump_MemAllocTraceEx
	.thumb
jump_MemAllocTraceEx:
	b	[adr_MemAllocTraceEx]

// MemFreeTraceEx (thumb)
	.equ	MemFreeTraceEx, 0x5025A66A
	.global	adr_MemFreeTraceEx
adr_MemFreeTraceEx:
	.word	MemFreeTraceEx
	.global	jump_MemFreeTraceEx
	.thumb
jump_MemFreeTraceEx:
	b	[adr_MemFreeTraceEx]

// getCurrentFramePtr (code 32)
	.equ	getCurrentFramePtr, 0x5039BD8C
	.global	adr_getCurrentFramePtr
adr_getCurrentFramePtr:
	.word	getCurrentFramePtr
	.global	jump_getCurrentFramePtr
	.code 32
jump_getCurrentFramePtr:
	b	[adr_getCurrentFramePtr]

dumper_end:
//	.org ((dumper_end-dumper_begin)+dumper)

