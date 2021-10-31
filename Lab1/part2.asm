## isSymmetric.asm - Prints the elements of the array and prints whether it is symmetric ot not.

#		text segment		#

	.text		
	.globl __start 

__start:		# execution starts here
	la $s0, array	#s0 holds the array
	la $t2, arrsize #t2 hold the arraysize
	#t0 holds the value for number of elements in array
	sll $t0, $0, 2
	add $t0, $t0, $t2
	lw $t0, 0($t0) 
	addi $s1, $0, 0	#s1 is i using in for loop of printLoop
	addi $s2, $0, 0 #s2 is j using in begin to end search of array
	add $s3, $t0, -1  #s3 is k using in end to begin search of array
	
	printLoop:	# loop for print the array elements
		beq $s1, $t0, beginToEnd #If all elements are printed, jump to next loop
		sll $t1, $s1, 2 	 #Creates byte offset to access the elements of array
		add $t1, $t1, $s0	 #Address of array[i]
		lw $t1, 0($t1)		 # t1 = array[i]
		#Print the array[i]
		la $a0, ($t1)
		li $v0, 1
		syscall
		#Print the space between elements
		la $a0, str
		li $v0,4
		syscall
		addi $s1, $s1, 1	# i = i + 1
		j printLoop		# Jump to the beginning of the array
		
	
	beginToEnd:	# Loop for linear search in array
		beq $s2, $t0, done	#If all elements are investigated and no problem, go to the end
		sll $t3, $s2, 2		#Byte offset to access the elements
		add $t3, $t3, $s0	#Address of array[j]
		lw $t3, 0($t3)		# t3 = array[j]
		endToBegin:	# Loop for reverse linear search in array
			beq $s3, $s2, done 	#If begin search index equals to reverse search index, they are symmetric
			sll $t4, $s3, 2		#Byte offset to access reversal array
			add $t4, $t4, $s0	#Address of array[k]
			lw $t4, 0($t4)		# t4 = array[k]
			bne $t3, $t4, printNotSym # If end and begin index is not equal, end all loops, print it is not symmetric and exit
			addi $s2, $s2, 1	# j = j + 1
			addi $s3, $s3, -1	# k = k + 1
			j beginToEnd		# jump to the beginning of begin to end search
	done:	
		#System call to print the array is symmetric
		la $a0, isSym
		li $v0, 4
		syscall
		li $v0, 10  # system call to exit
		syscall
	
	printNotSym:
		#System call to print the array is not symmetric
		la $a0, isNotSym
		li $v0, 4
		syscall
		li $v0, 10  # system call to exit
		syscall

#     	 data segment		#

	.data
str:	.asciiz " "
isNotSym:	.asciiz "\nArray is not symmetric"
isSym:	.asciiz "\nArray is symmetric"
array:	.word	2, 5, 4
arrsize: .word 3

##
## end of file isSymmetric.asm

