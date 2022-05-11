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
	ori	$3, $2, 0
# was:	ori	_size_reg_9_, _letBind_2_, 0
	bgez	$3, _safe_lab_10_
# was:	bgez	_size_reg_9_, _safe_lab_10_
	ori	$5, $0, 10
# was:	ori	$5, $0, 10
	la	$6, _Msg_IllegalArraySize_
# was:	la	$6, _Msg_IllegalArraySize_
	j	_RuntimeError_
_safe_lab_10_:
	ori	$2, $28, 0
# was:	ori	_arr_reg_5_, $28, 0
	sll	$4, $3, 2
# was:	sll	_tmp_16_, _size_reg_9_, 2
	addi	$4, $4, 4
# was:	addi	_tmp_16_, _tmp_16_, 4
	add	$28, $28, $4
# was:	add	$28, $28, _tmp_16_
	sw	$3, 0($2)
# was:	sw	_size_reg_9_, 0(_arr_reg_5_)
	addi	$5, $2, 4
# was:	addi	_addr_reg_11_, _arr_reg_5_, 4
	ori	$6, $0, 0
# was:	ori	_i_reg_12_, $0, 0
_loop_beg_13_:
	sub	$4, $6, $3
# was:	sub	_tmp_reg_15_, _i_reg_12_, _size_reg_9_
	bgez	$4, _loop_end_14_
# was:	bgez	_tmp_reg_15_, _loop_end_14_
	sw	$6, 0($5)
# was:	sw	_i_reg_12_, 0(_addr_reg_11_)
	addi	$5, $5, 4
# was:	addi	_addr_reg_11_, _addr_reg_11_, 4
	addi	$6, $6, 1
# was:	addi	_i_reg_12_, _i_reg_12_, 1
	j	_loop_beg_13_
_loop_end_14_:
	lw	$5, 0($2)
# was:	lw	_size_reg_4_, 0(_arr_reg_5_)
	ori	$6, $28, 0
# was:	ori	_letBind_3_, $28, 0
	sll	$3, $5, 2
# was:	sll	_tmp_32_, _size_reg_4_, 2
	addi	$3, $3, 4
# was:	addi	_tmp_32_, _tmp_32_, 4
	add	$28, $28, $3
# was:	add	$28, $28, _tmp_32_
	sw	$5, 0($6)
# was:	sw	_size_reg_4_, 0(_letBind_3_)
	addi	$3, $6, 4
# was:	addi	_addr_reg_17_, _letBind_3_, 4
	addi	$2, $2, 4
# was:	addi	_arr_reg_5_, _arr_reg_5_, 4
	ori	$4, $0, 0
# was:	ori	_i_reg_18_, $0, 0
	ori	$7, $0, 0
# was:	ori	_count_reg_8_, $0, 0
_loop_beg_19_:
	sub	$8, $4, $5
# was:	sub	_tmp_reg_22_, _i_reg_18_, _size_reg_4_
	bgez	$8, _loop_end_20_
# was:	bgez	_tmp_reg_22_, _loop_end_20_
	lw	$10, 0($2)
# was:	lw	_elem_reg_6_, 0(_arr_reg_5_)
	addi	$2, $2, 4
# was:	addi	_arr_reg_5_, _arr_reg_5_, 4
# 	ori	_eq_L_24_,_elem_reg_6_,0
	ori	$9, $10, 0
# was:	ori	_div1_L_28_, _elem_reg_6_, 0
	ori	$8, $0, 2
# was:	ori	_div2_R_29_, $0, 2
	bne	$8, $0, _safe_div_30_
# was:	bne	_div2_R_29_, $0, _safe_div_30_
	ori	$5, $0, 10
# was:	ori	$5, $0, 10
	la	$6, _Msg_DivZero_
# was:	la	$6, _Msg_DivZero_
	j	_RuntimeError_
_safe_div_30_:
	div	$8, $9, $8
# was:	div	_mult1_L_26_, _div1_L_28_, _div2_R_29_
	ori	$9, $0, 2
# was:	ori	_mult2_R_27_, $0, 2
	mul	$8, $8, $9
# was:	mul	_eq_R_25_, _mult1_L_26_, _mult2_R_27_
	ori	$9, $0, 0
# was:	ori	_fun_arg_res_23_, $0, 0
	bne	$10, $8, _false_31_
# was:	bne	_eq_L_24_, _eq_R_25_, _false_31_
	ori	$9, $0, 1
