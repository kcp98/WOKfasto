	.text	0x00400000
	.globl	main
	la	$28, _heap_
	la	$4, _true
# was:	la	_true_addr, _true
	ori	$3, $0, 4
# was:	ori	_true_init, $0, 4
	sw	$3, 0($4)
# was:	sw	_true_init, 0(_true_addr)
	la	$3, _false
# was:	la	_false_addr, _false
	ori	$4, $0, 5
# was:	ori	_false_init, $0, 5
	sw	$4, 0($3)
# was:	sw	_false_init, 0(_false_addr)
	jal	main
_stop_:
	ori	$2, $0, 10
	syscall
# Function main
main:
	sw	$31, -4($29)
	sw	$21, -28($29)
	sw	$20, -24($29)
	sw	$19, -20($29)
	sw	$18, -16($29)
	sw	$17, -12($29)
	sw	$16, -8($29)
	addi	$29, $29, -32
	jal	getint
# was:	jal	getint, $2
# 	ori	_letBind_2_,$2,0
# 	ori	_size_reg_4_,_letBind_2_,0
	bgez	$2, _safe_lab_5_
# was:	bgez	_size_reg_4_, _safe_lab_5_
	ori	$5, $0, 15
# was:	ori	$5, $0, 15
	la	$6, _Msg_IllegalArraySize_
# was:	la	$6, _Msg_IllegalArraySize_
	j	_RuntimeError_
_safe_lab_5_:
	ori	$3, $28, 0
# was:	ori	_letBind_3_, $28, 0
	sll	$4, $2, 2
# was:	sll	_tmp_11_, _size_reg_4_, 2
	addi	$4, $4, 4
# was:	addi	_tmp_11_, _tmp_11_, 4
	add	$28, $28, $4
# was:	add	$28, $28, _tmp_11_
	sw	$2, 0($3)
# was:	sw	_size_reg_4_, 0(_letBind_3_)
	addi	$6, $3, 4
# was:	addi	_addr_reg_6_, _letBind_3_, 4
	ori	$5, $0, 0
# was:	ori	_i_reg_7_, $0, 0
_loop_beg_8_:
	sub	$4, $5, $2
# was:	sub	_tmp_reg_10_, _i_reg_7_, _size_reg_4_
	bgez	$4, _loop_end_9_
# was:	bgez	_tmp_reg_10_, _loop_end_9_
	sw	$5, 0($6)
# was:	sw	_i_reg_7_, 0(_addr_reg_6_)
	addi	$6, $6, 4
# was:	addi	_addr_reg_6_, _addr_reg_6_, 4
	addi	$5, $5, 1
# was:	addi	_i_reg_7_, _i_reg_7_, 1
	j	_loop_beg_8_
_loop_end_9_:
	ori	$2, $3, 0
# was:	ori	_arr_reg_14_, _letBind_3_, 0
	lw	$4, 0($2)
# was:	lw	_size_reg_13_, 0(_arr_reg_14_)
	ori	$6, $28, 0
# was:	ori	_letBind_12_, $28, 0
	sll	$3, $4, 2
# was:	sll	_tmp_25_, _size_reg_13_, 2
	addi	$3, $3, 4
# was:	addi	_tmp_25_, _tmp_25_, 4
	add	$28, $28, $3
# was:	add	$28, $28, _tmp_25_
	sw	$4, 0($6)
# was:	sw	_size_reg_13_, 0(_letBind_12_)
	addi	$3, $6, 4
# was:	addi	_addr_reg_17_, _letBind_12_, 4
	ori	$5, $0, 0
# was:	ori	_i_reg_18_, $0, 0
	addi	$7, $2, 4
# was:	addi	_elem_reg_15_, _arr_reg_14_, 4
_loop_beg_19_:
	sub	$2, $5, $4
# was:	sub	_tmp_reg_21_, _i_reg_18_, _size_reg_13_
	bgez	$2, _loop_end_20_
# was:	bgez	_tmp_reg_21_, _loop_end_20_
	lw	$2, 0($7)
# was:	lw	_res_reg_16_, 0(_elem_reg_15_)
	addi	$7, $7, 4
# was:	addi	_elem_reg_15_, _elem_reg_15_, 4
	ori	$8, $2, 0
