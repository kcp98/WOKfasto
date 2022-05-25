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
# Function negation
negation:
	sw	$31, -4($29)
	sw	$16, -8($29)
	addi	$29, $29, -12
# 	ori	_param_a_1_,$2,0
# 	ori	_param_b_2_,$3,0
	ori	$6, $4, 0
# was:	ori	_param_c_3_, $4, 0
# 	ori	_negate_10_,_param_a_1_,0
	sub	$4, $2, $2
# was:	sub	_negated_11_, _negate_10_, _negate_10_
	sub	$4, $4, $2
# was:	sub	_plus_L_8_, _negated_11_, _negate_10_
# 	ori	_times_L_12_,_param_b_2_,0
# 	ori	_times_R_13_,_param_c_3_,0
	mul	$5, $3, $6
# was:	mul	_plus_R_9_, _times_L_12_, _times_R_13_
	add	$5, $4, $5
# was:	add	_eq_L_6_, _plus_L_8_, _plus_R_9_
# 	ori	_times_L_16_,_param_b_2_,0
# 	ori	_times_R_17_,_param_c_3_,0
	mul	$4, $3, $6
# was:	mul	_minus_L_14_, _times_L_16_, _times_R_17_
# 	ori	_minus_R_15_,_param_a_1_,0
	sub	$7, $4, $2
# was:	sub	_eq_R_7_, _minus_L_14_, _minus_R_15_
	ori	$4, $0, 0
# was:	ori	_letBind_5_, $0, 0
	bne	$5, $7, _false_18_
# was:	bne	_eq_L_6_, _eq_R_7_, _false_18_
	ori	$4, $0, 1
# was:	ori	_letBind_5_, $0, 1
_false_18_:
# 	ori	_negate_24_,_param_a_1_,0
	sub	$5, $2, $2
# was:	sub	_negated_25_, _negate_24_, _negate_24_
	sub	$5, $5, $2
# was:	sub	_plus_L_22_, _negated_25_, _negate_24_
# 	ori	_times_L_26_,_param_b_2_,0
# 	ori	_times_R_27_,_param_c_3_,0
	mul	$7, $3, $6
# was:	mul	_plus_R_23_, _times_L_26_, _times_R_27_
	add	$5, $5, $7
# was:	add	_eq_L_20_, _plus_L_22_, _plus_R_23_
# 	ori	_times_L_30_,_param_b_2_,0
# 	ori	_times_R_31_,_param_c_3_,0
	mul	$3, $3, $6
# was:	mul	_minus_L_28_, _times_L_30_, _times_R_31_
# 	ori	_minus_R_29_,_param_a_1_,0
	sub	$3, $3, $2
# was:	sub	_eq_R_21_, _minus_L_28_, _minus_R_29_
	ori	$2, $0, 0
# was:	ori	_letBind_19_, $0, 0
	bne	$5, $3, _false_32_
# was:	bne	_eq_L_20_, _eq_R_21_, _false_32_
	ori	$2, $0, 1
# was:	ori	_letBind_19_, $0, 1
_false_32_:
# 	ori	_eq_L_38_,_letBind_5_,0
	ori	$3, $2, 0
# was:	ori	_eq_R_39_, _letBind_19_, 0
	ori	$2, $0, 0
# was:	ori	_cond_37_, $0, 0
	bne	$4, $3, _false_40_
# was:	bne	_eq_L_38_, _eq_R_39_, _false_40_
	ori	$2, $0, 1
# was:	ori	_cond_37_, $0, 1
_false_40_:
	bne	$2, $0, _then_34_
# was:	bne	_cond_37_, $0, _then_34_
	j	_else_35_
_then_34_:
	ori	$16, $0, 1
# was:	ori	_letBind_33_, $0, 1
	j	_endif_36_
_else_35_:
	ori	$16, $0, 0
# was:	ori	_letBind_33_, $0, 0
_endif_36_:
# 	ori	_tmp_41_,_letBind_33_,0
# 	ori	_negationres_4_,_tmp_41_,0
	ori	$2, $16, 0
# was:	ori	$2, _negationres_4_, 0
	jal	putint
# was:	jal	putint, $2
	ori	$2, $16, 0
# was:	ori	$2, _negationres_4_, 0
	addi	$29, $29, 12
	lw	$16, -8($29)
	lw	$31, -4($29)
	jr	$31
# Function precedence
precedence:
	sw	$31, -4($29)
	sw	$16, -8($29)
	addi	$29, $29, -12
