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
	ori	$5, $2, 0
# was:	ori	_letBind_2_, $2, 0
# 	ori	_size_reg_4_,_letBind_2_,0
	bgez	$5, _safe_lab_5_
# was:	bgez	_size_reg_4_, _safe_lab_5_
	ori	$5, $0, 6
# was:	ori	$5, $0, 6
	la	$6, _Msg_IllegalArraySize_
# was:	la	$6, _Msg_IllegalArraySize_
	j	_RuntimeError_
_safe_lab_5_:
	ori	$9, $28, 0
# was:	ori	_letBind_3_, $28, 0
	sll	$2, $5, 2
# was:	sll	_tmp_11_, _size_reg_4_, 2
	addi	$2, $2, 4
# was:	addi	_tmp_11_, _tmp_11_, 4
	add	$28, $28, $2
# was:	add	$28, $28, _tmp_11_
	sw	$5, 0($9)
# was:	sw	_size_reg_4_, 0(_letBind_3_)
	addi	$4, $9, 4
# was:	addi	_addr_reg_6_, _letBind_3_, 4
	ori	$2, $0, 0
# was:	ori	_i_reg_7_, $0, 0
_loop_beg_8_:
	sub	$3, $2, $5
# was:	sub	_tmp_reg_10_, _i_reg_7_, _size_reg_4_
	bgez	$3, _loop_end_9_
# was:	bgez	_tmp_reg_10_, _loop_end_9_
	sw	$2, 0($4)
# was:	sw	_i_reg_7_, 0(_addr_reg_6_)
	addi	$4, $4, 4
# was:	addi	_addr_reg_6_, _addr_reg_6_, 4
	addi	$2, $2, 1
# was:	addi	_i_reg_7_, _i_reg_7_, 1
	j	_loop_beg_8_
_loop_end_9_:
	ori	$2, $5, 0
# was:	ori	_size_reg_13_, _letBind_2_, 0
	bgez	$2, _safe_lab_14_
# was:	bgez	_size_reg_13_, _safe_lab_14_
	ori	$5, $0, 7
# was:	ori	$5, $0, 7
	la	$6, _Msg_IllegalArraySize_
# was:	la	$6, _Msg_IllegalArraySize_
	j	_RuntimeError_
_safe_lab_14_:
	ori	$8, $28, 0
# was:	ori	_letBind_12_, $28, 0
	sll	$3, $2, 2
# was:	sll	_tmp_20_, _size_reg_13_, 2
	addi	$3, $3, 4
# was:	addi	_tmp_20_, _tmp_20_, 4
	add	$28, $28, $3
# was:	add	$28, $28, _tmp_20_
	sw	$2, 0($8)
# was:	sw	_size_reg_13_, 0(_letBind_12_)
	addi	$5, $8, 4
# was:	addi	_addr_reg_15_, _letBind_12_, 4
	ori	$4, $0, 0
# was:	ori	_i_reg_16_, $0, 0
_loop_beg_17_:
	sub	$3, $4, $2
# was:	sub	_tmp_reg_19_, _i_reg_16_, _size_reg_13_
	bgez	$3, _loop_end_18_
# was:	bgez	_tmp_reg_19_, _loop_end_18_
	sw	$4, 0($5)
# was:	sw	_i_reg_16_, 0(_addr_reg_15_)
	addi	$5, $5, 4
# was:	addi	_addr_reg_15_, _addr_reg_15_, 4
	addi	$4, $4, 1
# was:	addi	_i_reg_16_, _i_reg_16_, 1
	j	_loop_beg_17_
_loop_end_18_:
# 	ori	_len_arr_24_,_letBind_3_,0
	lw	$2, 0($9)
# was:	lw	_mult1_L_22_, 0(_len_arr_24_)
# 	ori	_len_arr_25_,_letBind_12_,0
	lw	$3, 0($8)
# was:	lw	_mult2_R_23_, 0(_len_arr_25_)
	mul	$2, $2, $3
# was:	mul	_letBind_21_, _mult1_L_22_, _mult2_R_23_
# 	ori	_size_reg_31_,_letBind_21_,0
	bgez	$2, _safe_lab_32_
# was:	bgez	_size_reg_31_, _safe_lab_32_
	ori	$5, $0, 8
# was:	ori	$5, $0, 8
	la	$6, _Msg_IllegalArraySize_
# was:	la	$6, _Msg_IllegalArraySize_
	j	_RuntimeError_