# was:	ori	_plus_L_23_, _res_reg_16_, 0
	ori	$2, $0, 5
# was:	ori	_plus_R_24_, $0, 5
	add	$2, $8, $2
# was:	add	_fun_arg_res_22_, _plus_L_23_, _plus_R_24_
# 	ori	_res_reg_16_,_fun_arg_res_22_,0
	sw	$2, 0($3)
# was:	sw	_res_reg_16_, 0(_addr_reg_17_)
	addi	$3, $3, 4
# was:	addi	_addr_reg_17_, _addr_reg_17_, 4
	addi	$5, $5, 1
# was:	addi	_i_reg_18_, _i_reg_18_, 1
	j	_loop_beg_19_
_loop_end_20_:
	ori	$2, $6, 0
# was:	ori	_arr_reg_28_, _letBind_12_, 0
	lw	$4, 0($2)
# was:	lw	_size_reg_27_, 0(_arr_reg_28_)
	ori	$5, $28, 0
# was:	ori	_letBind_26_, $28, 0
	sll	$3, $4, 2
# was:	sll	_tmp_39_, _size_reg_27_, 2
	addi	$3, $3, 4
# was:	addi	_tmp_39_, _tmp_39_, 4
	add	$28, $28, $3
# was:	add	$28, $28, _tmp_39_
	sw	$4, 0($5)
# was:	sw	_size_reg_27_, 0(_letBind_26_)
	addi	$3, $5, 4
# was:	addi	_addr_reg_31_, _letBind_26_, 4
	ori	$6, $0, 0
# was:	ori	_i_reg_32_, $0, 0
	addi	$7, $2, 4
# was:	addi	_elem_reg_29_, _arr_reg_28_, 4
_loop_beg_33_:
	sub	$2, $6, $4
# was:	sub	_tmp_reg_35_, _i_reg_32_, _size_reg_27_
	bgez	$2, _loop_end_34_
# was:	bgez	_tmp_reg_35_, _loop_end_34_
	lw	$2, 0($7)
# was:	lw	_res_reg_30_, 0(_elem_reg_29_)
	addi	$7, $7, 4
# was:	addi	_elem_reg_29_, _elem_reg_29_, 4
	ori	$8, $2, 0
# was:	ori	_plus_L_37_, _res_reg_30_, 0
# 	ori	_plus_R_38_,_res_reg_30_,0
	add	$2, $8, $2
# was:	add	_fun_arg_res_36_, _plus_L_37_, _plus_R_38_
# 	ori	_res_reg_30_,_fun_arg_res_36_,0
	sw	$2, 0($3)
# was:	sw	_res_reg_30_, 0(_addr_reg_31_)
	addi	$3, $3, 4
# was:	addi	_addr_reg_31_, _addr_reg_31_, 4
	addi	$6, $6, 1
# was:	addi	_i_reg_32_, _i_reg_32_, 1
	j	_loop_beg_33_
_loop_end_34_:
# 	ori	_arr_reg_41_,_letBind_26_,0
	lw	$16, 0($5)
# was:	lw	_size_reg_40_, 0(_arr_reg_41_)
	ori	$17, $28, 0
# was:	ori	_mainres_1_, $28, 0
	sll	$2, $16, 2
# was:	sll	_tmp_51_, _size_reg_40_, 2
	addi	$2, $2, 4
# was:	addi	_tmp_51_, _tmp_51_, 4
	add	$28, $28, $2
# was:	add	$28, $28, _tmp_51_
	sw	$16, 0($17)
# was:	sw	_size_reg_40_, 0(_mainres_1_)
	addi	$18, $17, 4
# was:	addi	_addr_reg_44_, _mainres_1_, 4
	ori	$19, $0, 0
# was:	ori	_i_reg_45_, $0, 0
	addi	$20, $5, 4
# was:	addi	_elem_reg_42_, _arr_reg_41_, 4
_loop_beg_46_:
	sub	$2, $19, $16
# was:	sub	_tmp_reg_48_, _i_reg_45_, _size_reg_40_
	bgez	$2, _loop_end_47_
# was:	bgez	_tmp_reg_48_, _loop_end_47_
	lw	$21, 0($20)
# was:	lw	_res_reg_43_, 0(_elem_reg_42_)
	addi	$20, $20, 4
