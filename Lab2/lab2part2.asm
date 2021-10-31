#Lab2 - Part 2
#Takes a decimal number, converts to hexadecimal and reverses the hex number
#text segment

.text	
main:
	li $a0, 30
	li $v0, 34
	syscall
	la $a0, endl
	li $v0, 4
	syscall
	li $a0, 30
	jal reverseNumber
	move $a0, $v0
	li $v0, 34
	syscall
	li $v0, 10
	syscall 	# exit


reverseNumber:
	# allocate space for variables
	addi $sp, $sp, -16
	sw $s0, 12($sp)
	sw $s1, 8($sp)	
	sw $s2, 4($sp)
	sw $s3, 0($sp)	
	# Load array with decimal value
	move $s1, $a0	
	li $s0, 0		# 
	li $s3, 0 		# reverse hex value
	li $s2, 15 		# 
	# Reverse the number
	next:
		beq $s1, $zero, end 	# check whether any value left
		and $s0, $s1, $s2 	# obtain the current integer 
		or $s3, $s3, $s0 	# write to reversed
		srl $s1, $s1, 4 	#obtain the next decimal val
		sll $s3, $s3, 4 	#open place for new dec value
		li $s0, 0 		# reset temp
		j next
	end:
		srl $s3, $s3, 4 	# reverse the extra shift
		move $v0, $s3 		# return the result
	#restore 
	lw $s3, 0($sp)
	lw $s2, 4($sp)
	lw $s1, 8($sp)
	lw $s0, 12($sp)
	addi $sp, $sp, 16
	jr $ra
				 	
#data segment
	.data
endl: .asciiz "\n"