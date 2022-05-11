	.text	0x00400000
	.globl	main
	la	$28, _heap_
	la	$4, _aaMSSPa_193_
# was:	la	_aaMSSPa_193__addr, _aaMSSPa_193_
	ori	$3, $0, 18
# was:	ori	_aaMSSPa_193__init, $0, 18
	sw	$3, 0($4)
# was:	sw	_aaMSSPa_193__init, 0(_aaMSSPa_193__addr)
	la	$4, _a__str__33_
# was:	la	_a__str__33__addr, _a__str__33_
	ori	$3, $0, 1
# was:	ori	_a__str__33__init, $0, 1
	sw	$3, 0($4)
# was:	sw	_a__str__33__init, 0(_a__str__33__addr)
	la	$4, _aa__str_29_
# was:	la	_aa__str_29__addr, _aa__str_29_
	ori	$3, $0, 2
# was:	ori	_aa__str_29__init, $0, 2
	sw	$3, 0($4)
# was:	sw	_aa__str_29__init, 0(_aa__str_29__addr)
	la	$4, _Introdu_24_
# was:	la	_Introdu_24__addr, _Introdu_24_
	ori	$3, $0, 17
# was:	ori	_Introdu_24__init, $0, 17
	sw	$3, 0($4)
# was:	sw	_Introdu_24__init, 0(_Introdu_24__addr)
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
	ori	$2, $0, 8
# was:	ori	_size_reg_3_, $0, 8
	bgez	$2, _safe_lab_4_
# was:	bgez	_size_reg_3_, _safe_lab_4_
	ori	$5, $0, 10
# was:	ori	$5, $0, 10
	la	$6, _Msg_IllegalArraySize_
# was:	la	$6, _Msg_IllegalArraySize_
	j	_RuntimeError_
_safe_lab_4_:
	ori	$3, $28, 0
# was:	ori	_letBind_2_, $28, 0
	sll	$4, $2, 2
# was:	sll	_tmp_10_, _size_reg_3_, 2
	addi	$4, $4, 4
# was:	addi	_tmp_10_, _tmp_10_, 4
	add	$28, $28, $4
# was:	add	$28, $28, _tmp_10_
	sw	$2, 0($3)
# was:	sw	_size_reg_3_, 0(_letBind_2_)
	addi	$5, $3, 4
# was:	addi	_addr_reg_5_, _letBind_2_, 4
	ori	$6, $0, 0
# was:	ori	_i_reg_6_, $0, 0
_loop_beg_7_:
	sub	$4, $6, $2
# was:	sub	_tmp_reg_9_, _i_reg_6_, _size_reg_3_
	bgez	$4, _loop_end_8_
# was:	bgez	_tmp_reg_9_, _loop_end_8_
	sw	$6, 0($5)
# was:	sw	_i_reg_6_, 0(_addr_reg_5_)
	addi	$5, $5, 4
# was:	addi	_addr_reg_5_, _addr_reg_5_, 4
	addi	$6, $6, 1
# was:	addi	_i_reg_6_, _i_reg_6_, 1
	j	_loop_beg_7_
_loop_end_8_:
	ori	$2, $3, 0
# was:	ori	_arr_reg_13_, _letBind_2_, 0
	lw	$16, 0($2)
# was:	lw	_size_reg_12_, 0(_arr_reg_13_)
	ori	$17, $28, 0
# was:	ori	_letBind_11_, $28, 0
	sll	$3, $16, 2
# was:	sll	_tmp_34_, _size_reg_12_, 2
	addi	$3, $3, 4
# was:	addi	_tmp_34_, _tmp_34_, 4
	add	$28, $28, $3
# was:	add	$28, $28, _tmp_34_
	sw	$16, 0($17)
# was:	sw	_size_reg_12_, 0(_letBind_11_)
	addi	$18, $17, 4
# was:	addi	_addr_reg_16_, _letBind_11_, 4
	ori	$19, $0, 0
# was:	ori	_i_reg_17_, $0, 0
	addi	$20, $2, 4
# was:	addi	_elem_reg_14_, _arr_reg_13_, 4
_loop_beg_18_:
	sub	$2, $19, $16
# was:	sub	_tmp_reg_20_, _i_reg_17_, _size_reg_12_
	bgez	$2, _loop_end_19_
# was:	bgez	_tmp_reg_20_, _loop_end_19_
	lw	$21, 0($20)
# was:	lw	_res_reg_15_, 0(_elem_reg_14_)
	addi	$20, $20, 4
