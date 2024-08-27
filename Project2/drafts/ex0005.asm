
		.data    

outStr:		.asciiz  "Enter Something:"  
		.align 2
varStr:		.space 7  # will hold the user's input string thestring of 20 bytes 
		.align 2
		
hello1:		.asciiz "Hello1"
		.align 2
		
hello2:		.asciiz "Hello2"
		.align 2
		
		
		
		.text     
		.globl	main 
main:  

# <Ask User to Enter a String>
	la $a0,outStr	 	
	
	li $v0,4		
	syscall	

# <Input String from User>
	la $a0,varStr    	# put the address of the string buffer in $t0
	li $a1,7 	        # maximum length of string to load, null char always at end
				# but note, the \n is also included providing total len < 22
        li $v0,8
        syscall


 
################################# EXIT ##################################
        li   $v0, 10       # system call for exit
        syscall            # close file






