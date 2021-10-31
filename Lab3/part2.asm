# Lab 3 - Part 2 Recursive Division
# divRec - Recursive subprogram that dividing recursively

.data
cont: .asciiz "\nDo you wanna continue (1 yes, 0 no): "
divid: .asciiz "Please enter divided number: "
divid1: .asciiz "Please enter divider number: "
conc: .asciiz "The division of "
conc1: .asciiz " by "
conc2: .asciiz " is "
goodbyemes: .asciiz "Goodbye!!"

.text
main:
	addi $s0, $0, 1 	#s0 is determinant of continuation
	contloop:
		beq $s0, $0, end #If user do not want to continue, the program ends
		
		la $a0, divid
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		move $s1, $v0
		
		la $a0, divid1
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		move $s2, $v0
		
		move $a0, $s1
		move $a1, $s2
		jal divRec		
		move $s3, $v0
		
		la $a0, conc
		li $v0, 4
		syscall
		
		la $a0, ($s1)
		li $v0, 1
		syscall
		
		la $a0, conc1
		li $v0, 4
		syscall
		
		la $a0, ($s2)
		li $v0, 1
		syscall
		
		la $a0, conc2
		li $v0, 4
		syscall
		
		la $a0, ($s3)
		li $v0, 1
		syscall
		
		
		la $a0, cont
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		move $s0, $v0
		j contloop
	end:
		la $a0, goodbyemes
		li $v0, 4
		syscall
		li $v0, 10
		syscall
#a0, divided num
#a1, divider num
#v0, result
divRec:
	addi $sp, $sp, -20
	sw $s1, 16($sp)
	sw $s2, 12($sp)
	sw $a0, 8($sp)
	sw $a1, 4($sp)
	sw $ra, 0($sp)
	sge $s1, $a0 , $a1	#if a0 > a1, continue
	bne $s1, $0, conti
	addi $v0, $0, 0		#else, return 0
	addi $sp, $sp, 20	#fill stack
	jr $ra
conti:
	sub $a0, $a0, $a1	# a0 = a0 - a1
	jal divRec		#recursive call
	
	lw $s1, 16($sp)
	lw $s2, 12($sp)
	lw $a0, 8($sp)
	lw $a1, 4($sp)
	addi $v0, $v0, 1	#add recursively
	lw $ra, 0($sp)
	addi $sp, $sp, 20
	jr $ra			#return
