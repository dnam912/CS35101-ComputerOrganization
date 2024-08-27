# ==== ==== ==== ==== <<<< Data >>>> ==== ==== ==== ====
# add from 1 to 10 by using for-loop
	.data

#printString: 	.asciiz 	"Integer: "
printResult:	.asciiz		"The sum of for-loop is: "


# ==== ==== ==== ==== <<<< Main >>>> ==== ==== ==== ====
	.text
	.globl main
	
main: 
	li $s0, 0		# assign zero in the register s0
	li $t0, 0		# i = 0
	li $t1, 10		# k = 10
	li $t2, 0		# s[i] = 1

Loop: 
	addi $t2, $t2, 1
	add $s0, $s0, $t2

	addi $t0, $t0, 1	# i++
	bne $t0, $t1, Loop

	
# Print a result
	la $a0, printResult
	li $v0, 4
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall

# Exit the program.
	li $v0, 10
	syscall