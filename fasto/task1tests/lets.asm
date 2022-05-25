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
	sw	$16, -8($29)
	addi	$29, $29, -12
	ori	$3, $0, 3
# was:	ori	_letBind_3_, $0, 3
	ori	$2, $0, 2
# was:	ori	_times_L_5_, $0, 2
# 	ori	_times_R_6_,_letBind_3_,0
	mul	$5, $2, $3
# was:	mul	_letBind_4_, _times_L_5_, _times_R_6_
# 	ori	_plus_L_9_,_letBind_4_,0
	ori	$2, $0, 4
# was:	ori	_plus_R_10_, $0, 4
	add	$6, $5, $2
# was:	add	_size_reg_8_, _plus_L_9_, _plus_R_10_
	bgez	$6, _safe_lab_11_
# was:	bgez	_size_reg_8_, _safe_lab_11_
	ori	$5, $0, 2
# was:	ori	$5, $0, 2
	la	$6, _Msg_IllegalArraySize_
# was:	la	$6, _Msg_IllegalArraySize_
	j	_RuntimeError_
_safe_lab_11_:
	ori	$4, $28, 0
# was:	ori	_letBind_7_, $28, 0
	sll	$2, $6, 2
# was:	sll	_tmp_17_, _size_reg_8_, 2
	addi	$2, $2, 4
# was:	addi	_tmp_17_, _tmp_17_, 4
	add	$28, $28, $2
# was:	add	$28, $28, _tmp_17_
	sw	$6, 0($4)
# was:	sw	_size_reg_8_, 0(_letBind_7_)
	addi	$2, $4, 4
# was:	addi	_addr_reg_12_, _letBind_7_, 4
	ori	$7, $0, 0
# was:	ori	_i_reg_13_, $0, 0
_loop_beg_14_:
	sub	$3, $7, $6
# was:	sub	_tmp_reg_16_, _i_reg_13_, _size_reg_8_
	bgez	$3, _loop_end_15_
# was:	bgez	_tmp_reg_16_, _loop_end_15_
	sw	$7, 0($2)
# was:	sw	_i_reg_13_, 0(_addr_reg_12_)
	addi	$2, $2, 4
# was:	addi	_addr_reg_12_, _addr_reg_12_, 4
	addi	$7, $7, 1
# was:	addi	_i_reg_13_, _i_reg_13_, 1
	j	_loop_beg_14_
_loop_end_15_:
# 	ori	_arr_ind_18_,_letBind_4_,0
	addi	$2, $4, 4
# was:	addi	_arr_reg_19_, _letBind_7_, 4
	lw	$3, 0($4)
# was:	lw	_size_reg_20_, 0(_letBind_7_)
	bgez	$5, _safe_lab_23_
# was:	bgez	_arr_ind_18_, _safe_lab_23_
_error_lab_22_:
	ori	$5, $0, 2
# was:	ori	$5, $0, 2
	la	$6, _Msg_IllegalIndex_
# was:	la	$6, _Msg_IllegalIndex_
	j	_RuntimeError_
_safe_lab_23_:
	sub	$3, $5, $3
# was:	sub	_tmp_reg_21_, _arr_ind_18_, _size_reg_20_
	bgez	$3, _error_lab_22_
# was:	bgez	_tmp_reg_21_, _error_lab_22_
	sll	$5, $5, 2
# was:	sll	_arr_ind_18_, _arr_ind_18_, 2
	add	$2, $2, $5
# was:	add	_arr_reg_19_, _arr_reg_19_, _arr_ind_18_
	lw	$2, 0($2)
# was:	lw	_letBind_2_, 0(_arr_reg_19_)
	ori	$4, $0, 3
# was:	ori	_letBind_25_, $0, 3
	ori	$3, $0, 2
# was:	ori	_times_L_27_, $0, 2
# 	ori	_times_R_28_,_letBind_25_,0
	mul	$4, $3, $4
# was:	mul	_letBind_26_, _times_L_27_, _times_R_28_
# 	ori	_plus_L_31_,_letBind_26_,0
	ori	$3, $0, 4
