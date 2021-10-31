## Part 4 - Takes input from user and calculates given arithmetic operation
## A = (B % C + D) / B * (C - D)

#text segment#

.text
		
start:
	
	addi $s0, $0, 0		#s0 = result
	
	la $a0, prompt		#Print prompt for program and calls system
	li $v0, 4
	syscall
	
	la $a0, endL		#New line
	li $v0, 4
	syscall
	
	la $a0, valueInb	#Takes the input b and store in s1
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	la $s1, ($v0) 
	
	la $a0, valueInc	#Takes the input c and store in s2
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	la $s2, ($v0) 
	
	la $a0, valueInd	#Takes the input d and store in s3
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	la $s3, ($v0)   
	#s0 = a, s1 = b, s2 = c, s3 = d
	
	div $t0, $s1, $s2	#t0 = B / C
	mfhi $t0		#t0 = B % C
	sub  $t1, $s2, $s3	#t1 = C - D
	add $t2, $t0, $s3	#t2 = B % C + D
	div $t2, $t2, $s1	#t2 = (B % C + D) / B
	mflo $t2		#t2 = quotient of (B % C + D) / B 
	mul $s0, $t2, $t1 	#a = (B % C + D) / B * (C - D)
	
	li $v0, 4
	la $a0, express		#Prints the expression
	syscall
	la $a0, answer		#Prints result prompt
	li $v0, 4
	syscall 
	la $a0,($s0)		#Output prints on terminal
	li $v0,1		
	syscall
	la $a0, endL
	li $v0, 4
	syscall

	
	li $v0,10		#System call to exit
	syscall		


#data segment#

.data
prompt:	.asciiz "A = (B % C + D) / B * (C - D)"
valueInb: .asciiz "Please enter value for b: "
valueInc: .asciiz "Please enter value for c: "
valueInd: .asciiz "Please enter value for d: "
express: .asciiz "Expression: (B % C + D) / B * (C - D)\n"
answer:	.asciiz "The result for the expression is "
endL:	.asciiz "\n"

##
## end of file part4.asm