# was:	ori	_fun_arg_res_23_, $0, 1
_false_31_:
# 	ori	_bool_reg_7_,_fun_arg_res_23_,0
	beq	$9, $0, _if_end_21_
# was:	beq	_bool_reg_7_, $0, _if_end_21_
	sw	$10, 0($3)
# was:	sw	_elem_reg_6_, 0(_addr_reg_17_)
	addi	$3, $3, 4
# was:	addi	_addr_reg_17_, _addr_reg_17_, 4
	addi	$7, $7, 1
# was:	addi	_count_reg_8_, _count_reg_8_, 1
_if_end_21_:
	addi	$4, $4, 1
# was:	addi	_i_reg_18_, _i_reg_18_, 1
	j	_loop_beg_19_
_loop_end_20_:
	sw	$7, 0($6)
# was:	sw	_count_reg_8_, 0(_letBind_3_)
	ori	$2, $6, 0
# was:	ori	_arr_reg_35_, _letBind_3_, 0
	lw	$3, 0($2)
# was:	lw	_size_reg_34_, 0(_arr_reg_35_)
	ori	$4, $28, 0
# was:	ori	_letBind_33_, $28, 0
	sll	$5, $3, 2
# was:	sll	_tmp_46_, _size_reg_34_, 2
	addi	$5, $5, 4
# was:	addi	_tmp_46_, _tmp_46_, 4
	add	$28, $28, $5
# was:	add	$28, $28, _tmp_46_
	sw	$3, 0($4)
# was:	sw	_size_reg_34_, 0(_letBind_33_)
	addi	$6, $4, 4
# was:	addi	_addr_reg_38_, _letBind_33_, 4
	ori	$5, $0, 0
# was:	ori	_i_reg_39_, $0, 0
	addi	$2, $2, 4
# was:	addi	_elem_reg_36_, _arr_reg_35_, 4
_loop_beg_40_:
	sub	$7, $5, $3
# was:	sub	_tmp_reg_42_, _i_reg_39_, _size_reg_34_
	bgez	$7, _loop_end_41_
# was:	bgez	_tmp_reg_42_, _loop_end_41_
	lw	$7, 0($2)
# was:	lw	_res_reg_37_, 0(_elem_reg_36_)
	addi	$2, $2, 4
# was:	addi	_elem_reg_36_, _elem_reg_36_, 4
	ori	$8, $7, 0
# was:	ori	_mult1_L_44_, _res_reg_37_, 0
# 	ori	_mult2_R_45_,_res_reg_37_,0
	mul	$7, $8, $7
# was:	mul	_fun_arg_res_43_, _mult1_L_44_, _mult2_R_45_
# 	ori	_res_reg_37_,_fun_arg_res_43_,0
	sw	$7, 0($6)
# was:	sw	_res_reg_37_, 0(_addr_reg_38_)
	addi	$6, $6, 4
# was:	addi	_addr_reg_38_, _addr_reg_38_, 4
	addi	$5, $5, 1
# was:	addi	_i_reg_39_, _i_reg_39_, 1
	j	_loop_beg_40_
_loop_end_41_:
	ori	$2, $4, 0
# was:	ori	_arr_reg_49_, _letBind_33_, 0
	lw	$3, 0($2)
# was:	lw	_size_reg_48_, 0(_arr_reg_49_)
	ori	$4, $28, 0
# was:	ori	_letBind_47_, $28, 0
	sll	$5, $3, 2
# was:	sll	_tmp_68_, _size_reg_48_, 2
	addi	$5, $5, 4
# was:	addi	_tmp_68_, _tmp_68_, 4
	add	$28, $28, $5
# was:	add	$28, $28, _tmp_68_
	sw	$3, 0($4)
# was:	sw	_size_reg_48_, 0(_letBind_47_)
	addi	$5, $4, 4
# was:	addi	_addr_reg_53_, _letBind_47_, 4
	addi	$2, $2, 4
# was:	addi	_arr_reg_49_, _arr_reg_49_, 4
	ori	$6, $0, 0
# was:	ori	_i_reg_54_, $0, 0
	ori	$7, $0, 0
# was:	ori	_count_reg_52_, $0, 0
_loop_beg_55_:
	sub	$8, $6, $3
# was:	sub	_tmp_reg_58_, _i_reg_54_, _size_reg_48_
	bgez	$8, _loop_end_56_
