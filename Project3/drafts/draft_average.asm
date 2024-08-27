# ==== ==== ==== ==== <<<< Data >>>> ==== ==== ==== ====
		.data
prompt1:	.asciiz			"How many numbers would you like to aoverage? :"
		.align 2
prompt2:	.asciiz	 		"\nPlease enter a 3 digit decimal d.dd: "
		.align 2
printAverage:   .asciiz 		"The average is: "
		.align 2		

inputFloating:	.float 0.0		# will hold the user's input & initialize a floating point
#intNumber	.word 10


# ==== ==== ==== ==== <<<< Main >>>> ==== ==== ==== ====
		.text 
		.globl	main
	
main:

# PROMPT
	#prompt1: read num and store in the $t0
	la $a0, prompt1
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0


# PRINT
	# print the number on the terminal
	move $a0, $t0
	li $v0, 1
	syscall

	
# EXIT
	li $v0, 10
	syscall




# ==== ==== ==== ==== <<<< DRAFT >>>> ==== ==== ==== ====

# SAVE
	#la $v0, userInput
	#l.s $f0, ($v0)
	#cvt.w.s $f1, $f0


# PROMPT 1 - printing
	# < Print the number on the terminal >
	# move $a0, $t0
	# li $v0, 1
	# syscall


# PROMPT 2
	# prompt2: < Ask User to Enter Decimals >
	# la $a0, prompt2
	# li $v0, 4
	# syscall
	
	# < Read - Input Decimal Numbers from User >
	# li $v0, 6		     		# system call 6 for reading a float is required in $v0
	# syscall             			# the user's input is placed in register $f0

	# < Print the number on the terminal >
	# mov.s $f12, $f0
	# li $v0, 2
	# syscall