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
checkString:
    bgt $t2,0,invalidCharacter // checking for spaces or tabs
    beq $s0, 9,  skipping // if tab, move to gap function
    beq $s0, 32, skipping // if space, move to gap function
    ble $s0, 47, invalidCharacter // less than 48 = invalid
    ble $s0, 57, vaildCharacter // integers = valid
    ble $s0, 64, invalidCharacter // less than 64 = invalid
    ble $s0, 84, vaildCharacter // starting with A (capital) = valid
    beq $s0, 96, invalidCharacter // less than 96 = invalid
    ble $s0, 117, vaildCharacter // less than 117 (u) = valid
    beq $s0, 118, invalidCharacter // greater than 117 = valid
skipping:
    addi $t2,$t2,-1
    j moving // jumping to loop function
vaildCharacter:
    addi $t3, $t3,1
    mul $t2,$t2,$t7
    j moving // jumping to loop function
invalidCharacter:
    lb $s0, ($t0) // loading bits
    beq $s0, 0, withinString
    beq $s0, 10, withinString
    addi $t0,$t0,1
    beq $s0, 44, withinString
    j invalidCharacter // jumping to function
withinString:
    addi $t1,$t1,1
    sub $sp, $sp,4
    sw $t7, 0($sp)
    move $t6,$t0
    lb $s0, ($t0)
    beq $s0, 0, forward
    beq $s0, 10, forward
    beq $s0,44, invalidCharacter
    li $t3,0
    li $t2,0
    j moving
subCharacter:
    bgt $t2,0,withinString
    bge $t3,5,withinString
    addi $t1,$t1,1
    sub $sp, $sp,4
    sw $t6, 0($sp)
    move $t6,$t0
    lw $t4,0($sp)
    li $s1,0
    jal subprogram2
    lb $s0, ($t0)
    beq $s0, 0, forward
    beq $s0, 10, forward
    beq $s0,44, invalidCharacter
    li $t2,0
    j moving
subprogram2:
    beq $t3,0,finish
    addi $t3,$t3,-1
    lb $s0, ($t4)
    addi $t4,$t4,1
    j subprogram3
moveForward:
    sw $s1,0($sp)
    j subprogram2
subprogram3:
    move $t8, $t3
    li $t9, 1
    ble $s0, 57, number
    ble $s0, 84, uppercase
    ble $s0, 116, lowercase
