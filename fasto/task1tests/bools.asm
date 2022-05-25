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
# Function tobe
tobe:
	sw	$31, -4($29)
	sw	$16, -8($29)
	addi	$29, $29, -12
# 	ori	_param_to_1_,$2,0
	ori	$9, $3, 0
# was:	ori	_param_be_2_, $3, 0
# 	ori	_not_9_,_param_to_1_,0
	xori	$3, $2, 1
# was:	xori	_eq_L_7_, _not_9_, 1
# 	ori	_eq_R_8_,_param_be_2_,0
	ori	$4, $0, 0
# was:	ori	_or_L_5_, $0, 0
	bne	$3, $9, _false_10_
# was:	bne	_eq_L_7_, _eq_R_8_, _false_10_
	ori	$4, $0, 1
# was:	ori	_or_L_5_, $0, 1
_false_10_:
	ori	$3, $0, 1
# was:	ori	_letBind_4_, $0, 1
	ori	$5, $4, 1
# was:	ori	_true_21_, _or_L_5_, 1
	beq	$4, $5, _return_20_
# was:	beq	_or_L_5_, _true_21_, _return_20_
# 	ori	_not_13_,_param_to_1_,0
	xori	$7, $2, 1
# was:	xori	_and_L_11_, _not_13_, 1
	ori	$4, $0, 0
# was:	ori	_or_R_6_, $0, 0
	ori	$6, $7, 1
# was:	ori	_true_19_, _and_L_11_, 1
	bne	$7, $6, _return_18_
# was:	bne	_and_L_11_, _true_19_, _return_18_
# 	ori	_eq_L_14_,_param_be_2_,0
	ori	$7, $0, 1
# was:	ori	_not_16_, $0, 1
	xori	$7, $7, 1
# was:	xori	_eq_R_15_, _not_16_, 1
	ori	$8, $0, 0
# was:	ori	_and_R_12_, $0, 0
	bne	$9, $7, _false_17_
# was:	bne	_eq_L_14_, _eq_R_15_, _false_17_
	ori	$8, $0, 1
# was:	ori	_and_R_12_, $0, 1
_false_17_:
	bne	$8, $6, _return_18_
# was:	bne	_and_R_12_, _true_19_, _return_18_
	ori	$4, $0, 1
# was:	ori	_or_R_6_, $0, 1
_return_18_:
	beq	$4, $5, _return_20_
# was:	beq	_or_R_6_, _true_21_, _return_20_
	ori	$3, $0, 0
# was:	ori	_letBind_4_, $0, 0
_return_20_:
# 	ori	_not_27_,_param_to_1_,0
	xori	$4, $2, 1
# was:	xori	_eq_L_25_, _not_27_, 1
# 	ori	_eq_R_26_,_param_be_2_,0
	ori	$6, $0, 0
# was:	ori	_or_L_23_, $0, 0
	bne	$4, $9, _false_28_
# was:	bne	_eq_L_25_, _eq_R_26_, _false_28_
	ori	$6, $0, 1
# was:	ori	_or_L_23_, $0, 1
_false_28_:
	ori	$4, $0, 1
# was:	ori	_letBind_22_, $0, 1
	ori	$5, $6, 1
# was:	ori	_true_39_, _or_L_23_, 1
	beq	$6, $5, _return_38_
# was:	beq	_or_L_23_, _true_39_, _return_38_
# 	ori	_not_31_,_param_to_1_,0
	xori	$7, $2, 1
# was:	xori	_and_L_29_, _not_31_, 1
	ori	$6, $0, 0
# was:	ori	_or_R_24_, $0, 0
	ori	$2, $7, 1
# was:	ori	_true_37_, _and_L_29_, 1
	bne	$7, $2, _return_36_
# was:	bne	_and_L_29_, _true_37_, _return_36_
# 	ori	_eq_L_32_,_param_be_2_,0
	ori	$7, $0, 1
