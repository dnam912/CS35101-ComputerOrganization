# Starter code for threeTimes.asm
# Put in comments your name and date please.  You will be
# revising this code.
#
# Dianne Foreback 
# 
# 
# This code displays the authors name (you must change
# outpAuth to display YourFirstName and YourLastName".
#
# The code then prompts the user for 3 integer values.
# The code outputs the summation of these 3 values multiplied by 3.
#
# In MARS, make certain in "Settings" to check
# "popup dialog for input syscalls 5,6,7,8,12"
#
            .data      # data segment
	    .align 2   # align the next string on a word boundary
name:   .asciiz  "This is Nadine Nam presenting threeTimes.\n"
printString: .asciiz  "Integer: "
	    .align 2   #align next prompt on a word boundary
printSum:    .asciiz  "The sum of your numbers (multiplied by 3) is: "
            .align 2   # align users input on a word boundary
#
# main begins
            .text      # code section begins
            .globl	main 
main:  
###############################################################
# system call to display the author of this code
	la $a0, name		# system call 4 for print string needs address of string in $a0
	 			# Print a message introducing my name. 
	 
	 			
	li $t0, 5
	li $t1, -3
	add $s0, $t0, $t1
	
	
	la $a0, printString
	li $v0, 4
	syscall
	
	
	la $a0, printSum
	li $v0, 4
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall




#
# Exit gracefully
         li   $v0, 10       # system call for exit
         syscall            # close file
###############################################################
# "Please Enter a number: "
	la $a0, prompt
	li $v0, 4
	syscall
	
	# Read the int
	li $v0, 5
	syscall
	move $s0, $v0
	
	# "Print the Integer: "
	la $a1, printString
	li $v0, 4
	syscall
	
	# Print the num
	li $v0, 1
	move $a0, $s0
	syscall
	
	
	# "Print the Integer: "
	la $a0, printString
	li $v0, 4
	syscall
	li $v0, 1
	lw $a0, integer1
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	
	# "Print the Integer: "
	la $a0, printString
	li $v0, 4
	syscall
	li $v0, 1
	lw $a0, integer2
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	
	# "Print the Integer: "
	la $a0, printString
	li $v0, 4
	syscall
	li $v0, 1
	lw $a0, integer3
	syscall
	la $a0, newline
	li $v0, 4
	syscall