# was:	addi	_elem_reg_14_, _elem_reg_14_, 4
	la	$2, _Introdu_24_
# was:	la	_tmp_23_, _Introdu_24_
# _Introdu_24_: string "Introduce number "
# 	ori	_letBind_22_,_tmp_23_,0
# 	ori	$2,_tmp_23_,0
	jal	putstring
# was:	jal	putstring, $2
	ori	$2, $21, 0
# was:	ori	_tmp_26_, _res_reg_15_, 0
# 	ori	_letBind_25_,_tmp_26_,0
# 	ori	$2,_letBind_25_,0
	jal	putint
# was:	jal	putint, $2
	la	$2, _aa__str_29_
# was:	la	_tmp_28_, _aa__str_29_
# _aa__str_29_: string ": "
# 	ori	_letBind_27_,_tmp_28_,0
# 	ori	$2,_tmp_28_,0
	jal	putstring
# was:	jal	putstring, $2
	jal	getint
# was:	jal	getint, $2
	ori	$21, $2, 0
# was:	ori	_letBind_30_, $2, 0
	la	$2, _a__str__33_
# was:	la	_tmp_32_, _a__str__33_
# _a__str__33_: string "\n"
# 	ori	_letBind_31_,_tmp_32_,0
# 	ori	$2,_tmp_32_,0
	jal	putstring
# was:	jal	putstring, $2
# 	ori	_fun_arg_res_21_,_letBind_30_,0
# 	ori	_res_reg_15_,_fun_arg_res_21_,0
	sw	$21, 0($18)
# was:	sw	_res_reg_15_, 0(_addr_reg_16_)
	addi	$18, $18, 4
# was:	addi	_addr_reg_16_, _addr_reg_16_, 4
	addi	$19, $19, 1
# was:	addi	_i_reg_17_, _i_reg_17_, 1
	j	_loop_beg_18_
_loop_end_19_:
# 	ori	_arr_reg_37_,_letBind_11_,0
	lw	$6, 0($17)
# was:	lw	_size_reg_36_, 0(_arr_reg_37_)
	ori	$5, $28, 0
# was:	ori	_letBind_35_, $28, 0
	sll	$2, $6, 2
# was:	sll	_tmp_57_, _size_reg_36_, 2
	addi	$2, $2, 4
# was:	addi	_tmp_57_, _tmp_57_, 4
	add	$28, $28, $2
# was:	add	$28, $28, _tmp_57_
	sw	$6, 0($5)
# was:	sw	_size_reg_36_, 0(_letBind_35_)
	addi	$8, $5, 4
# was:	addi	_addr_reg_40_, _letBind_35_, 4
	ori	$7, $0, 0
# was:	ori	_i_reg_41_, $0, 0
	addi	$9, $17, 4
# was:	addi	_elem_reg_38_, _arr_reg_37_, 4
_loop_beg_42_:
	sub	$2, $7, $6
# was:	sub	_tmp_reg_44_, _i_reg_41_, _size_reg_36_
	bgez	$2, _loop_end_43_
# was:	bgez	_tmp_reg_44_, _loop_end_43_
	lw	$10, 0($9)
# was:	lw	_res_reg_39_, 0(_elem_reg_38_)
	addi	$9, $9, 4
# was:	addi	_elem_reg_38_, _elem_reg_38_, 4
# 	ori	_lt_L_51_,_res_reg_39_,0
	ori	$2, $0, 0
# was:	ori	_lt_R_52_, $0, 0
	slt	$2, $10, $2
# was:	slt	_cond_50_, _lt_L_51_, _lt_R_52_
	bne	$2, $0, _then_47_
# was:	bne	_cond_50_, $0, _then_47_
	j	_else_48_
_then_47_:
	ori	$4, $0, 0
# was:	ori	_letBind_46_, $0, 0
	j	_endif_49_
_else_48_:
	ori	$4, $10, 0
# was:	ori	_letBind_46_, _res_reg_39_, 0
_endif_49_:
	ori	$11, $0, 4
# was:	ori	_size_reg_53_, $0, 4
	ori	$3, $28, 0
# was:	ori	_fun_arg_res_45_, $28, 0
	sll	$2, $11, 2
# was:	sll	_tmp_56_, _size_reg_53_, 2
	addi	$2, $2, 4
# was:	addi	_tmp_56_, _tmp_56_, 4
	add	$28, $28, $2
# was:	add	$28, $28, _tmp_56_
	sw	$11, 0($3)
