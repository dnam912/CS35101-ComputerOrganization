# ==== ==== ==== ==== <<<< Data >>>> ==== ==== ==== ====
	.data

myName:		.asciiz  "This is Nadine Nam presenting threeTimes.\n"
prompt1:	.asciiz	 "Please Enter a number1: "
prompt2:	.asciiz	 "Please Enter a number2: "
prompt3:	.asciiz	 "Please Enter a number3: "
printResult:    .asciiz  "The sum of your numbers (multiplied by 3) is: "


# ==== ==== ==== ==== <<<< Main >>>> ==== ==== ==== ====
	.text 
	.globl	main
	
main:
# "This is Nadine Nam presenting threeTimes.\n"
	la $a0, myName
	li $v0, 4
	syscall
	
	
# PROMPT
	#prompt1: read int1 and store in the $t0
	la $a0, prompt1
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	
	#prompt2: read int2 and store in the $t1
	la $a0, prompt2
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0
	
	
	#prompt3: read int3 and store in the $t2
	la $a0, prompt3
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t2, $v0



# CALCULATION
	# Add integers
	add $s0, $t0, $t1
	add $s1, $s0, $t2
	

	# Multiply by 3 -- ver1 in opcode mul
	#mul $s3, $s1, 3
	
	# Multiply by 3 -- ver2 in just adding three times
	#add $s3, $s1, $s1
	#add $s3, $s3, $s1


# LOOP-STATEMENT
	# Multiply by 3 -- ver3 in using a loop-statement
	li $t3, 0		# i = 0
	li $t4, 3		# k = 3
	li $s4, 0		# assign zero in the register s4
	
Loop: 
	add $s4, $s4, $s1
	
	addi $t3, $t3, 1	#i++
	bne $t3, $t4, Loop
	


# Print a result
	la $a0, printResult
	li $v0, 4
	syscall
	
	li $v0, 1
	move $a0, $s4
	syscall
	
	
# Exit the program.
	li $v0, 10
	syscall
	
	
