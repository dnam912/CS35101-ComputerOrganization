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

varStr:		.space 32  	# will hold the user's input string
		.align 2
minASCII:	.space 1	# will hold a minimum ASCII char
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
	


# ==== ==== ==== ==== <<<< STATEMENT 1: revCase() >>>> ==== ==== ==== ==== 
# INPUT
	# <Input String from User>
	la $a0, varStr    			# put the address of the string buffer in $t0
	li $a1, 32	       			# maximum length of string to load, including \n & \0 (null char)
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
	


# ==== ==== ==== ==== <<<< STATEMENT 2: findMin() >>>> ==== ==== ==== ==== 
# INPUT
	# <Print the Minimum ASCII Character>
	la $a0, varStr				# 1st Argument
	li $a1, 30				# 2nd Argument - string length without null strings (\0\n)
	
	move $t0, $a0				# move the address in $a0 to $t0
	
	# <Set the Greatest ASCII Value>
	li $t9, 122				# 'z' - 122
	move $t3, $t9				# move cotents of $t9 to $t3
	
	
# RETURN
	jal FIND_MIN


# PRINT
	# <The Prompt of minASCII string>
	la $a0, printMinASCII
	li $v0, 4
	syscall
	
	
	# <Print Out the minimum ASCII code in the reversed string>
	lb $a0, minASCII
	li $v0, 11
	syscall	
	
	
# ==== ==== ==== ==== <<<< EXIT >>>> ==== ==== ==== ====
# EXIT
	li $v0, 10
	syscall
	
	
	
	
	
	
################################# STATEMENT 1: revCase() ##################################
REV_CASE: 
	##### ASCII CODE #####
	# Upper case
	# 'A' - 65 (Dec) | 41 (Hex) 
	# 'Z' - 90 (Dec) | 5A (Hex) which is after 59
	
	# Lower case
	# 'a' - 97 (Dec)  | 61 (Hex)
	# 'z' - 122 (Dec) | 7A (Hex) which is after 79
	
	
	
	lb $t1, ($t0)				# Load bytes at address $t0

	bge $t1, 'A', upperToLower		# if ($t1 >= 65) { upperToLower }
	bge $t1, 'a', lowerToUpper		# if ($t1 >= 97) { lowerToUpper }
	bgez $t1, exit				# if ($t1 == 0)  { exit }
	
	jr $ra					# return the value of REV_CASE
	
	
	
	upperToLower: # 65-90
		bgt $t1, 'Z', lowerToUpper	# if ($t1 > 'Z') { lowerToUpper }
		
		add $t1, $t1, 32		# add 32 bytes from upper to lower
		sb $t1, ($t0)			# store bytes in $t1 to $t0
		addi $t0, $t0, 1		# i++ (increment of array index), moving to the next char index
	
		j REV_CASE			# Looping: return to 'load bytes'
	
	
	lowerToUpper: # 97-122
		sub $t1, $t1, 32		# sub 32 bytes from lower to upper
		sb $t1, ($t0)			# store bytes in $t1 to $t0
		addi $t0, $t0, 1		# i++ (increment of array index)
	
		j REV_CASE			# Looping: return to 'load bytes'

	exit:
		jr $ra				# return the value of REV_CASE



################################# STATEMENT 2: findMin() ##################################
FIND_MIN:
	lb $t2, ($t0)				# Load bytes at address $t0
	
	blt $t2, $t3, update_minASCII		# if ($t2 < $t3) { lowerToUpper } -> $t3 = 122
	bge $t2, $t3, loop_index		# if ($t2 >= $t3) { loop_index }
	
	
	
	loop_index:
		sb $t2, ($t0)			# store bytes in $t1 to $t0
		addi $t0, $t0, 1		# i++ (increment of array index), moving to the next char index
		
		j FIND_MIN			# Looping: return to 'load bytes'
	
	
	update_minASCII:
		blt $t2, 'A', exit2		# if $t2 is less than 65, then exits this FIND_MIN function
		
		move $t3, $t2			# if $t2 is greater than 65, then save the min ASCII in $t3
		
		j loop_index			# return to looping

	
	exit2:
		sb $t3, minASCII		# save the FINAL minimum ASCII bytes
		jr $ra				# return the value of FIND_MIN

