# Starter code for reversing the case of a 30 character input.
# Put in comments your name and date please.  You will be
# revising this code.
#
# Created by Dianne Foreback 
# Students should modify this code
# 
# This code displays the authors name (you must change
# outpAuth to display YourFirstName and YourLastName".
#
# The code then prompts the user for input
# stores the user input into memory "varStr"
# then displays the users input that is stored in"varStr" 
#
# You will need to write code per the specs for 
# procedures main, revCase and function findMin.
#
# revCase will to reverse the case of the characters
# in varStr.  You must use a loop to do this.  Another buffer
# varStrRev is created to hold the reversed case string.
# 
# Please refer to the specs for this project, this is just starter code.
#
# In MARS, make certain in "Settings" to check
# "popup dialog for input syscalls 5,6,7,8,12"
#
            .data      # data segment
	    .align 2   # align the next string on a word boundary
outpAuth:   .asciiz  "This is YourFirstName YourLastName presenting revCaseMin.\n"
outpPrompt: .asciiz  "Please enter 30 characters (upper/lower case mixed):\n"
	    .align 2   #align next prompt on a word boundary 
outpStr:    .asciiz  "You entered the string: "
            .align 2   # align users input on a word boundary
varStr:     .space 32  # will hold the user's input string thestring of 20 bytes 
                       # last two chars are \n\0  (a new line and null char)
                       # If user enters 31 characters then clicks "enter" or hits the
                       # enter key, the \n will not be inserted into the 21st element
                       # (the actual users character is placed in 31st element).  the 
                       # 32nd element will hold the \0 character.
                       # .byte 32 will also work instead of .space 32
            .align 2   # align next prompt on word boundary
outpStrRev: .asciiz   "Your string in reverse case is: "
            .align 2   # align the output on word boundary
varStrRev:  .space 32  # reserve 32 characters for the reverse case string
	    .align 2   # align  on a word boundary
outpStrMin: .asciiz    "The min ASCII character after reversal is: "
#
            .text      # code section begins
            .globl	main 
main:  
#
# system call to display the author of this code
#
	 la $a0,outpAuth	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	

#
# system call to prompt user for input
#
	 la $a0,outpPrompt	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	
#
# system call to store user input into string thestring
#
	li $v0,8		# system call 8 for read string needs its call number 8 in $v0
        			# get return values
	la $a0,varStr    	# put the address of thestring buffer in $t0
	li $a1,32 	        # maximum length of string to load, null char always at end
				# but note, the \n is also included providing total len < 22
        syscall
        #move $t0,$v0		# save string to address in $t0; i.e. into "thestring"
#
# system call to display "You entered the string: "
#
	 la $a0,outpStr 	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall  	
#
# system call to display user input that is saved in "varStr" buffer
#
	 la $a0,varStr  	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	
#
# Your code to invoke revCase goes next	 
#



# Exit gracefully from main()
         li   $v0, 10       # system call for exit
         syscall            # close file
         
         
################################################################
# revCase() procedure can go next
################################################################
#  Write code to reverse the case of the string.  The base address of the
# string should be in $a0 and placed there by main().  main() should also place into
# $a1 the number of characters in the string.
#  You will want to have a label that main() will use in its jal 
# instruction to invoke revCase, perhaps revCase:
#
revCase:




#
# After reversing the string, you may print it with the following code.
# This is the system call to display "Your string in reverse case is: "
	 la $a0,outpStrRev 	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall  	
# system call to display the user input that is in reverse case saved in the varRevStr buffer
	 la $a0,varStrRev  	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	

#
# Your code to invoke findMin() can go next

# Your code to return to the caller main() can go next



################################################################
# findMin() function can go next
################################################################
#  Write code to find the minimum character in the string.  The base address of the
# string should be in $a0 and placed there by revCase.  revCase() should also place into
# $a1 the number of characters in the string.
#  You will want to have a label that revCase() will use in its jal 
# instruction to invoke revCase, perhaps findMin:
#
# 
findMin:
# write use a loop and find the minimum character


#
# system call to display "The min ASCII character after reversal is:  "
	 la $a0,outpStrMin 	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall  	

# write code for the system call to print the the minimum character


# write code to return to the caller revCase() can go next