# was:	sw	_size_reg_53_, 0(_fun_arg_res_45_)
	addi	$2, $3, 4
# was:	addi	_addr_reg_54_, _fun_arg_res_45_, 4
# 	ori	_tmp_reg_55_,_letBind_46_,0
	sw	$4, 0($2)
# was:	sw	_tmp_reg_55_, 0(_addr_reg_54_)
	addi	$2, $2, 4
# was:	addi	_addr_reg_54_, _addr_reg_54_, 4
# 	ori	_tmp_reg_55_,_letBind_46_,0
	sw	$4, 0($2)
# was:	sw	_tmp_reg_55_, 0(_addr_reg_54_)
	addi	$2, $2, 4
# was:	addi	_addr_reg_54_, _addr_reg_54_, 4
# 	ori	_tmp_reg_55_,_letBind_46_,0
	sw	$4, 0($2)
# was:	sw	_tmp_reg_55_, 0(_addr_reg_54_)
	addi	$2, $2, 4
# was:	addi	_addr_reg_54_, _addr_reg_54_, 4
	ori	$4, $10, 0
# was:	ori	_tmp_reg_55_, _res_reg_39_, 0
	sw	$4, 0($2)
# was:	sw	_tmp_reg_55_, 0(_addr_reg_54_)
	addi	$2, $2, 4
# was:	addi	_addr_reg_54_, _addr_reg_54_, 4
	ori	$10, $3, 0
# was:	ori	_res_reg_39_, _fun_arg_res_45_, 0
	sw	$10, 0($8)
# was:	sw	_res_reg_39_, 0(_addr_reg_40_)
	addi	$8, $8, 4
# was:	addi	_addr_reg_40_, _addr_reg_40_, 4
	addi	$7, $7, 1
# was:	addi	_i_reg_41_, _i_reg_41_, 1
	j	_loop_beg_42_
_loop_end_43_:
	ori	$2, $0, 4
# was:	ori	_size_reg_59_, $0, 4
	ori	$16, $28, 0
# was:	ori	_letBind_58_, $28, 0
	sll	$3, $2, 2
# was:	sll	_tmp_62_, _size_reg_59_, 2
	addi	$3, $3, 4
# was:	addi	_tmp_62_, _tmp_62_, 4
	add	$28, $28, $3
# was:	add	$28, $28, _tmp_62_
	sw	$2, 0($16)
# was:	sw	_size_reg_59_, 0(_letBind_58_)
	addi	$2, $16, 4
# was:	addi	_addr_reg_60_, _letBind_58_, 4
	ori	$3, $0, 0
# was:	ori	_tmp_reg_61_, $0, 0
	sw	$3, 0($2)
# was:	sw	_tmp_reg_61_, 0(_addr_reg_60_)
	addi	$2, $2, 4
# was:	addi	_addr_reg_60_, _addr_reg_60_, 4
	ori	$3, $0, 0
# was:	ori	_tmp_reg_61_, $0, 0
	sw	$3, 0($2)
# was:	sw	_tmp_reg_61_, 0(_addr_reg_60_)
	addi	$2, $2, 4
# was:	addi	_addr_reg_60_, _addr_reg_60_, 4
	ori	$3, $0, 0
# was:	ori	_tmp_reg_61_, $0, 0
	sw	$3, 0($2)
# was:	sw	_tmp_reg_61_, 0(_addr_reg_60_)
	addi	$2, $2, 4
# was:	addi	_addr_reg_60_, _addr_reg_60_, 4
	ori	$3, $0, 0
# was:	ori	_tmp_reg_61_, $0, 0
	sw	$3, 0($2)
# was:	sw	_tmp_reg_61_, 0(_addr_reg_60_)
	addi	$2, $2, 4
# was:	addi	_addr_reg_60_, _addr_reg_60_, 4
	ori	$3, $5, 0
# was:	ori	_arr_reg_64_, _letBind_35_, 0
	lw	$2, 0($3)
# was:	lw	_size_reg_65_, 0(_arr_reg_64_)
# 	ori	_letBind_63_,_letBind_58_,0
	addi	$3, $3, 4
# was:	addi	_arr_reg_64_, _arr_reg_64_, 4
	ori	$4, $0, 0
# was:	ori	_ind_var_66_, $0, 0
_loop_beg_68_:
	sub	$6, $4, $2
# was:	sub	_tmp_reg_67_, _ind_var_66_, _size_reg_65_
	bgez	$6, _loop_end_69_
# was:	bgez	_tmp_reg_67_, _loop_end_69_
	lw	$6, 0($3)
