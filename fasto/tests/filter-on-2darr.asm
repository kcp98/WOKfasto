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
	sw	$25, -48($29)
	sw	$24, -44($29)
	sw	$23, -40($29)
	sw	$22, -36($29)
	sw	$21, -32($29)
	sw	$20, -28($29)
	sw	$19, -24($29)
	sw	$18, -20($29)
	sw	$17, -16($29)
	sw	$16, -12($29)
	addi	$29, $29, -52
	sw	$2, 0($29)
# was:	sw	_fun_arg_res_84_, 0($29)
	jal	getint
# was:	jal	getint, $2
# 	ori	_letBind_2_,$2,0
	ori	$3, $2, 0
# was:	ori	_size_reg_8_, _letBind_2_, 0
	bgez	$3, _safe_lab_9_
# was:	bgez	_size_reg_8_, _safe_lab_9_
	ori	$5, $0, 11
# was:	ori	$5, $0, 11
	la	$6, _Msg_IllegalArraySize_
# was:	la	$6, _Msg_IllegalArraySize_
	j	_RuntimeError_
_safe_lab_9_:
	ori	$2, $28, 0
# was:	ori	_arr_reg_5_, $28, 0
	sll	$4, $3, 2
# was:	sll	_tmp_15_, _size_reg_8_, 2
	addi	$4, $4, 4
# was:	addi	_tmp_15_, _tmp_15_, 4
	add	$28, $28, $4
# was:	add	$28, $28, _tmp_15_
	sw	$3, 0($2)
# was:	sw	_size_reg_8_, 0(_arr_reg_5_)
	addi	$4, $2, 4
# was:	addi	_addr_reg_10_, _arr_reg_5_, 4
	ori	$5, $0, 0
# was:	ori	_i_reg_11_, $0, 0
_loop_beg_12_:
	sub	$6, $5, $3
# was:	sub	_tmp_reg_14_, _i_reg_11_, _size_reg_8_
	bgez	$6, _loop_end_13_
# was:	bgez	_tmp_reg_14_, _loop_end_13_
	sw	$5, 0($4)
# was:	sw	_i_reg_11_, 0(_addr_reg_10_)
	addi	$4, $4, 4
# was:	addi	_addr_reg_10_, _addr_reg_10_, 4
	addi	$5, $5, 1
# was:	addi	_i_reg_11_, _i_reg_11_, 1
	j	_loop_beg_12_
_loop_end_13_:
	lw	$5, 0($2)
# was:	lw	_size_reg_4_, 0(_arr_reg_5_)
	ori	$4, $28, 0
# was:	ori	_letBind_3_, $28, 0
	sll	$3, $5, 2
# was:	sll	_tmp_32_, _size_reg_4_, 2
	addi	$3, $3, 4
# was:	addi	_tmp_32_, _tmp_32_, 4
	add	$28, $28, $3
# was:	add	$28, $28, _tmp_32_
	sw	$5, 0($4)
# was:	sw	_size_reg_4_, 0(_letBind_3_)
	addi	$6, $4, 4
# was:	addi	_addr_reg_16_, _letBind_3_, 4
	ori	$7, $0, 0
# was:	ori	_i_reg_17_, $0, 0
	addi	$3, $2, 4
# was:	addi	_elem_reg_6_, _arr_reg_5_, 4
_loop_beg_18_:
	sub	$2, $7, $5
# was:	sub	_tmp_reg_20_, _i_reg_17_, _size_reg_4_
	bgez	$2, _loop_end_19_
# was:	bgez	_tmp_reg_20_, _loop_end_19_
	lw	$8, 0($3)
# was:	lw	_res_reg_7_, 0(_elem_reg_6_)
	addi	$3, $3, 4
# was:	addi	_elem_reg_6_, _elem_reg_6_, 4
# 	ori	_plus_L_23_,_res_reg_7_,0
	ori	$2, $0, 2
# was:	ori	_plus_R_24_, $0, 2
	add	$2, $8, $2