# 	ori	_param_a_42_,$2,0
# 	ori	_param_b_43_,$3,0
# 	ori	_param_c_44_,$4,0
# 	ori	_divide_L_51_,_param_a_42_,0
# 	ori	_divide_R_52_,_param_b_43_,0
	ori	$5, $0, 0
# was:	ori	_zero_54_, $0, 0
	bne	$3, $5, _nonzero_53_
# was:	bne	_divide_R_52_, _zero_54_, _nonzero_53_
	ori	$5, $0, 8
# was:	ori	$5, $0, 8
	la	$6, _Msg_DivZero_
# was:	la	$6, _Msg_DivZero_
	j	_RuntimeError_
_nonzero_53_:
	div	$6, $2, $3
# was:	div	_plus_L_49_, _divide_L_51_, _divide_R_52_
	ori	$5, $0, 4
# was:	ori	_times_L_59_, $0, 4
# 	ori	_negate_61_,_param_a_42_,0
	sub	$7, $2, $2
# was:	sub	_negated_62_, _negate_61_, _negate_61_
	sub	$7, $7, $2
# was:	sub	_times_R_60_, _negated_62_, _negate_61_
	mul	$5, $5, $7
# was:	mul	_divide_L_57_, _times_L_59_, _times_R_60_
# 	ori	_divide_R_58_,_param_a_42_,0
	ori	$7, $0, 0
# was:	ori	_zero_64_, $0, 0
	bne	$2, $7, _nonzero_63_
# was:	bne	_divide_R_58_, _zero_64_, _nonzero_63_
	ori	$5, $0, 8
# was:	ori	$5, $0, 8
	la	$6, _Msg_DivZero_
# was:	la	$6, _Msg_DivZero_
	j	_RuntimeError_
_nonzero_63_:
	div	$5, $5, $2
# was:	div	_times_L_55_, _divide_L_57_, _divide_R_58_
# 	ori	_times_R_56_,_param_c_44_,0
	mul	$5, $5, $4
# was:	mul	_plus_R_50_, _times_L_55_, _times_R_56_
	add	$5, $6, $5
# was:	add	_minus_L_47_, _plus_L_49_, _plus_R_50_
# 	ori	_divide_L_65_,_param_b_43_,0
# 	ori	_divide_R_66_,_param_a_42_,0
	ori	$6, $0, 0
# was:	ori	_zero_68_, $0, 0
	bne	$2, $6, _nonzero_67_
# was:	bne	_divide_R_66_, _zero_68_, _nonzero_67_
	ori	$5, $0, 8
# was:	ori	$5, $0, 8
	la	$6, _Msg_DivZero_
# was:	la	$6, _Msg_DivZero_
	j	_RuntimeError_
_nonzero_67_:
	div	$6, $3, $2
# was:	div	_minus_R_48_, _divide_L_65_, _divide_R_66_
	sub	$5, $5, $6
# was:	sub	_letBind_46_, _minus_L_47_, _minus_R_48_
# 	ori	_divide_L_74_,_param_a_42_,0
# 	ori	_divide_R_75_,_param_b_43_,0
	ori	$6, $0, 0
# was:	ori	_zero_77_, $0, 0
	bne	$3, $6, _nonzero_76_
# was:	bne	_divide_R_75_, _zero_77_, _nonzero_76_
	ori	$5, $0, 9
# was:	ori	$5, $0, 9
	la	$6, _Msg_DivZero_
# was:	la	$6, _Msg_DivZero_
	j	_RuntimeError_
_nonzero_76_:
	div	$6, $2, $3
# was:	div	_plus_L_72_, _divide_L_74_, _divide_R_75_
	ori	$7, $0, 4
# was:	ori	_times_L_82_, $0, 4
	ori	$8, $0, 0
# was:	ori	_minus_L_84_, $0, 0
# 	ori	_minus_R_85_,_param_a_42_,0
	sub	$8, $8, $2
# was:	sub	_times_R_83_, _minus_L_84_, _minus_R_85_
	mul	$7, $7, $8
# was:	mul	_divide_L_80_, _times_L_82_, _times_R_83_
# 	ori	_divide_R_81_,_param_a_42_,0
	ori	$8, $0, 0
# was:	ori	_zero_87_, $0, 0
	bne	$2, $8, _nonzero_86_