# was:	lw	_tmp_reg_67_, 0(_arr_reg_64_)
	addi	$3, $3, 4
# was:	addi	_arr_reg_64_, _arr_reg_64_, 4
	ori	$5, $0, 0
# was:	ori	_arr_ind_72_, $0, 0
	addi	$7, $16, 4
# was:	addi	_arr_reg_73_, _letBind_63_, 4
	lw	$8, 0($16)
# was:	lw	_size_reg_74_, 0(_letBind_63_)
	bgez	$5, _safe_lab_77_
# was:	bgez	_arr_ind_72_, _safe_lab_77_
_error_lab_76_:
	ori	$5, $0, 28
# was:	ori	$5, $0, 28
	la	$6, _Msg_IllegalIndex_
# was:	la	$6, _Msg_IllegalIndex_
	j	_RuntimeError_
_safe_lab_77_:
	sub	$8, $5, $8
# was:	sub	_tmp_reg_75_, _arr_ind_72_, _size_reg_74_
	bgez	$8, _error_lab_76_
# was:	bgez	_tmp_reg_75_, _error_lab_76_
	sll	$5, $5, 2
# was:	sll	_arr_ind_72_, _arr_ind_72_, 2
	add	$7, $7, $5
# was:	add	_arr_reg_73_, _arr_reg_73_, _arr_ind_72_
	lw	$9, 0($7)
# was:	lw	_letBind_71_, 0(_arr_reg_73_)
	ori	$7, $0, 0
# was:	ori	_arr_ind_79_, $0, 0
	addi	$5, $6, 4
# was:	addi	_arr_reg_80_, _tmp_reg_67_, 4
	lw	$8, 0($6)
# was:	lw	_size_reg_81_, 0(_tmp_reg_67_)
	bgez	$7, _safe_lab_84_
# was:	bgez	_arr_ind_79_, _safe_lab_84_
_error_lab_83_:
	ori	$5, $0, 28
# was:	ori	$5, $0, 28
	la	$6, _Msg_IllegalIndex_
# was:	la	$6, _Msg_IllegalIndex_
	j	_RuntimeError_
_safe_lab_84_:
	sub	$8, $7, $8
# was:	sub	_tmp_reg_82_, _arr_ind_79_, _size_reg_81_
	bgez	$8, _error_lab_83_
# was:	bgez	_tmp_reg_82_, _error_lab_83_
	sll	$7, $7, 2
# was:	sll	_arr_ind_79_, _arr_ind_79_, 2
	add	$5, $5, $7
# was:	add	_arr_reg_80_, _arr_reg_80_, _arr_ind_79_
	lw	$5, 0($5)
# was:	lw	_letBind_78_, 0(_arr_reg_80_)
# 	ori	_lt_L_90_,_letBind_71_,0
# 	ori	_lt_R_91_,_letBind_78_,0
	slt	$7, $9, $5
# was:	slt	_cond_89_, _lt_L_90_, _lt_R_91_
	bne	$7, $0, _then_86_
# was:	bne	_cond_89_, $0, _then_86_
	j	_else_87_
_then_86_:
	ori	$9, $5, 0
# was:	ori	_letBind_85_, _letBind_78_, 0
	j	_endif_88_
_else_87_:
# 	ori	_letBind_85_,_letBind_71_,0
_endif_88_:
	ori	$5, $0, 2
# was:	ori	_arr_ind_95_, $0, 2
	addi	$7, $16, 4
# was:	addi	_arr_reg_96_, _letBind_63_, 4
	lw	$8, 0($16)
# was:	lw	_size_reg_97_, 0(_letBind_63_)
	bgez	$5, _safe_lab_100_
# was:	bgez	_arr_ind_95_, _safe_lab_100_
_error_lab_99_:
	ori	$5, $0, 28
# was:	ori	$5, $0, 28
	la	$6, _Msg_IllegalIndex_
# was:	la	$6, _Msg_IllegalIndex_
	j	_RuntimeError_
_safe_lab_100_:
	sub	$8, $5, $8
# was:	sub	_tmp_reg_98_, _arr_ind_95_, _size_reg_97_
	bgez	$8, _error_lab_99_
# was:	bgez	_tmp_reg_98_, _error_lab_99_
	sll	$5, $5, 2
# was:	sll	_arr_ind_95_, _arr_ind_95_, 2
	add	$7, $7, $5
# was:	add	_arr_reg_96_, _arr_reg_96_, _arr_ind_95_
	lw	$8, 0($7)
