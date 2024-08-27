# ==== ==== ==== ==== <<<< Data >>>> ==== ==== ==== ====
		.data
			
myName:		.asciiz  	"This is Nadine Nam presenting revCaseMin.\n"
		.align 2			

prompt:		.asciiz	 	"\nPlease enter n characters (upper/lower case mixed): "
		.align 2
printRevStr:    .asciiz  	"\nYour string in reverse case is: "
		.align 2	
printMinASCII:  .asciiz 	"\nThe min ASCII char after reversal is: "
		.align 2		

varStr:		.space 32  	# will hold the user's input string of 20 bytes 
		.align 2
minASCII:	.space 1	# will hold a minimum char
		.align 2
		
			
# ==== ==== ==== ==== <<<< Main >>>> ==== ==== ==== ====
		.text 
		.globl	main
	
main:

# "This is Nadine Nam presenting revCaseMin.\n"
	la $a0, myName
	li $v0, 4
	syscall  


# PROMPT
	# <Ask User to Enter a String>
	la $a0, prompt
	li $v0, 4
	syscall
	
	
# INPUT
	# <Input String from User>
	la $a0, varStr    			# put the address of the string buffer in $t0
	li $a1, 30	       			# maximum length of string to load, null char always at end & but note, the \n is also included providing total len < 22
        li $v0, 8
        syscall
	
	# <Reverse Cases with the revCase Function>
	la $a0, varStr				# 1st Argument
	li $a1, 30 				# 2nd Argument - string length without null strings (\0\n)
	
	move $t0, $a0				# move the address in $a0 to $t0


# RETURN
	jal REV_CASE


# PRINT
	# <The prompt of Reversed String>
	la $a0, printRevStr
	li $v0, 4
	syscall
	
	# <Print Out the Reversed String>
	la $a0, varStr
	li $v0, 4
	syscall
	
	
# =============
	# <Print the Minimum ASCII Character>
	la $a0, varStr				# 1st Argument
	li $a1, 30 				# 2nd Argument
	
	move $t0, $a0				# move the address in $a0 to $t0
	
	
	# <For-Loop Statement>
	move $t7, $a1				# Counter Increment
	li $t8, 0				# i = 0
	
	
	li $t9, 122				# 'z' - 122
	move $t3, $t9				# move cotents of $t9 to $t3
	
	
	jal FIND_MIN


# PRINT
	# <The Prompt of minASCII string>
	la $a0, printMinASCII
	li $v0, 4
	syscall
	
	# <Print Out the minimum ASCII code in the reversed string>
	#move $a0, $t3
	lb $a0, minASCII
	li $v0, 11
	syscall	
	
	
################################# EXIT ##################################
# EXIT
	li $v0, 10
	syscall
	
	

################################# STATEMENT 1: revCase() ##################################
REV_CASE: 
# ASCII CODE
	# Upper case
	# 'A' - 65 (Dec) | 41 (Hex) 
	# 'Z' - 90 (Dec) | 5A (Hex) which is after 59
	
	# Lower case
	# 'a' - 97 (Dec)  | 61 (Hex)
	# 'z' - 122 (Dec) | 7A (Hex) which is after 79
	
	
	# <Load bytes at address $t0>
	lb $t1, ($t0)
	
	bge $t1, 'A', upperToLower		# if ($t1 >= 65) { upperToLower }
	bge $t1, 'a', lowerToUpper		# if ($t1 >= 97) { lowerToUpper }
	bgez $t1, exit
	
	
	jr $ra					# return the value from REV_CASE
	
	
	upperToLower: # 65-90
		bgt $t1, 'Z', lowerToUpper	# if ($t1 > 'Z') { lowerToUpper }
	
		add $t1, $t1, 32		# add 32 bytes from upper to lower
		sb $t1, ($t0)			# store bytes in $t1 to $t0
		addi $t0, $t0, 1		# i++ (increment of array index) - to the next char
	
		j REV_CASE
	
	
	lowerToUpper: # 97-122
		sub $t1, $t1, 32		# sub 32 bytes from lower to upper
		sb $t1, ($t0)			# store bytes in $t1 to $t0
		addi $t0, $t0, 1		# i++ (increment of array index)
	
		j REV_CASE

	exit:
		jr $ra



################################# STATEMENT 2: findMin() ##################################
FIND_MIN:
	# <Load bytes at address $t0>
	lb $t2, ($t0)
	
	
	blt $t2, $t3, update_minASCII		# if ($t2 < $t3) { lowerToUpper }
	bge $t2, $t3, loop_index
	
	beq $t2, $zero, exit2
	
	jr $ra
	
	
	loop_index:
		sb $t2, ($t0)			# store bytes in $t1 to $t0
		addi $t0, $t0, 1		# move to the next char
		# addi $t8, $t8, 1		# i++ (increment of array index)
		
		#bne $t6, $t7, FIND_MIN	# if ($t0 != $t1) goto Loop
		j FIND_MIN
	
		
	update_minASCII:
		move $t3, $t2
		
		j loop_index


	exit2:
		sb $t2, minASCII
		
		jr $ra
