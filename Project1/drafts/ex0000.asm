
# ==== ==== ==== ==== <<<< Data >>>> ==== ==== ==== ====
		.data
		
number1:	.word 3
number2:	.word 5
number3: 	.word 7

#string1:	.asciiz "Hello\n"
#string2:	.asciiz "World!\n"
string3: 	.space 64
newline: 	.asciiz "\n"
result: 	.asciiz "The Result is: "


# ==== ==== ==== ==== <<<< Main >>>> ==== ==== ==== ====
		.text      
		.globl	main 
main:  
	la $a0, string3
	li $a1, 32
	li $v0, 8
	syscall
	
	la $a0, newline
	li $v0, 4
	syscall
	
	la $a0, result
	li $v0, 4
	syscall
	
	la $a0, string3
	li $v0, 4
	syscall
	
# Exit the program.
	li $v0, 10
	syscall
	
	






