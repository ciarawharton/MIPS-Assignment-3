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
forward: // creating the moving forward function
    j display // moving/jumping to the display function

subprogramOne:
sub $sp, $sp,4
sw $a0, 0($sp)
lw $t0, 0($sp) // loading input and storing it into register $t0
addi $sp,$sp,4
move $t6, $t0 // taking input and storing into register $t6

beginning: // beginning function
li $t2,0
li $t7, -1 // invalid input
lb $s0, ($t0)
beq $s0, 9, skipCharacter // if the bit is a tab, it skips
beq $s0, 32, skipCharacter // if the bit is a space, it skips
move $t6, $t0 // storing characters
j moving // moving to the looping function
skipCharacter: // skipping characters
    addi $t0,$t0,1
    j beginning // jumping to the beginning function
moving: // beginning of the loop
    lb $s0, ($t0) // loading bits
    beq $s0, 0, subCharacter // undefined bits
    beq $s0, 10, subCharacter
    addi $t0,$t0,1
    beq $s0, 44, subCharacter // commas
