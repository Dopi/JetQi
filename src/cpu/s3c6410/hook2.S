
	.equ	hook2_target_loc, 0x5039A93C
	.global	hook2_target_loc

	.equ	hook2_loc, hook2
	.global	hook2_loc

	.equ	hook2_size_val, (hook2_end-hook2)
	.global	hook2_size_val

	.align 4
hook2:
	BL  	tx_hook
//	BL	hook2_end:
hook2_loc_a:
	.word	hook2_target_loc

	.align 4
hook2_end:
//	.org ((hook2_end-hook2_begin)+hook2)



