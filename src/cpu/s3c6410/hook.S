
	.equ 	hook_target_loc, 0x5012120E
	.global hook_target_loc

	.equ	hook_loc, hook
	.global	hook_loc

	.equ	hook_size_val, (hook_end-hook)
	.global	hook_size_val

	.ALIGN 4
hook:
	.THUMB
	NOP
//	MOV.W	R2, #0
	MOV	R2, #0
//	BLX	dumper_loc
	LDR	R7, dumper_loc_a
	BLX	R7
hook_return:
//	NOP //BL  BadaPrint
//	NOP //MOV.W = 4bytes

//	NOP
//	NOP
//	NOP
	NOP
	NOP

	NOP
	NOP
	B	hook_end
	.align 4

dumper_loc_a:
	.word 	dumper_loc
hook_loc_a:
	.word 	hook_loc
	
	.align 4
hook_end:
//	.org ((hook_end-hook_begin)+hook)





