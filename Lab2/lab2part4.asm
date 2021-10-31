#Lab 2 Part 4 - Count the pattern in given number and return the value
#countBitPat - Counts the occurence of bit pattern in given number
.text

main:
	la $a0, prompt
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	add $a0, $0, $v0
	li $v0, 34
	syscall
	move $s0, $a0
	la $a0, endLine
	li $v0, 4
	syscall
	
	
	la $a0, prompt1
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	add $a0, $0, $v0
	li $v0, 34
	syscall
	move $s1, $a0
	la $a0, endLine
	li $v0, 4
	syscall
	
	la $a0, prompt2
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s2, $v0
	
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	
	jal countBitPat
	
	move $a0, $v0
	li $v0, 1
	syscall
	li $v0, 10
	syscall
	
countBitPat:
	addi $sp, $sp, -32
	sw $s0, 28($sp)
	sw $s1, 24($sp)
	sw $s2, 20($sp)
	sw $s3, 16($sp)
	sw $s4, 12($sp)
	sw $s5, 8($sp)
	sw $s6, 4($sp)
	sw $a1, 0($sp)
	
	addi $s0, $0, 0 	#s0 holds i for inner loop
	addi $s3, $0, 0		#s3 holds count
	addi $s5, $s5, 0	#s5 holds j for out loop
	addi $s4, $0, 32	#max byte number
	div $s4, $s4, $a2	#max/pattern count for out loop
	move $s6, $a0		#s6 = pattern
	bitLoop:
		bge $s0, $a2, doneP 	#if i = pattern cnt => finish the loop
		addi $s2, $0, 1 	
		and $s2, $s2, $s6	#s2 holds least significant bit
		and $s1, $s2, $a1	#first bytes of number
		bne $s1, $s2, waitNext	#if they are not equal move them until pattern ends
		
		srl $a1, $a1, 1		#shift right main number 1 byte 
		srl $s6, $s6, 1		#shift right pattern 1 byte
		
		add $s0, $s0, 1		#i++
		j bitLoop
	waitNext:
		beq $s0, $a2, doneWP	#if the pattern done, go to done without increment
		srl $a1, $a1, 1		
		srl $s6, $s6, 1	
		addi  $s2, $0, 1 	
		and $s2, $s2, $s6
		add $s0, $s0, 1
		j waitNext
		
	doneP:
		beq $s5, $s4, end	#if j reaches max/pattern, end all loops
		addi $s3, $s3, 1	#count++
		addi $s5, $s5, 1	#j++
		addi $s0, $0, 0		#reset the index
		beq $s6, $0, loadA	
		j bitLoop
	doneWP:
		beq $s5, $s4, end
		addi $s5, $s5, 1
		addi $s0, $0, 0
		beq $s6, $0, loadA
		j bitLoop
	
	loadA:
		move $s6, $a0		#load pattern again if no value left
		j bitLoop
		
	end:
		move $v0, $s3
		lw $a1, 0($sp)
		lw $s6, 4($sp)
		lw $s5, 8($sp)
		lw $s4, 12($sp)
		lw $s3, 16($sp)
		lw $s2, 20($sp)
		lw $s1, 24($sp)
		lw $s0, 28($sp)
		addi $sp, $sp,32
		jr $ra
	

.data
prompt: .asciiz "Enter pattern: "
prompt1: .asciiz "Enter integer value: "
prompt2: .asciiz "Enter pattern count: "
endLine: .asciiz "\n"