# was:	bgez	_tmp_reg_58_, _loop_end_56_
	lw	$8, 0($2)
# was:	lw	_elem_reg_50_, 0(_arr_reg_49_)
	addi	$2, $2, 4
# was:	addi	_arr_reg_49_, _arr_reg_49_, 4
# 	ori	_div1_L_64_,_elem_reg_50_,0
	ori	$9, $0, 16
# was:	ori	_div2_R_65_, $0, 16
	bne	$9, $0, _safe_div_66_
# was:	bne	_div2_R_65_, $0, _safe_div_66_
	ori	$5, $0, 6
# was:	ori	$5, $0, 6
	la	$6, _Msg_DivZero_
# was:	la	$6, _Msg_DivZero_
	j	_RuntimeError_
_safe_div_66_:
	div	$10, $8, $9
# was:	div	_mult1_L_62_, _div1_L_64_, _div2_R_65_
	ori	$9, $0, 16
# was:	ori	_mult2_R_63_, $0, 16
	mul	$10, $10, $9
# was:	mul	_eq_L_60_, _mult1_L_62_, _mult2_R_63_
# 	ori	_eq_R_61_,_elem_reg_50_,0
	ori	$9, $0, 0
# was:	ori	_fun_arg_res_59_, $0, 0
	bne	$10, $8, _false_67_
# was:	bne	_eq_L_60_, _eq_R_61_, _false_67_
	ori	$9, $0, 1
# was:	ori	_fun_arg_res_59_, $0, 1
_false_67_:
# 	ori	_bool_reg_51_,_fun_arg_res_59_,0
	beq	$9, $0, _if_end_57_
# was:	beq	_bool_reg_51_, $0, _if_end_57_
	sw	$8, 0($5)
# was:	sw	_elem_reg_50_, 0(_addr_reg_53_)
	addi	$5, $5, 4
# was:	addi	_addr_reg_53_, _addr_reg_53_, 4
	addi	$7, $7, 1
# was:	addi	_count_reg_52_, _count_reg_52_, 1
_if_end_57_:
	addi	$6, $6, 1
# was:	addi	_i_reg_54_, _i_reg_54_, 1
	j	_loop_beg_55_
_loop_end_56_:
	sw	$7, 0($4)
# was:	sw	_count_reg_52_, 0(_letBind_47_)
# 	ori	_arr_reg_70_,_letBind_47_,0
	lw	$16, 0($4)
# was:	lw	_size_reg_69_, 0(_arr_reg_70_)
	ori	$17, $28, 0
# was:	ori	_mainres_1_, $28, 0
	sll	$2, $16, 2
# was:	sll	_tmp_80_, _size_reg_69_, 2
	addi	$2, $2, 4
# was:	addi	_tmp_80_, _tmp_80_, 4
	add	$28, $28, $2
# was:	add	$28, $28, _tmp_80_
	sw	$16, 0($17)
# was:	sw	_size_reg_69_, 0(_mainres_1_)
	addi	$18, $17, 4
# was:	addi	_addr_reg_73_, _mainres_1_, 4
	ori	$19, $0, 0
# was:	ori	_i_reg_74_, $0, 0
	addi	$20, $4, 4
# was:	addi	_elem_reg_71_, _arr_reg_70_, 4
_loop_beg_75_:
	sub	$2, $19, $16
# was:	sub	_tmp_reg_77_, _i_reg_74_, _size_reg_69_
	bgez	$2, _loop_end_76_
# was:	bgez	_tmp_reg_77_, _loop_end_76_
	lw	$21, 0($20)
# was:	lw	_res_reg_72_, 0(_elem_reg_71_)
	addi	$20, $20, 4
# was:	addi	_elem_reg_71_, _elem_reg_71_, 4
# 	ori	_tmp_79_,_res_reg_72_,0
# 	ori	_fun_arg_res_78_,_tmp_79_,0
	ori	$2, $21, 0
# was:	ori	$2, _fun_arg_res_78_, 0
	jal	putint
# was:	jal	putint, $2
# 	ori	_res_reg_72_,_fun_arg_res_78_,0
	sw	$21, 0($18)
# was:	sw	_res_reg_72_, 0(_addr_reg_73_)
	addi	$18, $18, 4
# was:	addi	_addr_reg_73_, _addr_reg_73_, 4
	addi	$19, $19, 1
# was:	addi	_i_reg_74_, _i_reg_74_, 1
	j	_loop_beg_75_
_loop_end_76_:
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