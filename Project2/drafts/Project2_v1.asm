
		.data    

outStr1:	.asciiz  "\nEnter enter 30 characters (upper/lower case mixed): "  
		.align 2
outStr2:	.asciiz  "\nYour string in reverse case is: "  
		.align 2
outStr3:	.asciiz  "\nThe min ASCII character after reversal is : "  
		.align 2
varStr:		.space 32  # will hold the user's input string thestring of 20 bytes 
		.align 2
		
		.text     
		.globl	main 
main:  

	# <Ask User to Enter a String - Statement 1>
	la $a0, outStr1	 	
	
	li $v0, 4		
	syscall	

	# <Input String from User>
	la $a0, varStr    	# put the address of the string buffer in $t0
	li $a1, 32 	        # maximum length of string to load, null char always at end
				# but note, the \n is also included providing total len < 22
        li $v0, 8
        syscall

	# <Reverse Cases with the revCase Function>
	la $a0, varStr	# 1st Argument
	li $a1, 30 	# 2nd Argument
	jal revCase

 
################################# EXIT ##################################
        li   $v0, 10       # system call for exit
        syscall            # close file



################################# revCase Function ##################################
# <Reverse Case> - 65-90: Upper Cases, 97-122: Lower Cases
# $a0: BaseAddress, $a1: MaxCharacters
revCase:
	# Initial Values
	li $t6, 0		# i = 0
	move $t7, $a1		# How many times should it repeat? $a1 == 30
	move $t0, $a0		# Load Base Address 
Loop1:	
	# Load
	lbu $t1, 0($t0)

	# Convert
	slti $t2, $t1, 91
	li $t5, 64
	slt $t3, $t5, $t1 
	and $t4, $t2, $t3
	bne $t4, 1, LOWER_CASE
	UPPER_CASE:	
		addi $t1, $t1, 32
		j END_IF
	LOWER_CASE:	
		subi $t1, $t1, 32
		j END_IF
	END_IF:

	# Store
	sb $t1, 0($t0)
	
	# Looping
	addi $t0, $t0, 1
	addi $t6, $t6, 1	# i++
	bne $t6, $t7, Loop1	# if ($t0 != $t1) goto Loop
	
	# <Print the Statement 2>
	la $a0, outStr2	 	
	li $v0, 4		
	syscall	
	
	# <Print the Reversed String>
	la $a0, varStr	 	
	li $v0, 4		
	syscall	
	
	# Store Return Address of THIS Function
	move $t9, $ra
	
	# <Print the Minimum ASCII Character>
	la $a0, varStr	# 1st Argument
	li $a1, 30 	# 2nd Argument
	jal findMin
	
	# Restore the Original Return Address and Return
	move $ra, $t9
	jr $ra
		

################################# findMin Function ##################################
findMin:
	# $t8 will store the Min ASCII Code
	li $t8, 122 # 122 is 'z'

	# Initial Values
	li $t6, 0		# i = 0
	move $t7, $a1		# How many times should it repeat? $a1 == 30
	move $t0, $a0		# Load Base Address 
Loop2:	
	# Load
	lbu $t1, 0($t0)
	
	# Find the Min ASCII Character
	slt $t2, $t1, $t8 # if ($t1 < $t8) then $t2 == 1
	beq $t2, $zero, SKIP_NEW_MIN_CHAR
	ENTER_NEW_MIN_CHAR:
	move $t8, $t1
	SKIP_NEW_MIN_CHAR:
	
	# Looping
	addi $t0, $t0, 1
	addi $t6, $t6, 1	# i++
	bne $t6, $t7, Loop2	# if ($t0 != $t1) goto Loop

	# <Print the Statement 3>
	la $a0, outStr3
	li $v0, 4		
	syscall	
	
	# <Print the Result>
	move $a0, $t8
	li $v0, 11
	syscall	
	
	# Return
	jr $ra











