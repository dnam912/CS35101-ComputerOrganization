# ==== ==== ==== ==== <<<< DATA >>>> ==== ==== ==== ====
		.data
myName: 	.asciiz				"This is Nadine Nam presenting average.asm.\n"
		.align 2
		
prompt1:	.asciiz				"How many numbers would you like to average?: "
		.align 2
prompt2:	.asciiz	 			"Please enter a 3 digit decimal d.dd: "
		.align 2

printFloat:	.asciiz				"\nInteger to Floating point: "
printSum:	.asciiz				"\nSum: "
printAverage:   .asciiz 			"\n\nThe Average is: "		

inputFloating:	.float 0.0			# will hold the user's input & initialize a floating point

			
# ==== ==== ==== ==== <<<< MAIN >>>> ==== ==== ==== ====
		.text 
		.globl	main
main:

##### VARIABLES #####
	# t0 = n
	li $t1, 0				# counter i++
	# t2 = bool
	# f0 = input decimals
	# f1 = storing decimals
	# f2 = sum
	# f3 & f4 = int to floating point
	# f12 = print floating point
#####################
	
	
# "This is Nadine Nam presenting average.asm.\n"
	la $a0, myName
	li $v0, 4
	syscall


# PROMPT 1
	# < The Prompt of Asking User to Enter Integer >
	la $a0, prompt1
	li $v0, 4
	syscall
	
	# < Read - Input Integer Number >
	li $v0, 5				# read int
	syscall					# assign int
	move $t0, $v0				# move int number (n) in $v0 to $t0



LOOP:
	# < Compare - counter and int number >
	slt $t2, $t1, $t0			# if ( $t1( i ) < $t0( n ) ) { $t2 = 1 }  else { $t2 = 0 }
						# if t1 is less than t0,then set t2 to 1, else set t2 to 0
	beq $t2, $zero, RETURN			# if i == n { t2 == 0 }, then go to the RETURN procedure 
	
# PROMPT 2
	# < The Prompt of Asking User to Enter Decimals >
	la $a0, prompt2
	li $v0, 4
	syscall

	# < Read - Input Decimal Numbers from User >
	li $v0, 6		     		# system call 6 for reading a float is required in $v0
	syscall					# the user's input is placed in register $f0
	
	mov.s $f1, $f0				# move input decimal numbers in $f0 to $f1
	
	add.s $f2, $f2, $f1			# sum += decimal numbers
	addi $t1, $t1, 1			# i++


	j LOOP



RETURN:
	# < Print the sum of decimal values on the terminal >
	la $a0, printSum
	li $v0, 4
	syscall 

	mov.s $f12, $f2
	li $v0, 2
	syscall


# CONVERSION
	# < Print Int to Float >
	la $a0, printFloat
	li $v0, 4
	syscall
	
	# < CONVERT int to floating point >
	mtc1 $t0, $f3				# move int stored in $t0 to floating point register $f3
	cvt.s.w $f4, $f3			# convert (from word to single precision) $f3 to $f4
						# cvt.s.w $f12, $f12 is also acceptable
	
	# < Print the number as floating point on the terminal >
	mov.s $f12, $f4
	li $v0, 2
	syscall


# AVERAGE
	# < Print the Average >
	la $a0, printAverage
	li $v0, 4
	syscall
	
	# < Divide the sum of decimal values by numbers >
	div.s $f12, $f2, $f4			# Divide $f2 by $f4 and Set $f12
	li $v0, 2				# read floating point
	syscall



# ==== ==== ==== ==== <<<< EXIT >>>> ==== ==== ==== ====
# EXIT
	li $v0, 10
	syscall

