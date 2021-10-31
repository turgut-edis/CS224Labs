## ArithmeticCalc.asm - Calculates the following expression
## x = a * (b - c) % d

#		text segment		#

	.text		
	.globl __start	

__start:
	#s0 = result
	addi $s0, $0, 0
	#Print prompt for program and calls system
	la $a0, prompt
	li $v0, 4
	syscall
	#New line
	la $a0, end
	li $v0, 4
	syscall
	#Takes the input a and store in s1
	la $a0, valueIna
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	la $s1, ($v0)
	#Takes the input b and store in s2
	la $a0, valueInb
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	la $s2, ($v0) 
	#Takes the input c and store in s3
	la $a0, valueInc
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	la $s3, ($v0) 
	#Takes the input d and store in s4
	la $a0, valueInd
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	la $s4, ($v0)   
	#s0 = x, s1 = a, s2 = b, s3 = c, s4 = d
	
	sub $t0, $s2, $s3
	mul $t1, $s1, $t0
	div $s0, $t1, $s4 
	
	mfhi $s0
	
	la $a0, answer
	li $v0, 4
	syscall 
	la $a0,($s0)	# output prompt message on terminal
	li $v0,1	# syscall 4 prints the string
	syscall
	la $a0, end
	li $v0, 4
	syscall

	
	li $v0,10	# system call to exit
	syscall		


#     	 data segment		#

	.data
prompt:	.asciiz "x = a * (b-c) % d"
valueIna: .asciiz "Please enter value for a: "
valueInb: .asciiz "Please enter value for b: "
valueInc: .asciiz "Please enter value for c: "
valueInd: .asciiz "Please enter value for d: "
answer:	.asciiz "The result for the expression is "
end:	.asciiz "\n"

##
## end of file ArithmeticCalc.asm

