# Lab2 Part 3 - Process the given array with 4 subprograms
# getArray - returns the first element and size of the array
# PrintArray - Prints the contents of an array
# CheckSymmetric - returns 1 if the array is symmetric, 0 if it is not
# FindMindMax - returns min and max elements in the array
.data
spac: .asciiz " "
prompt: .asciiz "Enter the array size: "
zeroEl: .asciiz "There is no element in the array"
sym: .asciiz "\nThe array is symmetric\n"
symnot: .asciiz "\nThe array is not symmetric\n"
mins: .asciiz "Min: "
maxs: .asciiz "Max: "
elem: .asciiz "Enter the element of array: "


.text 
main:
	
	jal getArray
	move $a0, $v0
	move $a1, $v1
	jal CheckSymmetric	#Call check symmetric
	beq $v0, $0, notsymmetric	#If not symmetric, state in console
	bne $v0, $0, symmetric		#If symmetric, state in console
	continue:		#Continue with find max and min values		
	jal FindMinMax		#return v0 to min, v1 to max
	move $s0, $v0		#s0 min
	move $s1, $v1		#s1 max
	#Print min value
	la $a0, mins
	li $v0, 4
	syscall
	la $a0, ($s0)
	li $v0, 1
	syscall
	#Print max value
	la $a0, maxs
	li $v0, 4
	syscall
	la $a0, ($s1)
	li $v0, 1
	syscall
	li $v0, 10
	syscall
	
	doneZero:
	la $a0, zeroEl
	li $v0, 4
	syscall
	li $v0, 10
	syscall
	
	notsymmetric:
		sw $a0, 0($sp)
		la $a0, symnot
		li $v0, 4
		syscall
		lw $a0, 0($sp)
		j continue
	
	symmetric:
		sw $a0, 0($sp)
		la $a0, sym
		li $v0, 4
		syscall
		lw $a0, 0($sp)
		j continue
		
getArray:
	addi $sp, $sp, -20
	sw $s4, 16($sp)
	sw $s0, 12($sp)
	sw $s1, 8($sp)
	sw $s2, 4($sp)
	sw $s3, 0($sp)
	addi $s2, $0, 0 #s2 = i
	la $a0,prompt	# output prompt message on terminal
	li $v0,4	# syscall 4 prints the string
	syscall

	li $v0, 5	# syscall 5 reads an integer
	syscall
	
	move $v1, $v0
	sll $s0, $v1, 2		#s0 = byte rep of size
	beq $v1, $0, doneZero	#If size = 0, print nothing
	#dynamic allocation
	move $a0, $s0
	li $v0,9
	syscall
	move $s1, $v0 		#s1 = first element address
	move $s4, $s1
	getLoop:
		beq $s2, $v1, doneGet
		la $a0,elem	# output prompt message on terminal
		li $v0,4	# syscall 4 prints the string
		syscall
		li $v0, 5	# syscall 5 reads an integer
		syscall
		move $s3, $v0 	#s3 = element
		sw $s3, 0($s4)
		add $s4, $s4, 4
		add $s2, $s2, 1
		j getLoop
	doneGet:
		j PrintArray
		
	
	PrintArray:
	addi $sp, $sp, -16	#Allocate space to save values
	sw $v0, 12($sp)
	sw $s0, 8($sp)
	sw $s1, 4($sp)
	sw $s2, 0($sp)
	move $s0, $s1
	addi $s1, $0, 0
	beginPrint:
	slt $s2, $s1, $v1
	beq $s2, $0, donePrint	
	sll $s2, $s1, 2
	add $s2, $s2, $s0
	lw $s2, 0($s2)		#t2 = array[i]
	#Print the element array[i]
	la $a0, ($s2)
	li $v0, 1
	syscall
	la $a0, spac
	li $v0, 4
	syscall
	add $s1, $s1, 1		#i = i + 1
	j beginPrint
	donePrint: 
	move $a0, $s0
	lw $s2, 0($sp)
	lw $s1, 4($sp)
	lw $s0, 8($sp)
	lw $v0, 12($sp)
	addi $sp, $sp, 12
	
	move $v0, $s1
	lw $s3, 0($sp)
	lw $s2, 4($sp)
	lw $s1, 8($sp)
	lw $s0, 12($sp)
	lw $s4, 16($sp)
	addi $sp, $sp, 20
	jr $ra
	
	

CheckSymmetric:
	addi $sp, $sp, -20	#Allocate space to save values
	sw $a0, 16($sp)
	sw $s0, 12($sp)
	sw $s1, 8($sp)
	sw $s2, 4($sp)
	sw $s3, 0($sp)
	addi $s0, $0, 0
	add $s1, $a1, -1
	continueCheck:
	bgt $s0, $s1, doneCheck
	sll $s2, $s0, 2
	sll $s3, $s1, 2
	add $s2, $s2, $a0
	add $s3, $s3, $a0
	lw $s2, 0($s2)
	lw $s3, 0($s3)
	bne $s2, $s3, doneNot
	add $s0, $s0, 1
	add $s1, $s1, -1
	j continueCheck
	doneNot:
	lw $s3, 0($sp)
	lw $s2, 4($sp)
	lw $s1, 8($sp)
	lw $s0, 12($sp)
	lw $a0, 16($sp)
	addi $sp, $sp, 20
	addi $v0, $0, 0
	jr $ra
	doneCheck:
	lw $s3, 0($sp)
	lw $s2, 4($sp)
	lw $s1, 8($sp)
	lw $s0, 12($sp)
	lw $a0, 16($sp)
	addi $sp, $sp, 20
	addi $v0, $0, 1
	jr $ra
	
FindMinMax:
	addi $sp, $sp, -16
	sw $s0, 12($sp)
	sw $s1, 8($sp)
	sw $s2, 4($sp)
	sw $s3, 0($sp)
	addi $s0, $0, 0		#i = 0
	lw $v0, 0($a0)		#v0 = min
	lw $v1, 0($a0)		#v1 = max
	con:
	slt $s1, $s0, $a1
	beq $s1, $0, done
	sll $s1, $s0, 2
	add $s1, $s1, $a0
	lw $s1, 0($s1)
	add $s0, $s0, 1
	sge $s3, $s1, $v1
	bne $s3, $0, max
	sle $s2, $s1, $v0
	bne $s2, $0, min
	j con	
	max:
	move $v1, $s1
	j con
	min:
	move $v0, $s1
	j con
	done:
	lw $s3, 0($sp)
	lw $s2, 4($sp)
	lw $s1, 8($sp)
	lw $s0, 12($sp)
	addi $sp, $sp, 16
	jr $ra 