_safe_lab_32_:
	ori	$7, $28, 0
# was:	ori	_arr_reg_28_, $28, 0
	sll	$3, $2, 2
# was:	sll	_tmp_38_, _size_reg_31_, 2
	addi	$3, $3, 4
# was:	addi	_tmp_38_, _tmp_38_, 4
	add	$28, $28, $3
# was:	add	$28, $28, _tmp_38_
	sw	$2, 0($7)
# was:	sw	_size_reg_31_, 0(_arr_reg_28_)
	addi	$5, $7, 4
# was:	addi	_addr_reg_33_, _arr_reg_28_, 4
	ori	$4, $0, 0
# was:	ori	_i_reg_34_, $0, 0
_loop_beg_35_:
	sub	$3, $4, $2
# was:	sub	_tmp_reg_37_, _i_reg_34_, _size_reg_31_
	bgez	$3, _loop_end_36_
# was:	bgez	_tmp_reg_37_, _loop_end_36_
	sw	$4, 0($5)
# was:	sw	_i_reg_34_, 0(_addr_reg_33_)
	addi	$5, $5, 4
# was:	addi	_addr_reg_33_, _addr_reg_33_, 4
	addi	$4, $4, 1
# was:	addi	_i_reg_34_, _i_reg_34_, 1
	j	_loop_beg_35_
_loop_end_36_:
	lw	$3, 0($7)
# was:	lw	_size_reg_27_, 0(_arr_reg_28_)
	ori	$4, $28, 0
# was:	ori	_letBind_26_, $28, 0
	sll	$5, $3, 2
# was:	sll	_tmp_88_, _size_reg_27_, 2
	addi	$5, $5, 4
# was:	addi	_tmp_88_, _tmp_88_, 4
	add	$28, $28, $5
# was:	add	$28, $28, _tmp_88_
	sw	$3, 0($4)
# was:	sw	_size_reg_27_, 0(_letBind_26_)
	addi	$6, $4, 4
# was:	addi	_addr_reg_39_, _letBind_26_, 4
	ori	$5, $0, 0
# was:	ori	_i_reg_40_, $0, 0
	addi	$7, $7, 4
# was:	addi	_elem_reg_29_, _arr_reg_28_, 4
_loop_beg_41_:
	sub	$10, $5, $3
# was:	sub	_tmp_reg_43_, _i_reg_40_, _size_reg_27_
	bgez	$10, _loop_end_42_
# was:	bgez	_tmp_reg_43_, _loop_end_42_
	lw	$11, 0($7)
# was:	lw	_res_reg_30_, 0(_elem_reg_29_)
	addi	$7, $7, 4
# was:	addi	_elem_reg_29_, _elem_reg_29_, 4
# 	ori	_div1_L_46_,_letBind_21_,0
# 	ori	_len_arr_49_,_letBind_12_,0
	lw	$10, 0($8)
# was:	lw	_div2_R_47_, 0(_len_arr_49_)
	bne	$10, $0, _safe_div_48_
# was:	bne	_div2_R_47_, $0, _safe_div_48_
	ori	$5, $0, 8
# was:	ori	$5, $0, 8
	la	$6, _Msg_DivZero_
# was:	la	$6, _Msg_DivZero_
	j	_RuntimeError_
_safe_div_48_:
	div	$10, $2, $10
# was:	div	_letBind_45_, _div1_L_46_, _div2_R_47_
# 	ori	_div1_L_51_,_res_reg_30_,0
# 	ori	_div2_R_52_,_letBind_45_,0
	bne	$10, $0, _safe_div_53_
# was:	bne	_div2_R_52_, $0, _safe_div_53_
	ori	$5, $0, 8
# was:	ori	$5, $0, 8
	la	$6, _Msg_DivZero_
# was:	la	$6, _Msg_DivZero_
	j	_RuntimeError_
_safe_div_53_:
	div	$13, $11, $10
# was:	div	_letBind_50_, _div1_L_51_, _div2_R_52_
# 	ori	_minus_L_55_,_res_reg_30_,0
# 	ori	_mult1_L_57_,_letBind_50_,0
# 	ori	_mult2_R_58_,_letBind_45_,0
	mul	$12, $13, $10
# was:	mul	_minus_R_56_, _mult1_L_57_, _mult2_R_58_
	sub	$11, $11, $12