# was:	bne	_divide_R_81_, _zero_87_, _nonzero_86_
	ori	$5, $0, 9
# was:	ori	$5, $0, 9
	la	$6, _Msg_DivZero_
# was:	la	$6, _Msg_DivZero_
	j	_RuntimeError_
_nonzero_86_:
	div	$7, $7, $2
# was:	div	_times_L_78_, _divide_L_80_, _divide_R_81_
# 	ori	_times_R_79_,_param_c_44_,0
	mul	$4, $7, $4
# was:	mul	_plus_R_73_, _times_L_78_, _times_R_79_
	add	$4, $6, $4
# was:	add	_minus_L_70_, _plus_L_72_, _plus_R_73_
# 	ori	_divide_L_88_,_param_b_43_,0
# 	ori	_divide_R_89_,_param_a_42_,0
	ori	$6, $0, 0
# was:	ori	_zero_91_, $0, 0
	bne	$2, $6, _nonzero_90_
# was:	bne	_divide_R_89_, _zero_91_, _nonzero_90_
	ori	$5, $0, 9
# was:	ori	$5, $0, 9
	la	$6, _Msg_DivZero_
# was:	la	$6, _Msg_DivZero_
	j	_RuntimeError_
_nonzero_90_:
	div	$2, $3, $2
# was:	div	_minus_R_71_, _divide_L_88_, _divide_R_89_
	sub	$2, $4, $2
# was:	sub	_letBind_69_, _minus_L_70_, _minus_R_71_
# 	ori	_eq_L_97_,_letBind_46_,0
# 	ori	_eq_R_98_,_letBind_69_,0
	ori	$3, $0, 0
# was:	ori	_cond_96_, $0, 0
	bne	$5, $2, _false_99_
# was:	bne	_eq_L_97_, _eq_R_98_, _false_99_
	ori	$3, $0, 1
# was:	ori	_cond_96_, $0, 1
_false_99_:
	bne	$3, $0, _then_93_
# was:	bne	_cond_96_, $0, _then_93_
	j	_else_94_
_then_93_:
	ori	$2, $0, 1
# was:	ori	_letBind_92_, $0, 1
	j	_endif_95_
_else_94_:
	ori	$2, $0, 0
# was:	ori	_letBind_92_, $0, 0
_endif_95_:
# 	ori	_tmp_100_,_letBind_92_,0
	ori	$16, $2, 0
# was:	ori	_precedenceres_45_, _tmp_100_, 0
	ori	$2, $16, 0
# was:	ori	$2, _precedenceres_45_, 0
	jal	putint
# was:	jal	putint, $2
	ori	$2, $16, 0
# was:	ori	$2, _precedenceres_45_, 0
	addi	$29, $29, 12
	lw	$16, -8($29)
	lw	$31, -4($29)
	jr	$31
# Function main
main:
	sw	$31, -4($29)
	addi	$29, $29, -8
	ori	$2, $0, 2
# was:	ori	_arg_103_, $0, 2
	ori	$3, $0, 6
# was:	ori	_arg_104_, $0, 6
	ori	$5, $0, 4
# was:	ori	_minus_L_106_, $0, 4
	ori	$4, $0, 5
# was:	ori	_minus_R_107_, $0, 5
	sub	$4, $5, $4
# was:	sub	_arg_105_, _minus_L_106_, _minus_R_107_
# 	ori	$2,_arg_103_,0
# 	ori	$3,_arg_104_,0
# 	ori	$4,_arg_105_,0
	jal	negation
# was:	jal	negation, $2 $3 $4
# 	ori	_letBind_102_,$2,0
	ori	$2, $0, 2
# was:	ori	_arg_109_, $0, 2
	ori	$3, $0, 6
# was:	ori	_arg_110_, $0, 6
	ori	$5, $0, 4
# was:	ori	_minus_L_112_, $0, 4
	ori	$4, $0, 5
# was:	ori	_minus_R_113_, $0, 5
	sub	$4, $5, $4
# was:	sub	_arg_111_, _minus_L_112_, _minus_R_113_
# 	ori	$2,_arg_109_,0
# 	ori	$3,_arg_110_,0
# 	ori	$4,_arg_111_,0
	jal	precedence
# was:	jal	precedence, $2 $3 $4
# 	ori	_letBind_108_,$2,0
	ori	$2, $0, 1
# was:	ori	_mainres_101_, $0, 1
# 	ori	$2,_mainres_101_,0
	addi	$29, $29, 8
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