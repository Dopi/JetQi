
	.global	hook2
	.align 4
	.equ	hook2_target_loc, 0x5039A93C
	.equ	hook2_loc, hook2
	.equ	hook2_size_val, (hook2_end-hook2_begin)
hook2_loc_a:
	.word	hook2_target_loc

hook2:
//	.org hook2_loc
hook2_begin:
	BL  tx_hook

hook2_end:
//	.org ((hook2_end-hook2_begin)+hook2)
	.align 4


