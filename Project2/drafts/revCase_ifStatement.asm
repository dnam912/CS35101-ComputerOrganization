# ==== ==== ==== ==== <<<< Data >>>> ==== ==== ==== ====
		.data

prompt:	        .asciiz	 	"\nPlease enter n characters (upper/lower case mixed): "
		        .align 2
printRevStr:    .asciiz  	"\nYour string in reverse case is: "
		        .align 2	

varStr:		    .space 4  	# will hold the user's input string of 20 bytes 
		        .align 2


# ==== ==== ==== ==== <<<< Main >>>> ==== ==== ==== ====
		.text 
		.globl	main
	
main:

# PROMPT
	# <Ask User to Enter a String>
	la $a0, prompt
	li $v0, 4
	syscall
	
	
	# <Input String from User>
	la $a0, varStr    	# put the address of the string buffer in $t0
	li $a1, 4	        # maximum length of string to load, null char always at end & but note, the \n is also included providing total len < 22
    li $v0, 8
    syscall
	
	move $t0, $a0		# move the address in $a0 to $t0
	li $t5, 32		# Store 32 bytes for converting to lower or upper
	
	
	jal REV_CASE
	jal PRINT_revCase
	


REV_CASE: 
# ASCII CODE
	# Upper case
	#li $t6, 65	# 'A': 65 (Dec) | 41 (Hex) 
	#li $t7, 90	# 'Z': 90 (Dec) | 5A (Hex) which is after 59
	
	# Lower case
	#li $t8, 97	# 'a': 97 (Dec)  | 61 (Hex)
	#li $t9, 122	# 'z': 122 (Dec) | 7A (Hex) which is after 79
	
	
	# <Load bytes at address $t0>
	lb $t1, ($t0) # 'a'
	
	
	bge $t1, 'A', upperToLower  # 65-90
	bge $t1, 'a', lowerToUpper  # 97-122
	bgez $t1, exit
	
	jr $ra
	
	
upperToLower:
	bgt $t1, 'Z', lowerToUpper # 90 < n
	# blt $t1, 65, exit
	
	add $t1, $t1, $t5	# add 32 bytes from upper to lower
	sb $a0, ($t0)
	addi $t0, $t0, 1	# i++ (increment of array index) - to the next char
	
	j REV_CASE
	
	
lowerToUpper:
	blt $t1, 'a', upperToLower # n  < 97
	# bgt $t1, 122, exit
	
	sub $t1, $t1, $t5	# sub 32 bytes from lower to upper
	sb $a0, ($t0)
	addi $t0, $t0, 1	# i++ (increment of array index)
	
	j REV_CASE


# 248


exit:
	jr $ra