# was:	ori	_not_34_, $0, 1
	xori	$7, $7, 1
# was:	xori	_eq_R_33_, _not_34_, 1
	ori	$8, $0, 0
# was:	ori	_and_R_30_, $0, 0
	bne	$9, $7, _false_35_
# was:	bne	_eq_L_32_, _eq_R_33_, _false_35_
	ori	$8, $0, 1
# was:	ori	_and_R_30_, $0, 1
_false_35_:
	bne	$8, $2, _return_36_
# was:	bne	_and_R_30_, _true_37_, _return_36_
	ori	$6, $0, 1
# was:	ori	_or_R_24_, $0, 1
_return_36_:
	beq	$6, $5, _return_38_
# was:	beq	_or_R_24_, _true_39_, _return_38_
	ori	$4, $0, 0
# was:	ori	_letBind_22_, $0, 0
_return_38_:
# 	ori	_eq_L_44_,_letBind_4_,0
# 	ori	_eq_R_45_,_letBind_22_,0
	ori	$2, $0, 0
# was:	ori	_cond_43_, $0, 0
	bne	$3, $4, _false_46_
# was:	bne	_eq_L_44_, _eq_R_45_, _false_46_
	ori	$2, $0, 1
# was:	ori	_cond_43_, $0, 1
_false_46_:
	bne	$2, $0, _then_40_
# was:	bne	_cond_43_, $0, _then_40_
	j	_else_41_
_then_40_:
	ori	$16, $0, 1
# was:	ori	_tmp_47_, $0, 1
# 	ori	_toberes_3_,_tmp_47_,0
	ori	$2, $16, 0
# was:	ori	$2, _toberes_3_, 0
	jal	putint
# was:	jal	putint, $2
	j	_endif_42_
_else_41_:
	ori	$16, $0, 0
# was:	ori	_tmp_48_, $0, 0
# 	ori	_toberes_3_,_tmp_48_,0
	ori	$2, $16, 0
# was:	ori	$2, _toberes_3_, 0
	jal	putint
# was:	jal	putint, $2
_endif_42_:
	ori	$2, $16, 0
# was:	ori	$2, _toberes_3_, 0
	addi	$29, $29, 12
	lw	$16, -8($29)
	lw	$31, -4($29)
	jr	$31
# Function main
main:
	sw	$31, -4($29)
	addi	$29, $29, -8
	ori	$2, $0, 1
# was:	ori	_arg_51_, $0, 1
	ori	$3, $0, 1
# was:	ori	_arg_52_, $0, 1
# 	ori	$2,_arg_51_,0
# 	ori	$3,_arg_52_,0
	jal	tobe
# was:	jal	tobe, $2 $3
# 	ori	_letBind_50_,$2,0
	ori	$2, $0, 1
# was:	ori	_arg_54_, $0, 1
	ori	$3, $0, 0
# was:	ori	_arg_55_, $0, 0
# 	ori	$2,_arg_54_,0
# 	ori	$3,_arg_55_,0
	jal	tobe
# was:	jal	tobe, $2 $3
# 	ori	_letBind_53_,$2,0
	ori	$2, $0, 0
# was:	ori	_arg_57_, $0, 0
	ori	$3, $0, 1
# was:	ori	_arg_58_, $0, 1
# 	ori	$2,_arg_57_,0
# 	ori	$3,_arg_58_,0
	jal	tobe
# was:	jal	tobe, $2 $3
# 	ori	_letBind_56_,$2,0
	ori	$2, $0, 0
# was:	ori	_arg_60_, $0, 0
	ori	$3, $0, 0
# was:	ori	_arg_61_, $0, 0
# 	ori	$2,_arg_60_,0
# 	ori	$3,_arg_61_,0
	jal	tobe
# was:	jal	tobe, $2 $3
# 	ori	_letBind_59_,$2,0
	ori	$2, $0, 1
# was:	ori	_mainres_49_, $0, 1
# 	ori	$2,_mainres_49_,0
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