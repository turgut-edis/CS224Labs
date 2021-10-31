## Part 3
## Displays the address and value of array elements
## Calculates Average, Max and Min Values

#text segment#

.text		 
start:
	la $s0, array	#Load the array to s0
	la $s1, arrsize	#Load array size to s1
	lw $t0, 0($s1)	#t0 = array size
	addi $t1, $0, 0 #t1 = i
	add $s2, $0, $t0 #s2 = max
	add $s3, $0, $t0 #s3 = min
	addi $s4, $0, 0 #s4 = total
	addi $s5, $0, 0 #s5 = avg
	
	#Display messages in console
	la $a0,disp1	
	li $v0,4	
	syscall	
	la $a0,disp2	
	li $v0,4	
	syscall	
	la $a0,disp3	
	li $v0,4	
	syscall
	la $a0,endLine	
	li $v0,4	
	syscall		
	
	Loop:
		beq $t0, $0, doneZero	# if size = 0, finish the loop with no calculations
		beq $t0, $t1, done	# i < size
		sll $t2, $t1, 2		
		add $t2, $t2, $s0	#t2 = address of array[i]
		
		li $v0, 34
		add $a0, $zero, $t2	#Print address in hex form
		syscall
		
		li $v0, 4
		la $a0, tabLine		#Put tab between address and value
		syscall
		
		lw $t2, 0($t2)		#t2 = array[i]
		
		li $v0, 1
		la $a0, ($t2)		#Print the value of array[i]
		syscall
		
		li $v0, 4
		la $a0, endLine		#Go to next line
		syscall 
		
		add $s4, $s4, $t2	#total = total + array[i]
		add $t1, $t1, 1		#i = i + 1
		
		sge $t4, $t2, $s2	#if array[i] > max
		bne $t4, $0, calcMax	#max = array[i]
		
		sle $t3, $t2, $s3	#if array[i] < min
		bne $t3, $0, calcMin	#min = array[i]
		
		j Loop			#Jump to beginning of loop
	calcMin:	#Sets new minimum element
		move $s3, $t2
		j Loop
		
	calcMax:	#Sets new maximum element
		move $s2, $t2
		j Loop
		
	doneZero:
		li $v0, 4
		la $a0, zero
		syscall
		
		li $v0, 10
		syscall
		
	done:		
		div $s5, $s4, $t0	#Calculate the average value
		
		li $v0, 4
		la $a0, avgS
		syscall
		li $v0, 1
		la $a0, ($s5)		#Prints average value
		syscall
		
		li $v0, 4
		la $a0, endLine
		syscall
		
		li $v0, 4
		la $a0, maxS
		syscall
		li $v0, 1
		la $a0, ($s2)		#Prints maximum value in array
		syscall
		
		li $v0, 4
		la $a0, endLine
		syscall
		
		li $v0, 4
		la $a0, minS		
		syscall
		li $v0, 1
		la $a0, ($s3)		#Prints minimum value in array
		syscall
		
		li $v0, 4
		la $a0, endLine
		syscall
		
		li $v0,10  		# system call to exit
		syscall


#data segment#

.data
disp1:	.asciiz "Memory Address\tArray Element\n"
disp2:	.asciiz "Position(hex)\tValue(int)\n"
disp3:	.asciiz "=============\t========"
array:	.word	1,200,-3,72,13,700,29,3,2,-22,12,-12
arrsize: .word 12
endLine: .asciiz "\n"
tabLine: .asciiz "\t"
avgS:	.asciiz "Average: "
maxS:	.asciiz "Max: "
minS:	.asciiz "Min: "
zero: .asciiz "There is no element in the array\n"

##
## end of file part3.asm