# was:	lw	_plus_L_93_, 0(_arr_reg_96_)
	ori	$5, $0, 1
# was:	ori	_arr_ind_101_, $0, 1
	addi	$7, $6, 4
# was:	addi	_arr_reg_102_, _tmp_reg_67_, 4
	lw	$10, 0($6)
# was:	lw	_size_reg_103_, 0(_tmp_reg_67_)
	bgez	$5, _safe_lab_106_
# was:	bgez	_arr_ind_101_, _safe_lab_106_
_error_lab_105_:
	ori	$5, $0, 28
# was:	ori	$5, $0, 28
	la	$6, _Msg_IllegalIndex_
# was:	la	$6, _Msg_IllegalIndex_
	j	_RuntimeError_
_safe_lab_106_:
	sub	$10, $5, $10
# was:	sub	_tmp_reg_104_, _arr_ind_101_, _size_reg_103_
	bgez	$10, _error_lab_105_
# was:	bgez	_tmp_reg_104_, _error_lab_105_
	sll	$5, $5, 2
# was:	sll	_arr_ind_101_, _arr_ind_101_, 2
	add	$7, $7, $5
# was:	add	_arr_reg_102_, _arr_reg_102_, _arr_ind_101_
	lw	$5, 0($7)
# was:	lw	_plus_R_94_, 0(_arr_reg_102_)
	add	$5, $8, $5
# was:	add	_letBind_92_, _plus_L_93_, _plus_R_94_
# 	ori	_lt_L_112_,_letBind_85_,0
# 	ori	_lt_R_113_,_letBind_92_,0
	slt	$7, $9, $5
# was:	slt	_cond_111_, _lt_L_112_, _lt_R_113_
	bne	$7, $0, _then_108_
# was:	bne	_cond_111_, $0, _then_108_
	j	_else_109_
_then_108_:
# 	ori	_letBind_107_,_letBind_92_,0
	j	_endif_110_
_else_109_:
	ori	$5, $9, 0
# was:	ori	_letBind_107_, _letBind_85_, 0
_endif_110_:
	ori	$7, $0, 1
# was:	ori	_arr_ind_115_, $0, 1
	addi	$8, $16, 4
# was:	addi	_arr_reg_116_, _letBind_63_, 4
	lw	$9, 0($16)
# was:	lw	_size_reg_117_, 0(_letBind_63_)
	bgez	$7, _safe_lab_120_
# was:	bgez	_arr_ind_115_, _safe_lab_120_
_error_lab_119_:
	ori	$5, $0, 29
# was:	ori	$5, $0, 29
	la	$6, _Msg_IllegalIndex_
# was:	la	$6, _Msg_IllegalIndex_
	j	_RuntimeError_
_safe_lab_120_:
	sub	$9, $7, $9
# was:	sub	_tmp_reg_118_, _arr_ind_115_, _size_reg_117_
	bgez	$9, _error_lab_119_
# was:	bgez	_tmp_reg_118_, _error_lab_119_
	sll	$7, $7, 2
# was:	sll	_arr_ind_115_, _arr_ind_115_, 2
	add	$8, $8, $7
# was:	add	_arr_reg_116_, _arr_reg_116_, _arr_ind_115_
	lw	$7, 0($8)
# was:	lw	_letBind_114_, 0(_arr_reg_116_)
	ori	$9, $0, 3
# was:	ori	_arr_ind_124_, $0, 3
	addi	$10, $16, 4
# was:	addi	_arr_reg_125_, _letBind_63_, 4
	lw	$8, 0($16)
# was:	lw	_size_reg_126_, 0(_letBind_63_)
	bgez	$9, _safe_lab_129_
# was:	bgez	_arr_ind_124_, _safe_lab_129_
_error_lab_128_:
	ori	$5, $0, 29
# was:	ori	$5, $0, 29
	la	$6, _Msg_IllegalIndex_
# was:	la	$6, _Msg_IllegalIndex_
	j	_RuntimeError_
_safe_lab_129_:
	sub	$8, $9, $8
# was:	sub	_tmp_reg_127_, _arr_ind_124_, _size_reg_126_
	bgez	$8, _error_lab_128_
# was:	bgez	_tmp_reg_127_, _error_lab_128_
	sll	$9, $9, 2
# was:	sll	_arr_ind_124_, _arr_ind_124_, 2
	add	$10, $10, $9
# was:	add	_arr_reg_125_, _arr_reg_125_, _arr_ind_124_
	lw	$9, 0($10)