# was:	add	_size_reg_22_, _plus_L_23_, _plus_R_24_
	bgez	$2, _safe_lab_25_
# was:	bgez	_size_reg_22_, _safe_lab_25_
	ori	$5, $0, 10
# was:	ori	$5, $0, 10
	la	$6, _Msg_IllegalArraySize_
# was:	la	$6, _Msg_IllegalArraySize_
	j	_RuntimeError_
_safe_lab_25_:
	ori	$8, $28, 0
# was:	ori	_fun_arg_res_21_, $28, 0
	sll	$9, $2, 2
# was:	sll	_tmp_31_, _size_reg_22_, 2
	addi	$9, $9, 4
# was:	addi	_tmp_31_, _tmp_31_, 4
	add	$28, $28, $9
# was:	add	$28, $28, _tmp_31_
	sw	$2, 0($8)
# was:	sw	_size_reg_22_, 0(_fun_arg_res_21_)
	addi	$10, $8, 4
# was:	addi	_addr_reg_26_, _fun_arg_res_21_, 4
	ori	$9, $0, 0
# was:	ori	_i_reg_27_, $0, 0
_loop_beg_28_:
	sub	$11, $9, $2
# was:	sub	_tmp_reg_30_, _i_reg_27_, _size_reg_22_
	bgez	$11, _loop_end_29_
# was:	bgez	_tmp_reg_30_, _loop_end_29_
	sw	$9, 0($10)
# was:	sw	_i_reg_27_, 0(_addr_reg_26_)
	addi	$10, $10, 4
# was:	addi	_addr_reg_26_, _addr_reg_26_, 4
	addi	$9, $9, 1
# was:	addi	_i_reg_27_, _i_reg_27_, 1
	j	_loop_beg_28_
_loop_end_29_:
# 	ori	_res_reg_7_,_fun_arg_res_21_,0
	sw	$8, 0($6)
# was:	sw	_res_reg_7_, 0(_addr_reg_16_)
	addi	$6, $6, 4
# was:	addi	_addr_reg_16_, _addr_reg_16_, 4
	addi	$7, $7, 1
# was:	addi	_i_reg_17_, _i_reg_17_, 1
	j	_loop_beg_18_
_loop_end_19_:
	ori	$3, $4, 0
# was:	ori	_arr_reg_35_, _letBind_3_, 0
	lw	$2, 0($3)
# was:	lw	_size_reg_34_, 0(_arr_reg_35_)
	ori	$4, $28, 0
# was:	ori	_letBind_33_, $28, 0
	sll	$5, $2, 2
# was:	sll	_tmp_64_, _size_reg_34_, 2
	addi	$5, $5, 4
# was:	addi	_tmp_64_, _tmp_64_, 4
	add	$28, $28, $5
# was:	add	$28, $28, _tmp_64_
	sw	$2, 0($4)
# was:	sw	_size_reg_34_, 0(_letBind_33_)
	addi	$6, $4, 4
# was:	addi	_addr_reg_39_, _letBind_33_, 4
	addi	$3, $3, 4
# was:	addi	_arr_reg_35_, _arr_reg_35_, 4
	ori	$5, $0, 0
# was:	ori	_i_reg_40_, $0, 0
	ori	$7, $0, 0
# was:	ori	_count_reg_38_, $0, 0
_loop_beg_41_:
	sub	$8, $5, $2
# was:	sub	_tmp_reg_44_, _i_reg_40_, _size_reg_34_
	bgez	$8, _loop_end_42_
# was:	bgez	_tmp_reg_44_, _loop_end_42_
	lw	$8, 0($3)
# was:	lw	_elem_reg_36_, 0(_arr_reg_35_)
	addi	$3, $3, 4
# was:	addi	_arr_reg_35_, _arr_reg_35_, 4
	ori	$10, $8, 0
# was:	ori	_arr_reg_47_, _elem_reg_36_, 0
	lw	$11, 0($10)
# was:	lw	_size_reg_48_, 0(_arr_reg_47_)
	ori	$13, $0, 0
