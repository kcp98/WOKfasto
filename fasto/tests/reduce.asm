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
	ori	$4, $0, 3
# was:	ori	_size_reg_9_, $0, 3
	ori	$2, $28, 0
# was:	ori	_arr_reg_3_, $28, 0
	sll	$3, $4, 2
# was:	sll	_tmp_12_, _size_reg_9_, 2
	addi	$3, $3, 4
# was:	addi	_tmp_12_, _tmp_12_, 4
	add	$28, $28, $3
# was:	add	$28, $28, _tmp_12_
	sw	$4, 0($2)
# was:	sw	_size_reg_9_, 0(_arr_reg_3_)
	addi	$4, $2, 4
# was:	addi	_addr_reg_10_, _arr_reg_3_, 4
	ori	$3, $0, 1
# was:	ori	_tmp_reg_11_, $0, 1
	sw	$3, 0($4)
# was:	sw	_tmp_reg_11_, 0(_addr_reg_10_)
	addi	$4, $4, 4
# was:	addi	_addr_reg_10_, _addr_reg_10_, 4
	ori	$3, $0, 2
# was:	ori	_tmp_reg_11_, $0, 2
	sw	$3, 0($4)
# was:	sw	_tmp_reg_11_, 0(_addr_reg_10_)
	addi	$4, $4, 4
# was:	addi	_addr_reg_10_, _addr_reg_10_, 4
	ori	$3, $0, 3
# was:	ori	_tmp_reg_11_, $0, 3
	sw	$3, 0($4)
# was:	sw	_tmp_reg_11_, 0(_addr_reg_10_)
	addi	$4, $4, 4
# was:	addi	_addr_reg_10_, _addr_reg_10_, 4
	lw	$3, 0($2)
# was:	lw	_size_reg_4_, 0(_arr_reg_3_)
	ori	$6, $0, 0
# was:	ori	_letBind_2_, $0, 0
	addi	$2, $2, 4
# was:	addi	_arr_reg_3_, _arr_reg_3_, 4
	ori	$4, $0, 0
# was:	ori	_ind_var_5_, $0, 0
_loop_beg_7_:
	sub	$5, $4, $3
# was:	sub	_tmp_reg_6_, _ind_var_5_, _size_reg_4_
	bgez	$5, _loop_end_8_
# was:	bgez	_tmp_reg_6_, _loop_end_8_
	lw	$5, 0($2)
# was:	lw	_tmp_reg_6_, 0(_arr_reg_3_)
	addi	$2, $2, 4
# was:	addi	_arr_reg_3_, _arr_reg_3_, 4
# 	ori	_plus_L_14_,_letBind_2_,0
# 	ori	_plus_R_15_,_tmp_reg_6_,0
	add	$6, $6, $5
# was:	add	_fun_arg_res_13_, _plus_L_14_, _plus_R_15_
# 	ori	_letBind_2_,_fun_arg_res_13_,0
	addi	$4, $4, 1
# was:	addi	_ind_var_5_, _ind_var_5_, 1
	j	_loop_beg_7_
_loop_end_8_:
# 	ori	_tmp_16_,_letBind_2_,0
	ori	$16, $6, 0
# was:	ori	_mainres_1_, _tmp_16_, 0
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