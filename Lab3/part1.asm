#Lab 3 - Part 1 Non recursive instruction counter
#instCnt - Counts the instructions of add and lw

.data
bye: .asciiz "\nGoodbye!!"
addcntt: .asciiz "\nThe count add in main is "
addcnts: .asciiz "\nThe count add in subprogram is "
lwcntt: .asciiz "\nThe count lw in main is "
lwcnts: .asciiz "\nThe count lw in subprogram is "

.text

main:
	L1:
		la $a0, L1
		la $a1, L2
		
		jal instCnt
		move $s0, $v0 #lw
		move $s1, $v1 #add
		
		add $s4, $s4, $0
		add $s3, $0, $s3
		
		la $a0, addcntt
		li $v0, 4
		syscall
		
		la $a0, ($s1)
		li $v0, 1
		syscall
		
		la $a0, lwcntt
		li $v0, 4
		syscall
		
		la $a0, ($s0)
		li $v0, 1
		syscall
		
		la $a0, start
		la $a1, end
		
		jal instCnt
		add $s0, $v0, $0
		move $s1, $v1
		
		la $a0, addcnts
		li $v0, 4
		syscall
		
		la $a0, ($s1)
		li $v0, 1
		syscall
		
		la $a0, lwcnts
		li $v0, 4
		syscall
		
		la $a0, ($s0)
		li $v0, 1
		syscall
		
		add $s7, $0, $s7
		add $s6, $s6, $0
	
		la $a0, bye
		li $v0, 4
		syscall
		
		add $s5, $s5, $0
	L2:
		li $v0, 10
		syscall
#v0, lw count
#v1, add count	
instCnt:
	start:
	addi $sp, $sp, -28
	sw $s0, 24($sp)
	sw $s1, 20($sp)
	sw $s2, 16($sp)
	sw $s3, 12($sp)
	sw $s4, 8($sp)
	sw $s5, 4($sp)
	sw $s6, 0($sp)
	
	la $s0, ($a0)
	la $s1, ($a1)
	addi $s2, $0, 0 #lw count
	addi $s3, $0, 0 #add count
	
	cntLoop:
		beq $s0, $s1, endCount
		lw $s6, ($s0)
		sll $s4, $s6, 26
		srl $s4, $s4, 26 #take function code
		srl $s5, $s6, 26 #take opcode
		
		beq $s4, 32, countadd
		beq $s5, 35, countlw
		
		addi $s0, $s0, 4
		j cntLoop
		
		countlw:
			addi $s2, $s2, 1
			addi $s0, $s0, 4
			j cntLoop
		countadd:
			addi $s3, $s3, 1
			addi $s0, $s0, 4
			j cntLoop
	endCount:
		move $v0, $s2 #lw count
		move $v1, $s3 #add count
		sw $s6, 0($sp)
		sw $s5, 4($sp)
		sw $s4, 8($sp)
		sw $s3, 12($sp)
		sw $s2, 16($sp)
		sw $s1, 20($sp)
		sw $s0, 24($sp)
		addi $sp, $sp, 28
	end:
		jr $ra