# was:	sub	_letBind_54_, _minus_L_55_, _minus_R_56_
# 	ori	_arr_ind_60_,_letBind_50_,0
	addi	$12, $8, 4
# was:	addi	_arr_reg_61_, _letBind_12_, 4
	lw	$14, 0($8)
# was:	lw	_size_reg_62_, 0(_letBind_12_)
	bgez	$13, _safe_lab_65_
# was:	bgez	_arr_ind_60_, _safe_lab_65_
_error_lab_64_:
	ori	$5, $0, 8
# was:	ori	$5, $0, 8
	la	$6, _Msg_IllegalIndex_
# was:	la	$6, _Msg_IllegalIndex_
	j	_RuntimeError_
_safe_lab_65_:
	sub	$14, $13, $14
# was:	sub	_tmp_reg_63_, _arr_ind_60_, _size_reg_62_
	bgez	$14, _error_lab_64_
# was:	bgez	_tmp_reg_63_, _error_lab_64_
	sll	$13, $13, 2
# was:	sll	_arr_ind_60_, _arr_ind_60_, 2
	add	$12, $12, $13
# was:	add	_arr_reg_61_, _arr_reg_61_, _arr_ind_60_
	lw	$12, 0($12)
# was:	lw	_letBind_59_, 0(_arr_reg_61_)
# 	ori	_div1_L_67_,_letBind_45_,0
# 	ori	_len_arr_70_,_letBind_3_,0
	lw	$13, 0($9)
# was:	lw	_div2_R_68_, 0(_len_arr_70_)
	bne	$13, $0, _safe_div_69_
# was:	bne	_div2_R_68_, $0, _safe_div_69_
	ori	$5, $0, 8
# was:	ori	$5, $0, 8
	la	$6, _Msg_DivZero_
# was:	la	$6, _Msg_DivZero_
	j	_RuntimeError_
_safe_div_69_:
	div	$10, $10, $13
# was:	div	_letBind_66_, _div1_L_67_, _div2_R_68_
# 	ori	_div1_L_72_,_letBind_54_,0
# 	ori	_div2_R_73_,_letBind_66_,0
	bne	$10, $0, _safe_div_74_
# was:	bne	_div2_R_73_, $0, _safe_div_74_
	ori	$5, $0, 8
# was:	ori	$5, $0, 8
	la	$6, _Msg_DivZero_
# was:	la	$6, _Msg_DivZero_
	j	_RuntimeError_
_safe_div_74_:
	div	$11, $11, $10
# was:	div	_letBind_71_, _div1_L_72_, _div2_R_73_
# 	ori	_arr_ind_76_,_letBind_71_,0
	addi	$10, $9, 4
# was:	addi	_arr_reg_77_, _letBind_3_, 4
	lw	$13, 0($9)
# was:	lw	_size_reg_78_, 0(_letBind_3_)
	bgez	$11, _safe_lab_81_
# was:	bgez	_arr_ind_76_, _safe_lab_81_
_error_lab_80_:
	ori	$5, $0, 8
# was:	ori	$5, $0, 8
	la	$6, _Msg_IllegalIndex_
# was:	la	$6, _Msg_IllegalIndex_
	j	_RuntimeError_
_safe_lab_81_:
	sub	$13, $11, $13
# was:	sub	_tmp_reg_79_, _arr_ind_76_, _size_reg_78_
	bgez	$13, _error_lab_80_
# was:	bgez	_tmp_reg_79_, _error_lab_80_
	sll	$11, $11, 2
# was:	sll	_arr_ind_76_, _arr_ind_76_, 2
	add	$10, $10, $11
# was:	add	_arr_reg_77_, _arr_reg_77_, _arr_ind_76_
	lw	$10, 0($10)
# was:	lw	_letBind_75_, 0(_arr_reg_77_)
# 	ori	_plus_L_86_,_letBind_75_,0
# 	ori	_plus_R_87_,_letBind_59_,0
	add	$11, $10, $12
# was:	add	_div1_L_83_, _plus_L_86_, _plus_R_87_
	ori	$10, $0, 2
# was:	ori	_div2_R_84_, $0, 2
	bne	$10, $0, _safe_div_85_
# was:	bne	_div2_R_84_, $0, _safe_div_85_
	ori	$5, $0, 8
# was:	ori	$5, $0, 8
	la	$6, _Msg_DivZero_
# was:	la	$6, _Msg_DivZero_
	j	_RuntimeError_
_safe_div_85_:
	div	$10, $11, $10
