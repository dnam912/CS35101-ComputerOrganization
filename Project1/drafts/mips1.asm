#Addition of 2 numbers

.data

msg: .asciiz "Result = \n"
.text

li $t0, 2
li $t1, 4

add $s0, $t0, $t1

li $v0, 4
la $a0, msg
syscall

li $v0, 1
move $a0, $s0
syscall

