	.align 4
#define hook2_loc 0x5039A93C
hook2_loc_a:
	.word	hook2_loc
hook2:
//	.org hook2_loc
hook2_begin:
	BL  tx_hook

hook2_end:
//	.org ((hook2_end-hook2_begin)+hook2)
	.align 4

#define hook2_size (hook2_end-hook2_begin)