# was:	lw	_plus_L_122_, 0(_arr_reg_125_)
	ori	$8, $0, 1
# was:	ori	_arr_ind_130_, $0, 1
	addi	$10, $6, 4
# was:	addi	_arr_reg_131_, _tmp_reg_67_, 4
	lw	$11, 0($6)
# was:	lw	_size_reg_132_, 0(_tmp_reg_67_)
	bgez	$8, _safe_lab_135_
# was:	bgez	_arr_ind_130_, _safe_lab_135_
_error_lab_134_:
	ori	$5, $0, 29
# was:	ori	$5, $0, 29
	la	$6, _Msg_IllegalIndex_
# was:	la	$6, _Msg_IllegalIndex_
	j	_RuntimeError_
_safe_lab_135_:
	sub	$11, $8, $11
# was:	sub	_tmp_reg_133_, _arr_ind_130_, _size_reg_132_
	bgez	$11, _error_lab_134_
# was:	bgez	_tmp_reg_133_, _error_lab_134_
	sll	$8, $8, 2
# was:	sll	_arr_ind_130_, _arr_ind_130_, 2
	add	$10, $10, $8
# was:	add	_arr_reg_131_, _arr_reg_131_, _arr_ind_130_
	lw	$8, 0($10)
# was:	lw	_plus_R_123_, 0(_arr_reg_131_)
	add	$8, $9, $8
# was:	add	_letBind_121_, _plus_L_122_, _plus_R_123_
# 	ori	_lt_L_141_,_letBind_114_,0
# 	ori	_lt_R_142_,_letBind_121_,0
	slt	$9, $7, $8
# was:	slt	_cond_140_, _lt_L_141_, _lt_R_142_
	bne	$9, $0, _then_137_
# was:	bne	_cond_140_, $0, _then_137_
	j	_else_138_
_then_137_:
	ori	$7, $8, 0
# was:	ori	_letBind_136_, _letBind_121_, 0
	j	_endif_139_
_else_138_:
# 	ori	_letBind_136_,_letBind_114_,0
_endif_139_:
	ori	$8, $0, 2
# was:	ori	_arr_ind_146_, $0, 2
	addi	$9, $16, 4
# was:	addi	_arr_reg_147_, _letBind_63_, 4
	lw	$10, 0($16)
# was:	lw	_size_reg_148_, 0(_letBind_63_)
	bgez	$8, _safe_lab_151_
# was:	bgez	_arr_ind_146_, _safe_lab_151_
_error_lab_150_:
	ori	$5, $0, 30
# was:	ori	$5, $0, 30
	la	$6, _Msg_IllegalIndex_
# was:	la	$6, _Msg_IllegalIndex_
	j	_RuntimeError_
_safe_lab_151_:
	sub	$10, $8, $10
# was:	sub	_tmp_reg_149_, _arr_ind_146_, _size_reg_148_
	bgez	$10, _error_lab_150_
# was:	bgez	_tmp_reg_149_, _error_lab_150_
	sll	$8, $8, 2
# was:	sll	_arr_ind_146_, _arr_ind_146_, 2
	add	$9, $9, $8
# was:	add	_arr_reg_147_, _arr_reg_147_, _arr_ind_146_
	lw	$8, 0($9)
# was:	lw	_plus_L_144_, 0(_arr_reg_147_)
	ori	$9, $0, 3
# was:	ori	_arr_ind_152_, $0, 3
	addi	$10, $6, 4
# was:	addi	_arr_reg_153_, _tmp_reg_67_, 4
	lw	$11, 0($6)
# was:	lw	_size_reg_154_, 0(_tmp_reg_67_)
	bgez	$9, _safe_lab_157_
# was:	bgez	_arr_ind_152_, _safe_lab_157_
_error_lab_156_:
	ori	$5, $0, 30
# was:	ori	$5, $0, 30
	la	$6, _Msg_IllegalIndex_
# was:	la	$6, _Msg_IllegalIndex_
	j	_RuntimeError_
_safe_lab_157_:
	sub	$11, $9, $11
# was:	sub	_tmp_reg_155_, _arr_ind_152_, _size_reg_154_
	bgez	$11, _error_lab_156_
# was:	bgez	_tmp_reg_155_, _error_lab_156_
	sll	$9, $9, 2
# was:	sll	_arr_ind_152_, _arr_ind_152_, 2
	add	$10, $10, $9
# was:	add	_arr_reg_153_, _arr_reg_153_, _arr_ind_152_
	lw	$9, 0($10)
