
	.THUMB

	.ALIGN 4
	.equ 	dumper_loc, 0x507A5000
dumper_loc_a:
	.word 	dumper_loc

	.equ 	hook_loc, 0x5012120E
hook_loc_a:
	.word 	hook_loc

hook:
	.org 	hook_loc
hook_begin:
	NOP
//	MOV.W	R2, #0
	MOV	R2, #0
	BLX  	dumper_loc
//	NOP //BL  BadaPrint
//	NOP //MOV.W = 4bytes

//	NOP
//	NOP
	NOP
	NOP
	NOP

	NOP
	NOP //BL = 4 bytes
hook_end:
	.org ((hook_end-hook_begin)+hook)
	.align 4
hook_size:
	.word	(hook_end-hook_begin)



#define MemAllocTraceEx 0x5025A3D4
#define MemFreeTraceEx 0x5025A66A

	.code 32

	.align 4
#define hook2_loc 0x5039A93C
hook2_loc_a:
	.word	hook2_loc
hook2:
	.org hook2_loc
hook2_begin:
	BL  tx_hook

hook2_end:
	.org ((hook2_end-hook2_begin)+hook2)
	.align 4

#define hook2_size (hook2_end-hook2_begin)
#define dumper_size (dumper_end-dumper_begin)

dumper:
	.org dumper_loc
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
	BLX	MemAllocTraceEx
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
//	strbne 	r0, [r3], #1
	strne 	r0, [r3], #1
	bne    headerloop

	MOV	R1, #0
	MOV	R2, #0
//	MOV     R3, R5
dumploop:
	LDRB	R4, [R6, R1]

	//UBFX	R0, R4, #4, #4
	lsr	R0, R4, #4
	and	R0, R0, #15

	CMP	R0, #10
	ADDCC	R0, R0, #48
	ADDCS	R0, R0, #(65-10)
	STRB	R0, [R3], #1

	//UBFX	R0, R4, #0, #4
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
	BLX	MemFreeTraceEx

	LDMFD	sp!, {r0-r10, pc}

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
	.word	0x7F005800 //from S8000 BL2


	.align 4
#define getCurrentFramePtr 0x5039BD8C
tx_hook:
	STMFD		SP!, {R1-R10,LR}
	BL		getCurrentFramePtr
	LDR		R1, [R0, #0x8]
	ADD		R1, #0xC
	MOV		R2, #1
	BL		dumper_loc
	MOV		R0, #0x1000 //replaced opcode
	LDMFD		SP!, {R1-R10,PC}

dumper_end:
	.org ((dumper_end-dumper_begin)+dumper)

	.align 4
