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
	ori	$3, $0, 40
# was:	ori	_size_reg_3_, $0, 40
	bgez	$3, _safe_lab_4_
# was:	bgez	_size_reg_3_, _safe_lab_4_
	ori	$5, $0, 3
# was:	ori	$5, $0, 3
	la	$6, _Msg_IllegalArraySize_
# was:	la	$6, _Msg_IllegalArraySize_
	j	_RuntimeError_
_safe_lab_4_:
	ori	$2, $28, 0
# was:	ori	_letBind_2_, $28, 0
	sll	$4, $3, 2
# was:	sll	_tmp_10_, _size_reg_3_, 2
	addi	$4, $4, 4
# was:	addi	_tmp_10_, _tmp_10_, 4
	add	$28, $28, $4
# was:	add	$28, $28, _tmp_10_
	sw	$3, 0($2)
# was:	sw	_size_reg_3_, 0(_letBind_2_)
	addi	$6, $2, 4
# was:	addi	_addr_reg_5_, _letBind_2_, 4
	ori	$5, $0, 0
# was:	ori	_i_reg_6_, $0, 0
_loop_beg_7_:
	sub	$4, $5, $3
# was:	sub	_tmp_reg_9_, _i_reg_6_, _size_reg_3_
	bgez	$4, _loop_end_8_
# was:	bgez	_tmp_reg_9_, _loop_end_8_
	sw	$5, 0($6)
# was:	sw	_i_reg_6_, 0(_addr_reg_5_)
	addi	$6, $6, 4
# was:	addi	_addr_reg_5_, _addr_reg_5_, 4
	addi	$5, $5, 1
# was:	addi	_i_reg_6_, _i_reg_6_, 1
	j	_loop_beg_7_
_loop_end_8_:
	ori	$4, $0, 4
# was:	ori	_arr_ind_12_, $0, 4
	addi	$3, $2, 4
# was:	addi	_arr_reg_13_, _letBind_2_, 4
	lw	$2, 0($2)
# was:	lw	_size_reg_14_, 0(_letBind_2_)
	bgez	$4, _safe_lab_17_
# was:	bgez	_arr_ind_12_, _safe_lab_17_
_error_lab_16_:
	ori	$5, $0, 5
# was:	ori	$5, $0, 5
	la	$6, _Msg_IllegalIndex_
# was:	la	$6, _Msg_IllegalIndex_
	j	_RuntimeError_
_safe_lab_17_:
	sub	$2, $4, $2
# was:	sub	_tmp_reg_15_, _arr_ind_12_, _size_reg_14_
	bgez	$2, _error_lab_16_
# was:	bgez	_tmp_reg_15_, _error_lab_16_
	sll	$4, $4, 2
# was:	sll	_arr_ind_12_, _arr_ind_12_, 2
	add	$3, $3, $4
# was:	add	_arr_reg_13_, _arr_reg_13_, _arr_ind_12_
	lw	$16, 0($3)
# was:	lw	_letBind_11_, 0(_arr_reg_13_)
# 	ori	_tmp_18_,_letBind_11_,0
# 	ori	_mainres_1_,_tmp_18_,0
	ori	$2, $16, 0
# was:	ori	$2, _mainres_1_, 0
	jal	putint
# was:	jal	putint, $2
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