# was:	lw	_plus_R_145_, 0(_arr_reg_153_)
	add	$8, $8, $9
# was:	add	_letBind_143_, _plus_L_144_, _plus_R_145_
	ori	$9, $0, 2
# was:	ori	_arr_ind_159_, $0, 2
	addi	$10, $6, 4
# was:	addi	_arr_reg_160_, _tmp_reg_67_, 4
	lw	$11, 0($6)
# was:	lw	_size_reg_161_, 0(_tmp_reg_67_)
	bgez	$9, _safe_lab_164_
# was:	bgez	_arr_ind_159_, _safe_lab_164_
_error_lab_163_:
	ori	$5, $0, 30
# was:	ori	$5, $0, 30
	la	$6, _Msg_IllegalIndex_
# was:	la	$6, _Msg_IllegalIndex_
	j	_RuntimeError_
_safe_lab_164_:
	sub	$11, $9, $11
# was:	sub	_tmp_reg_162_, _arr_ind_159_, _size_reg_161_
	bgez	$11, _error_lab_163_
# was:	bgez	_tmp_reg_162_, _error_lab_163_
	sll	$9, $9, 2
# was:	sll	_arr_ind_159_, _arr_ind_159_, 2
	add	$10, $10, $9
# was:	add	_arr_reg_160_, _arr_reg_160_, _arr_ind_159_
	lw	$9, 0($10)
# was:	lw	_letBind_158_, 0(_arr_reg_160_)
# 	ori	_lt_L_170_,_letBind_143_,0
# 	ori	_lt_R_171_,_letBind_158_,0
	slt	$10, $8, $9
# was:	slt	_cond_169_, _lt_L_170_, _lt_R_171_
	bne	$10, $0, _then_166_
# was:	bne	_cond_169_, $0, _then_166_
	j	_else_167_
_then_166_:
	ori	$8, $9, 0
# was:	ori	_letBind_165_, _letBind_158_, 0
	j	_endif_168_
_else_167_:
# 	ori	_letBind_165_,_letBind_143_,0
_endif_168_:
	ori	$10, $0, 3
# was:	ori	_arr_ind_175_, $0, 3
	addi	$9, $16, 4
# was:	addi	_arr_reg_176_, _letBind_63_, 4
	lw	$11, 0($16)
# was:	lw	_size_reg_177_, 0(_letBind_63_)
	bgez	$10, _safe_lab_180_
# was:	bgez	_arr_ind_175_, _safe_lab_180_
_error_lab_179_:
	ori	$5, $0, 31
# was:	ori	$5, $0, 31
	la	$6, _Msg_IllegalIndex_
# was:	la	$6, _Msg_IllegalIndex_
	j	_RuntimeError_
_safe_lab_180_:
	sub	$11, $10, $11
# was:	sub	_tmp_reg_178_, _arr_ind_175_, _size_reg_177_
	bgez	$11, _error_lab_179_
# was:	bgez	_tmp_reg_178_, _error_lab_179_
	sll	$10, $10, 2
# was:	sll	_arr_ind_175_, _arr_ind_175_, 2
	add	$9, $9, $10
# was:	add	_arr_reg_176_, _arr_reg_176_, _arr_ind_175_
	lw	$11, 0($9)
# was:	lw	_plus_L_173_, 0(_arr_reg_176_)
	ori	$9, $0, 3
# was:	ori	_arr_ind_181_, $0, 3
	addi	$10, $6, 4
# was:	addi	_arr_reg_182_, _tmp_reg_67_, 4
	lw	$6, 0($6)
# was:	lw	_size_reg_183_, 0(_tmp_reg_67_)
	bgez	$9, _safe_lab_186_
# was:	bgez	_arr_ind_181_, _safe_lab_186_
_error_lab_185_:
	ori	$5, $0, 31
# was:	ori	$5, $0, 31
	la	$6, _Msg_IllegalIndex_
# was:	la	$6, _Msg_IllegalIndex_
	j	_RuntimeError_
_safe_lab_186_:
	sub	$6, $9, $6
# was:	sub	_tmp_reg_184_, _arr_ind_181_, _size_reg_183_
	bgez	$6, _error_lab_185_
# was:	bgez	_tmp_reg_184_, _error_lab_185_
	sll	$9, $9, 2
# was:	sll	_arr_ind_181_, _arr_ind_181_, 2
	add	$10, $10, $9
# was:	add	_arr_reg_182_, _arr_reg_182_, _arr_ind_181_
	lw	$6, 0($10)
