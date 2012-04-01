
	.THUMB

	.ALIGN 4
	.equ 	hook_loc, 0x5012120E

hook:
//	.org 	hook_loc
hook_begin:
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
hook_end:
//	.org ((hook_end-hook_begin)+hook)
	.align 4
hook_size:
	.word	(hook_end-hook_begin)




