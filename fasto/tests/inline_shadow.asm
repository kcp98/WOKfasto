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
# Function zero
zero:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	_param_b_1_,$2,0
# 	ori	_cond_6_,_param_b_1_,0
	bne	$2, $0, _then_3_
# was:	bne	_cond_6_, $0, _then_3_
	j	_else_4_
_then_3_:
	ori	$2, $0, 0
# was:	ori	_zerores_2_, $0, 0
	j	_endif_5_
_else_4_:
# 	ori	_arg_7_,_param_b_1_,0
# 	ori	$2,_arg_7_,0
	jal	zero
# was:	jal	zero, $2
# 	ori	_zerores_2_,$2,0
_endif_5_:
# 	ori	$2,_zerores_2_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
# Function main
main:
	sw	$31, -4($29)
	sw	$17, -12($29)
	sw	$16, -8($29)
	addi	$29, $29, -16
	ori	$16, $0, 4132
# was:	ori	_tmp_10_, $0, 4132
# 	ori	_letBind_9_,_tmp_10_,0
	ori	$2, $16, 0
# was:	ori	$2, _letBind_9_, 0
	jal	putint
# was:	jal	putint, $2
	ori	$2, $0, 1
# was:	ori	_arg_14_, $0, 1
# 	ori	$2,_arg_14_,0
	jal	zero
# was:	jal	zero, $2
	ori	$6, $2, 0
# was:	ori	_letBind_13_, $2, 0
	ori	$2, $0, 1
# was:	ori	_plus_L_16_, $0, 1
# 	ori	_plus_R_17_,_letBind_13_,0
	add	$4, $2, $6
# was:	add	_letBind_15_, _plus_L_16_, _plus_R_17_
	ori	$2, $0, 2
# was:	ori	_plus_L_19_, $0, 2
# 	ori	_plus_R_20_,_letBind_13_,0
	add	$2, $2, $6
# was:	add	_letBind_18_, _plus_L_19_, _plus_R_20_
	ori	$3, $0, 3
# was:	ori	_plus_L_22_, $0, 3
# 	ori	_plus_R_23_,_letBind_13_,0
	add	$3, $3, $6
# was:	add	_letBind_21_, _plus_L_22_, _plus_R_23_
	ori	$5, $0, 4
# was:	ori	_plus_L_25_, $0, 4
# 	ori	_plus_R_26_,_letBind_13_,0
	add	$6, $5, $6
# was:	add	_letBind_24_, _plus_L_25_, _plus_R_26_
	ori	$5, $0, 1000
# was:	ori	_mult1_L_33_, $0, 1000
# 	ori	_mult2_R_34_,_letBind_24_,0
	mul	$5, $5, $6
# was:	mul	_plus_L_31_, _mult1_L_33_, _mult2_R_34_
	ori	$6, $0, 100
# was:	ori	_mult1_L_35_, $0, 100
# 	ori	_mult2_R_36_,_letBind_15_,0
	mul	$4, $6, $4
# was:	mul	_plus_R_32_, _mult1_L_35_, _mult2_R_36_
	add	$5, $5, $4
# was:	add	_plus_L_29_, _plus_L_31_, _plus_R_32_
	ori	$4, $0, 10
# was:	ori	_mult1_L_37_, $0, 10
# 	ori	_mult2_R_38_,_letBind_21_,0
	mul	$3, $4, $3
# was:	mul	_plus_R_30_, _mult1_L_37_, _mult2_R_38_
	add	$3, $5, $3
# was:	add	_plus_L_27_, _plus_L_29_, _plus_R_30_
# 	ori	_plus_R_28_,_letBind_18_,0
	add	$17, $3, $2
# was:	add	_tmp_12_, _plus_L_27_, _plus_R_28_
# 	ori	_letBind_11_,_tmp_12_,0
	ori	$2, $17, 0
# was:	ori	$2, _letBind_11_, 0
	jal	putint
# was:	jal	putint, $2
	ori	$2, $0, 10000
# was:	ori	_mult1_L_41_, $0, 10000
# 	ori	_mult2_R_42_,_letBind_9_,0
	mul	$2, $2, $16
# was:	mul	_plus_L_39_, _mult1_L_41_, _mult2_R_42_
# 	ori	_plus_R_40_,_letBind_11_,0
	add	$2, $2, $17
# was:	add	_mainres_8_, _plus_L_39_, _plus_R_40_
# 	ori	$2,_mainres_8_,0
	addi	$29, $29, 16
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