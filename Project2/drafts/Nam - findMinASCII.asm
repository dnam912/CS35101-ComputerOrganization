# ==== ==== ==== ==== <<<< Data >>>> ==== ==== ==== ====
		.data
			
myName:		.asciiz  	"This is Nadine Nam presenting findMinASCII.\n"
		.align 2			

prompt:		.asciiz	 	"\nPlease enter n characters (upper/lower case mixed): "
		.align 2
	
printMinASCII:  .asciiz 	"The min ASCII char after reversal is: "
		.align 2		

varStr:		.space 5  	# will hold the user's input string of 20 bytes 
		.align 2

#minASCII:	.space 3	# will hold a minimum char
#		.align 2
		
			
# ==== ==== ==== ==== <<<< Main >>>> ==== ==== ==== ====
		.text 
		.globl	main
	
main:

# PROMPT
	# <Ask User to Enter a String>
	la $a0, prompt
	li $v0, 4
	syscall
	
	
# INPUT
	# < Input String from User >
	la $a0, varStr    			# put the address of the string buffer in $t0
	li $a1, 12	       			# maximum length of string to load, null char always at end & but note, the \n is also included providing total len < 22
        li $v0, 8
        syscall
	
	# < Reverse Cases with the revCase Function >
	la $a0, varStr				# 1st Argument
	li $a1, 10 				# 2nd Argument - string length without null strings (\0\n)
	
	move $t0, $a0				# move the address in $a0 to $t0

	
	jal FIND_MIN


	jal PRINT_findMIn
	
# EXIT
	li $v0, 10
	syscall
	
	
	
	

FIND_MIN: 
	lb $t1, ($t0)

	
	bgt $t0, $a1, exit_loop	# When reached out to max length, exit the loop
	
	addi $t0, $t0, 1	# i++ (increment of array index) - to the next char
	blt $t2, $t1, update
	
	
update:
	move $t2, $t1

	j FIND_MIN
	
exit_loop: 
	sb $t2, minASCII
	
	jr $ra



PRINT_findMin: 

	# <The prompt of Minimal String>
	la $a0, printMinASCII
	li $v0, 4
	syscall
	
	move $a0, $t2
	
	# <Print Out the minimum ASCII code in the reversed string>
	li $v0, 11
	syscall
	
	jr $ra