# was:	div	_letBind_82_, _div1_L_83_, _div2_R_84_
# 	ori	_fun_arg_res_44_,_letBind_82_,0
	ori	$11, $10, 0
# was:	ori	_res_reg_30_, _fun_arg_res_44_, 0
	sw	$11, 0($6)
# was:	sw	_res_reg_30_, 0(_addr_reg_39_)
	addi	$6, $6, 4
# was:	addi	_addr_reg_39_, _addr_reg_39_, 4
	addi	$5, $5, 1
# was:	addi	_i_reg_40_, _i_reg_40_, 1
	j	_loop_beg_41_
_loop_end_42_:
# 	ori	_arr_reg_91_,_letBind_26_,0
	lw	$3, 0($4)
# was:	lw	_size_reg_90_, 0(_arr_reg_91_)
	ori	$2, $28, 0
# was:	ori	_letBind_89_, $28, 0
	sll	$5, $3, 2
# was:	sll	_tmp_112_, _size_reg_90_, 2
	addi	$5, $5, 4
# was:	addi	_tmp_112_, _tmp_112_, 4
	add	$28, $28, $5
# was:	add	$28, $28, _tmp_112_
	sw	$3, 0($2)
# was:	sw	_size_reg_90_, 0(_letBind_89_)
	addi	$5, $2, 4
# was:	addi	_addr_reg_95_, _letBind_89_, 4
	addi	$4, $4, 4
# was:	addi	_arr_reg_91_, _arr_reg_91_, 4
	ori	$6, $0, 0
# was:	ori	_i_reg_96_, $0, 0
	ori	$7, $0, 0
# was:	ori	_count_reg_94_, $0, 0
_loop_beg_97_:
	sub	$8, $6, $3
# was:	sub	_tmp_reg_100_, _i_reg_96_, _size_reg_90_
	bgez	$8, _loop_end_98_
# was:	bgez	_tmp_reg_100_, _loop_end_98_
	lw	$10, 0($4)
# was:	lw	_elem_reg_92_, 0(_arr_reg_91_)
	addi	$4, $4, 4
# was:	addi	_arr_reg_91_, _arr_reg_91_, 4
# 	ori	_minus_L_104_,_elem_reg_92_,0
	ori	$9, $10, 0
# was:	ori	_div1_L_108_, _elem_reg_92_, 0
	ori	$8, $0, 5
# was:	ori	_div2_R_109_, $0, 5
	bne	$8, $0, _safe_div_110_
# was:	bne	_div2_R_109_, $0, _safe_div_110_
	ori	$5, $0, 8
# was:	ori	$5, $0, 8
	la	$6, _Msg_DivZero_
# was:	la	$6, _Msg_DivZero_
	j	_RuntimeError_
_safe_div_110_:
	div	$8, $9, $8
# was:	div	_mult1_L_106_, _div1_L_108_, _div2_R_109_
	ori	$9, $0, 5
# was:	ori	_mult2_R_107_, $0, 5
	mul	$8, $8, $9
# was:	mul	_minus_R_105_, _mult1_L_106_, _mult2_R_107_
	sub	$9, $10, $8
# was:	sub	_eq_L_102_, _minus_L_104_, _minus_R_105_
	ori	$11, $0, 0
# was:	ori	_eq_R_103_, $0, 0
	ori	$8, $0, 0
# was:	ori	_fun_arg_res_101_, $0, 0
	bne	$9, $11, _false_111_
# was:	bne	_eq_L_102_, _eq_R_103_, _false_111_
	ori	$8, $0, 1
# was:	ori	_fun_arg_res_101_, $0, 1
_false_111_:
# 	ori	_bool_reg_93_,_fun_arg_res_101_,0
	beq	$8, $0, _if_end_99_
# was:	beq	_bool_reg_93_, $0, _if_end_99_
	sw	$10, 0($5)
# was:	sw	_elem_reg_92_, 0(_addr_reg_95_)
	addi	$5, $5, 4
# was:	addi	_addr_reg_95_, _addr_reg_95_, 4
	addi	$7, $7, 1
# was:	addi	_count_reg_94_, _count_reg_94_, 1
_if_end_99_:
	addi	$6, $6, 1
# was:	addi	_i_reg_96_, _i_reg_96_, 1
	j	_loop_beg_97_
_loop_end_98_:
	sw	$7, 0($2)