# was:	lw	_plus_R_174_, 0(_arr_reg_182_)
	add	$9, $11, $6
# was:	add	_letBind_172_, _plus_L_173_, _plus_R_174_
	ori	$10, $0, 4
# was:	ori	_size_reg_187_, $0, 4
	ori	$16, $28, 0
# was:	ori	_fun_arg_res_70_, $28, 0
	sll	$6, $10, 2
# was:	sll	_tmp_190_, _size_reg_187_, 2
	addi	$6, $6, 4
# was:	addi	_tmp_190_, _tmp_190_, 4
	add	$28, $28, $6
# was:	add	$28, $28, _tmp_190_
	sw	$10, 0($16)
# was:	sw	_size_reg_187_, 0(_fun_arg_res_70_)
	addi	$6, $16, 4
# was:	addi	_addr_reg_188_, _fun_arg_res_70_, 4
# 	ori	_tmp_reg_189_,_letBind_107_,0
	sw	$5, 0($6)
# was:	sw	_tmp_reg_189_, 0(_addr_reg_188_)
	addi	$6, $6, 4
# was:	addi	_addr_reg_188_, _addr_reg_188_, 4
	ori	$5, $7, 0
# was:	ori	_tmp_reg_189_, _letBind_136_, 0
	sw	$5, 0($6)
# was:	sw	_tmp_reg_189_, 0(_addr_reg_188_)
	addi	$6, $6, 4
# was:	addi	_addr_reg_188_, _addr_reg_188_, 4
	ori	$5, $8, 0
# was:	ori	_tmp_reg_189_, _letBind_165_, 0
	sw	$5, 0($6)
# was:	sw	_tmp_reg_189_, 0(_addr_reg_188_)
	addi	$6, $6, 4
# was:	addi	_addr_reg_188_, _addr_reg_188_, 4
	ori	$5, $9, 0
# was:	ori	_tmp_reg_189_, _letBind_172_, 0
	sw	$5, 0($6)
# was:	sw	_tmp_reg_189_, 0(_addr_reg_188_)
	addi	$6, $6, 4
# was:	addi	_addr_reg_188_, _addr_reg_188_, 4
# 	ori	_letBind_63_,_fun_arg_res_70_,0
	addi	$4, $4, 1
# was:	addi	_ind_var_66_, _ind_var_66_, 1
	j	_loop_beg_68_
_loop_end_69_:
	la	$2, _aaMSSPa_193_
# was:	la	_tmp_192_, _aaMSSPa_193_
# _aaMSSPa_193_: string "\n\nMSSP result is: "
# 	ori	_letBind_191_,_tmp_192_,0
# 	ori	$2,_tmp_192_,0
	jal	putstring
# was:	jal	putstring, $2
	ori	$3, $0, 0
# was:	ori	_arr_ind_195_, $0, 0
	addi	$2, $16, 4
# was:	addi	_arr_reg_196_, _letBind_63_, 4
	lw	$4, 0($16)
# was:	lw	_size_reg_197_, 0(_letBind_63_)
	bgez	$3, _safe_lab_200_
# was:	bgez	_arr_ind_195_, _safe_lab_200_
_error_lab_199_:
	ori	$5, $0, 44
# was:	ori	$5, $0, 44
	la	$6, _Msg_IllegalIndex_
# was:	la	$6, _Msg_IllegalIndex_
	j	_RuntimeError_
_safe_lab_200_:
	sub	$4, $3, $4
# was:	sub	_tmp_reg_198_, _arr_ind_195_, _size_reg_197_
	bgez	$4, _error_lab_199_
# was:	bgez	_tmp_reg_198_, _error_lab_199_
	sll	$3, $3, 2
# was:	sll	_arr_ind_195_, _arr_ind_195_, 2
	add	$2, $2, $3
# was:	add	_arr_reg_196_, _arr_reg_196_, _arr_ind_195_
	lw	$16, 0($2)
# was:	lw	_tmp_194_, 0(_arr_reg_196_)
# 	ori	_mainres_1_,_tmp_194_,0
	ori	$2, $16, 0
# was:	ori	$2, _mainres_1_, 0
	jal	putint
# was:	jal	putint, $2
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
_aaMSSPa_193_:
	.space	4
	.asciiz	"\n\nMSSP result is: "
	.align	2
_a__str__33_:
	.space	4
	.asciiz	"\n"
	.align	2
_aa__str_29_:
	.space	4
	.asciiz	": "
	.align	2
_Introdu_24_:
	.space	4
	.asciiz	"Introduce number "
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