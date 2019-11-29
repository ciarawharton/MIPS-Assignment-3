//  project3.s
//  Created by Ciara Wharton on 11/28/19.
.data
data: .space 1001 // limiting the amount of characters
    output: .asciiz "\n"
    notvalid: .asciiz "NaN"
    comma: .asciiz ","
.text
main:
main:
// takes in user input
    li $v0,8
    la $a0,data // loading data
    li $a1, 1001 // limiting the amount of characters
    syscall // system call
    jal subprogramOne // jumping to the first subprogram
subprogramOne:
sub $sp, $sp,4
sw $a0, 0($sp)
lw $t0, 0($sp) // loading input and storing it into register $t0
addi $sp,$sp,4
move $t6, $t0 // taking input and storing into register $t6