# was:	sw	_count_reg_94_, 0(_letBind_89_)
# 	ori	_arr_reg_115_,_letBind_89_,0
	lw	$4, 0($2)
# was:	lw	_size_reg_114_, 0(_arr_reg_115_)
	ori	$6, $28, 0
# was:	ori	_letBind_113_, $28, 0
	sll	$3, $4, 2
# was:	sll	_tmp_126_, _size_reg_114_, 2
	addi	$3, $3, 4
# was:	addi	_tmp_126_, _tmp_126_, 4
	add	$28, $28, $3
# was:	add	$28, $28, _tmp_126_
	sw	$4, 0($6)
# was:	sw	_size_reg_114_, 0(_letBind_113_)
	addi	$3, $6, 4
# was:	addi	_addr_reg_118_, _letBind_113_, 4
	ori	$5, $0, 0
# was:	ori	_i_reg_119_, $0, 0
	addi	$2, $2, 4
# was:	addi	_elem_reg_116_, _arr_reg_115_, 4
_loop_beg_120_:
	sub	$7, $5, $4
# was:	sub	_tmp_reg_122_, _i_reg_119_, _size_reg_114_
	bgez	$7, _loop_end_121_
# was:	bgez	_tmp_reg_122_, _loop_end_121_
	lw	$7, 0($2)
# was:	lw	_res_reg_117_, 0(_elem_reg_116_)
	addi	$2, $2, 4
# was:	addi	_elem_reg_116_, _elem_reg_116_, 4
# 	ori	_mult1_L_124_,_res_reg_117_,0
	ori	$8, $7, 0
# was:	ori	_mult2_R_125_, _res_reg_117_, 0
	mul	$7, $7, $8
# was:	mul	_fun_arg_res_123_, _mult1_L_124_, _mult2_R_125_
# 	ori	_res_reg_117_,_fun_arg_res_123_,0
	sw	$7, 0($3)
# was:	sw	_res_reg_117_, 0(_addr_reg_118_)
	addi	$3, $3, 4
# was:	addi	_addr_reg_118_, _addr_reg_118_, 4
	addi	$5, $5, 1
# was:	addi	_i_reg_119_, _i_reg_119_, 1
	j	_loop_beg_120_
_loop_end_121_:
# 	ori	_arr_reg_128_,_letBind_113_,0
	lw	$17, 0($6)
# was:	lw	_size_reg_127_, 0(_arr_reg_128_)
	ori	$16, $28, 0
# was:	ori	_mainres_1_, $28, 0
	sll	$2, $17, 2
# was:	sll	_tmp_138_, _size_reg_127_, 2
	addi	$2, $2, 4
# was:	addi	_tmp_138_, _tmp_138_, 4
	add	$28, $28, $2
# was:	add	$28, $28, _tmp_138_
	sw	$17, 0($16)
# was:	sw	_size_reg_127_, 0(_mainres_1_)
	addi	$18, $16, 4
# was:	addi	_addr_reg_131_, _mainres_1_, 4
	ori	$19, $0, 0
# was:	ori	_i_reg_132_, $0, 0
	addi	$20, $6, 4
# was:	addi	_elem_reg_129_, _arr_reg_128_, 4
_loop_beg_133_:
	sub	$2, $19, $17
# was:	sub	_tmp_reg_135_, _i_reg_132_, _size_reg_127_
	bgez	$2, _loop_end_134_
# was:	bgez	_tmp_reg_135_, _loop_end_134_
	lw	$21, 0($20)
# was:	lw	_res_reg_130_, 0(_elem_reg_129_)
	addi	$20, $20, 4
# was:	addi	_elem_reg_129_, _elem_reg_129_, 4
# 	ori	_tmp_137_,_res_reg_130_,0
# 	ori	_fun_arg_res_136_,_tmp_137_,0
	ori	$2, $21, 0
# was:	ori	$2, _fun_arg_res_136_, 0
	jal	putint
# was:	jal	putint, $2
# 	ori	_res_reg_130_,_fun_arg_res_136_,0
	sw	$21, 0($18)
# was:	sw	_res_reg_130_, 0(_addr_reg_131_)
	addi	$18, $18, 4
# was:	addi	_addr_reg_131_, _addr_reg_131_, 4
	addi	$19, $19, 1
# was:	addi	_i_reg_132_, _i_reg_132_, 1
	j	_loop_beg_133_
_loop_end_134_:
	ori	$2, $16, 0
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