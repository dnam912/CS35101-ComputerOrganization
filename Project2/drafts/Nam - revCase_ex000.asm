# ==== ==== ==== ==== <<<< Data >>>> ==== ==== ==== ====
			.data
			
number:     		.word -1   	# -1 placed in memory

myName:			.asciiz  	"This is Nadine Nam presenting revCaseMin.\n"
			.align 2
prompt:			.asciiz	 	"Please enter 10 characters (upper/lower case mixed):\n"
			.align 2   	# align the next string on a word boundary
		
strArray:     		.space 12	# 10 characters + \n + \0
			.align 2
strArray_reversed: 	.space 12   	# reserve four bytes for the reversed string
			.align 2

printResult:    	.asciiz  	"Your string in reverse case is: "
			.align 2
printASCII:     	.asciiz 	"The min ASCII char after reversal is: "
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
	#prompt1: read a prompt and store in the $t0
	la $a0, prompt
	li $v0, 4
	syscall


# load byte example shows difference between lbu and lb
        la 	$t0, number		# put the adress of number buffer in $t0
        lbu 	$t1, 0($t0)             # first byte of number in the register $t0, zero extended 
        # lb 	$t2, 0($t0)             # first byte of number placed in register $t2 is sign extended
        

	

revCase: 
	# STORE USER INPUT
	li $v0, 8			# system call 8 for read string needs its call number 8 in $v0  &  get return values
	la $a0, strArray    		# put the address of thestring buffer in $t0
	li $a1, 12 	        	# maximum length of string to load, null char always at end
					# but note, the \n is also included providing total len < 32
        syscall
        move $t0, $v0			
        
        
revCase_Loop: 
	# REVERSE THE INPUT
	la $t0, strArray    		# t0 gets address of strArray
        la $t2, strArray_reversed 	# t1 gets address of strArray_reversed
	
	lbu	$t1, 0($t0)        	# t1 gets first byte stored at thestring
        sb	$t1, 9($t2)        	# store first byte in last byte
	
	lbu	$t1, 1($t0)
	sb	$t1, 8($t2)
	
	lbu	$t1, 2($t0)
	sb	$t1, 7($t2)
	
	lbu	$t1, 3($t0)
	sb	$t1, 6($t2)
	
	lbu	$t1, 4($t0)
	sb	$t1, 5($t2)
	
	lbu	$t1, 5($t0)
	sb	$t1, 4($t2)
	
	lbu	$t1, 6($t0)
	sb	$t1, 3($t2)
	
	sb	$t1, 7($t2)
	lbu	$t1, 2($t0)
	
	sb	$t1, 8($t2)
	lbu	$t1, 1($t0)
	
	sb	$t1, 9($t2)
	lbu	$t1, 0($t0)


	# "Your string reversed is: "
	la $a0, printResult 	
	li $v0, 4
	syscall  
	 
	# DISPLAY REVERSED INPUT in the buffer strArray_reversed
	la $a0, strArray_reversed	
	li $v0,4
	syscall	



findMin:


# "The min ASCII char after reversal is: "
	la $a0, printASCII
	li $v0, 4
	syscall
	
	
findMin_Loop: 

	
	move $t0, $a0
	lb $t1, varStr($t0)		# Load bytes at address $t1
	
	li $t5, 32	# 32 bytes
	subu $t1, $a1, $t5
	sb $t1, varStr($t0)
	
	move $a0, $t1
	li $v0, 4
	syscall
	


# Exit the program.
	li $v0, 10
	syscall
	