# was:	ori	_letBind_46_, $0, 0
	addi	$10, $10, 4
# was:	addi	_arr_reg_47_, _arr_reg_47_, 4
	ori	$9, $0, 0
# was:	ori	_ind_var_49_, $0, 0
_loop_beg_51_:
	sub	$12, $9, $11
# was:	sub	_tmp_reg_50_, _ind_var_49_, _size_reg_48_
	bgez	$12, _loop_end_52_
# was:	bgez	_tmp_reg_50_, _loop_end_52_
	lw	$12, 0($10)
# was:	lw	_tmp_reg_50_, 0(_arr_reg_47_)
	addi	$10, $10, 4
# was:	addi	_arr_reg_47_, _arr_reg_47_, 4
# 	ori	_plus_L_54_,_letBind_46_,0
# 	ori	_plus_R_55_,_tmp_reg_50_,0
	add	$13, $13, $12
# was:	add	_fun_arg_res_53_, _plus_L_54_, _plus_R_55_
# 	ori	_letBind_46_,_fun_arg_res_53_,0
	addi	$9, $9, 1
# was:	addi	_ind_var_49_, _ind_var_49_, 1
	j	_loop_beg_51_
_loop_end_52_:
# 	ori	_div1_L_60_,_letBind_46_,0
	ori	$9, $0, 2
# was:	ori	_div2_R_61_, $0, 2
	bne	$9, $0, _safe_div_62_
# was:	bne	_div2_R_61_, $0, _safe_div_62_
	ori	$5, $0, 6
# was:	ori	$5, $0, 6
	la	$6, _Msg_DivZero_
# was:	la	$6, _Msg_DivZero_
	j	_RuntimeError_
_safe_div_62_:
	div	$10, $13, $9
# was:	div	_mult1_L_58_, _div1_L_60_, _div2_R_61_
	ori	$9, $0, 2
# was:	ori	_mult2_R_59_, $0, 2
	mul	$9, $10, $9
# was:	mul	_eq_L_56_, _mult1_L_58_, _mult2_R_59_
# 	ori	_eq_R_57_,_letBind_46_,0
	ori	$10, $0, 0
# was:	ori	_fun_arg_res_45_, $0, 0
	bne	$9, $13, _false_63_
# was:	bne	_eq_L_56_, _eq_R_57_, _false_63_
	ori	$10, $0, 1
# was:	ori	_fun_arg_res_45_, $0, 1
_false_63_:
# 	ori	_bool_reg_37_,_fun_arg_res_45_,0
	beq	$10, $0, _if_end_43_
# was:	beq	_bool_reg_37_, $0, _if_end_43_
	sw	$8, 0($6)
# was:	sw	_elem_reg_36_, 0(_addr_reg_39_)
	addi	$6, $6, 4
# was:	addi	_addr_reg_39_, _addr_reg_39_, 4
	addi	$7, $7, 1
# was:	addi	_count_reg_38_, _count_reg_38_, 1
_if_end_43_:
	addi	$5, $5, 1
# was:	addi	_i_reg_40_, _i_reg_40_, 1
	j	_loop_beg_41_
_loop_end_42_:
	sw	$7, 0($4)
# was:	sw	_count_reg_38_, 0(_letBind_33_)
# 	ori	_arr_reg_66_,_letBind_33_,0
	lw	$17, 0($4)
# was:	lw	_size_reg_65_, 0(_arr_reg_66_)
	ori	$16, $28, 0
# was:	ori	_mainres_1_, $28, 0
	sll	$2, $17, 2
# was:	sll	_tmp_87_, _size_reg_65_, 2
	addi	$2, $2, 4
# was:	addi	_tmp_87_, _tmp_87_, 4
	add	$28, $28, $2
# was:	add	$28, $28, _tmp_87_
	sw	$17, 0($16)
# was:	sw	_size_reg_65_, 0(_mainres_1_)
	addi	$19, $16, 4
# was:	addi	_addr_reg_69_, _mainres_1_, 4
	ori	$18, $0, 0