# was:	ori	_plus_R_32_, $0, 4
	add	$5, $4, $3
# was:	add	_size_reg_30_, _plus_L_31_, _plus_R_32_
	bgez	$5, _safe_lab_33_
# was:	bgez	_size_reg_30_, _safe_lab_33_
	ori	$5, $0, 3
# was:	ori	$5, $0, 3
	la	$6, _Msg_IllegalArraySize_
# was:	la	$6, _Msg_IllegalArraySize_
	j	_RuntimeError_
_safe_lab_33_:
	ori	$3, $28, 0
# was:	ori	_letBind_29_, $28, 0
	sll	$6, $5, 2
# was:	sll	_tmp_39_, _size_reg_30_, 2
	addi	$6, $6, 4
# was:	addi	_tmp_39_, _tmp_39_, 4
	add	$28, $28, $6
# was:	add	$28, $28, _tmp_39_
	sw	$5, 0($3)
# was:	sw	_size_reg_30_, 0(_letBind_29_)
	addi	$7, $3, 4
# was:	addi	_addr_reg_34_, _letBind_29_, 4
	ori	$8, $0, 0
# was:	ori	_i_reg_35_, $0, 0
_loop_beg_36_:
	sub	$6, $8, $5
# was:	sub	_tmp_reg_38_, _i_reg_35_, _size_reg_30_
	bgez	$6, _loop_end_37_
# was:	bgez	_tmp_reg_38_, _loop_end_37_
	sw	$8, 0($7)
# was:	sw	_i_reg_35_, 0(_addr_reg_34_)
	addi	$7, $7, 4
# was:	addi	_addr_reg_34_, _addr_reg_34_, 4
	addi	$8, $8, 1
# was:	addi	_i_reg_35_, _i_reg_35_, 1
	j	_loop_beg_36_
_loop_end_37_:
	ori	$5, $4, 0
# was:	ori	_arr_ind_40_, _letBind_26_, 0
	addi	$4, $3, 4
# was:	addi	_arr_reg_41_, _letBind_29_, 4
	lw	$3, 0($3)
# was:	lw	_size_reg_42_, 0(_letBind_29_)
	bgez	$5, _safe_lab_45_
# was:	bgez	_arr_ind_40_, _safe_lab_45_
_error_lab_44_:
	ori	$5, $0, 3
# was:	ori	$5, $0, 3
	la	$6, _Msg_IllegalIndex_
# was:	la	$6, _Msg_IllegalIndex_
	j	_RuntimeError_
_safe_lab_45_:
	sub	$3, $5, $3
# was:	sub	_tmp_reg_43_, _arr_ind_40_, _size_reg_42_
	bgez	$3, _error_lab_44_
# was:	bgez	_tmp_reg_43_, _error_lab_44_
	sll	$5, $5, 2
# was:	sll	_arr_ind_40_, _arr_ind_40_, 2
	add	$4, $4, $5
# was:	add	_arr_reg_41_, _arr_reg_41_, _arr_ind_40_
	lw	$3, 0($4)
# was:	lw	_letBind_24_, 0(_arr_reg_41_)
# 	ori	_eq_L_47_,_letBind_2_,0
# 	ori	_eq_R_48_,_letBind_24_,0
	ori	$16, $0, 0
# was:	ori	_tmp_46_, $0, 0
	bne	$2, $3, _false_49_
# was:	bne	_eq_L_47_, _eq_R_48_, _false_49_
	ori	$16, $0, 1
# was:	ori	_tmp_46_, $0, 1
_false_49_:
# 	ori	_mainres_1_,_tmp_46_,0
	la	$2, _true
# was:	la	$2, _true
	bne	$16, $0, _wBoolF_50_
# was:	bne	_mainres_1_, $0, _wBoolF_50_
	la	$2, _false
# was:	la	$2, _false
_wBoolF_50_:
	jal	putstring
# was:	jal	putstring, $2
	ori	$2, $16, 0
# was:	ori	$2, _mainres_1_, 0
	addi	$29, $29, 12
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