# was:	addi	_elem_reg_42_, _elem_reg_42_, 4
# 	ori	_tmp_50_,_res_reg_43_,0
# 	ori	_fun_arg_res_49_,_tmp_50_,0
	ori	$2, $21, 0
# was:	ori	$2, _fun_arg_res_49_, 0
	jal	putint
# was:	jal	putint, $2
# 	ori	_res_reg_43_,_fun_arg_res_49_,0
	sw	$21, 0($18)
# was:	sw	_res_reg_43_, 0(_addr_reg_44_)
	addi	$18, $18, 4
# was:	addi	_addr_reg_44_, _addr_reg_44_, 4
	addi	$19, $19, 1
# was:	addi	_i_reg_45_, _i_reg_45_, 1
	j	_loop_beg_46_
_loop_end_47_:
	ori	$2, $17, 0
# was:	ori	$2, _mainres_1_, 0
	addi	$29, $29, 32
	lw	$21, -28($29)
	lw	$20, -24($29)
	lw	$19, -20($29)
	lw	$18, -16($29)
	lw	$17, -12($29)
	lw	$16, -8($29)
	lw	$31, -4($29)
	jr	$31
ord:
	jr	$31
chr:
	andi	$2, $2, 255
	jr	$31
putint:
	addi	$29, $29, -8
	sw	$2, 0($29)
	sw	$4, 4($29)
	ori	$4, $2, 0
	ori	$2, $0, 1
	syscall
	ori	$2, $0, 4
	la	$4, _space_
	syscall
	lw	$2, 0($29)
	lw	$4, 4($29)
	addi	$29, $29, 8
	jr	$31
getint:
	ori	$2, $0, 5
	syscall
	jr	$31
putchar:
	addi	$29, $29, -8
	sw	$2, 0($29)
	sw	$4, 4($29)
	ori	$4, $2, 0
	ori	$2, $0, 11
	syscall
	ori	$2, $0, 4
	la	$4, _space_
	syscall
	lw	$2, 0($29)
	lw	$4, 4($29)
	addi	$29, $29, 8
	jr	$31
getchar:
	addi	$29, $29, -8
	sw	$4, 0($29)
	sw	$5, 4($29)
	ori	$2, $0, 12
	syscall
	ori	$5, $2, 0
	ori	$2, $0, 4
	la	$4, _cr_
	syscall
	ori	$2, $5, 0
	lw	$4, 0($29)
	lw	$5, 4($29)
	addi	$29, $29, 8
	jr	$31
putstring:
	addi	$29, $29, -16
	sw	$2, 0($29)
	sw	$4, 4($29)
	sw	$5, 8($29)
	sw	$6, 12($29)
	lw	$4, 0($2)
	addi	$5, $2, 4
	add	$6, $5, $4
	ori	$2, $0, 11
putstring_begin:
	sub	$4, $5, $6
	bgez	$4, putstring_done
	lb	$4, 0($5)
	syscall
	addi	$5, $5, 1
	j	putstring_begin
putstring_done:
	lw	$2, 0($29)
	lw	$4, 4($29)
	lw	$5, 8($29)
	lw	$6, 12($29)
	addi	$29, $29, 16
	jr	$31
_RuntimeError_:
	la	$4, _ErrMsg_
	ori	$2, $0, 4
	syscall
	ori	$4, $5, 0
	ori	$2, $0, 1
	syscall
	la	$4, _colon_space_
	ori	$2, $0, 4
	syscall
	ori	$4, $6, 0
	ori	$2, $0, 4
	syscall
	la	$4, _cr_
	ori	$2, $0, 4
	syscall
	j	_stop_
	.data	
# Fixed strings for I/O
_ErrMsg_:
	.asciiz	"Runtime error at line "
_colon_space_:
	.asciiz	": "
_cr_:
	.asciiz	"\n"
_space_:
	.asciiz	" "
# Message strings for specific errors
_Msg_IllegalArraySize_:
	.asciiz	"negative array size"
_Msg_IllegalIndex_:
	.asciiz	"array index out of bounds"
_Msg_DivZero_:
	.asciiz	"division by zero"
# String Literals
	.align	2
_true:
	.space	4
	.asciiz	"true"
	.align	2
_false:
	.space	4
	.asciiz	"false"
	.align	2
_heap_:
	.space	100000