# was:	ori	_i_reg_70_, $0, 0
	addi	$20, $4, 4
# was:	addi	_elem_reg_67_, _arr_reg_66_, 4
_loop_beg_71_:
	sub	$2, $18, $17
# was:	sub	_tmp_reg_73_, _i_reg_70_, _size_reg_65_
	bgez	$2, _loop_end_72_
# was:	bgez	_tmp_reg_73_, _loop_end_72_
	lw	$2, 0($20)
# was:	lw	_res_reg_68_, 0(_elem_reg_67_)
	addi	$20, $20, 4
# was:	addi	_elem_reg_67_, _elem_reg_67_, 4
# 	ori	_arr_reg_76_,_res_reg_68_,0
	lw	$22, 0($2)
# was:	lw	_size_reg_75_, 0(_arr_reg_76_)
	ori	$21, $28, 0
# was:	ori	_fun_arg_res_74_, $28, 0
	sll	$3, $22, 2
# was:	sll	_tmp_86_, _size_reg_75_, 2
	addi	$3, $3, 4
# was:	addi	_tmp_86_, _tmp_86_, 4
	add	$28, $28, $3
# was:	add	$28, $28, _tmp_86_
	sw	$22, 0($21)
# was:	sw	_size_reg_75_, 0(_fun_arg_res_74_)
	addi	$23, $21, 4
# was:	addi	_addr_reg_79_, _fun_arg_res_74_, 4
	ori	$24, $0, 0
# was:	ori	_i_reg_80_, $0, 0
	addi	$25, $2, 4
# was:	addi	_elem_reg_77_, _arr_reg_76_, 4
_loop_beg_81_:
	sub	$2, $24, $22
# was:	sub	_tmp_reg_83_, _i_reg_80_, _size_reg_75_
	bgez	$2, _loop_end_82_
# was:	bgez	_tmp_reg_83_, _loop_end_82_
	lw	$2, 0($25)
# was:	lw	_res_reg_78_, 0(_elem_reg_77_)
	addi	$25, $25, 4
# was:	addi	_elem_reg_77_, _elem_reg_77_, 4
# 	ori	_tmp_85_,_res_reg_78_,0
# 	ori	_fun_arg_res_84_,_tmp_85_,0
	sw	$2, 0($29)
# was:	sw	_fun_arg_res_84_, 0($29)
	lw	$2, 0($29)
# was:	lw	_fun_arg_res_84_, 0($29)
# 	ori	$2,_fun_arg_res_84_,0
	jal	putint
# was:	jal	putint, $2
	lw	$2, 0($29)
# was:	lw	_fun_arg_res_84_, 0($29)
# 	ori	_res_reg_78_,_fun_arg_res_84_,0
	sw	$2, 0($23)
# was:	sw	_res_reg_78_, 0(_addr_reg_79_)
	addi	$23, $23, 4
# was:	addi	_addr_reg_79_, _addr_reg_79_, 4
	addi	$24, $24, 1
# was:	addi	_i_reg_80_, _i_reg_80_, 1
	j	_loop_beg_81_
_loop_end_82_:
	ori	$2, $21, 0
# was:	ori	_res_reg_68_, _fun_arg_res_74_, 0
	sw	$2, 0($19)
# was:	sw	_res_reg_68_, 0(_addr_reg_69_)
	addi	$19, $19, 4
# was:	addi	_addr_reg_69_, _addr_reg_69_, 4
	addi	$18, $18, 1
# was:	addi	_i_reg_70_, _i_reg_70_, 1
	j	_loop_beg_71_
_loop_end_72_:
	ori	$2, $16, 0
# was:	ori	$2, _mainres_1_, 0
	addi	$29, $29, 52
	lw	$25, -48($29)
	lw	$24, -44($29)
	lw	$23, -40($29)
	lw	$22, -36($29)
	lw	$21, -32($29)
	lw	$20, -28($29)
	lw	$19, -24($29)
	lw	$18, -20($29)
	lw	$17, -16($29)
	lw	$16, -12($29)
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