
            .data      # data segment

varStr:     .space 32  # will hold the user's input string thestring of 20 bytes 

outpStr1:    .asciiz  "PRINT 1"
            #.align 2  
outpStr2:    .asciiz  "PRINT 2"
            #.align 2  
outpStr3:    .asciiz  "PRINT 3"
            #.align 2  


            .text      # code section begins
            .globl	main 
main:  

	 la $a0,outpStr1 	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	

	jal print2
	jal print3
 
########### EXIT ###########
         li   $v0, 10       # system call for exit
         syscall            # close file

print2:

	 la $a0,outpStr2 	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	
	 
	 jr $ra

print3:

	 la $a0,outpStr3 	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	
	 
	 jr $ra







