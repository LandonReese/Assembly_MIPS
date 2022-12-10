#Landon Reese RecursiveMultiply

#Implement your recursive function as a MIPS32 subroutine conforming to this:

#Inputs:  $a0 : multiplicand, $a1 : multiplier      Outputs:  $v0 : product

#You may assume that both inputs are positive, greater than zero, and that the final 
#product will fit within a 32-bit value
#Be sure to save & restore the necessary registers to/from the stack appropriately.
	
	.data
prompt1:.asciiz "Enter the multiplicand: "
prompt2:.asciiz "Enter the multiplier: "
prompt3:.asciiz " * "
prompt4:.asciiz " = "

	.align 4
number: .space 32 #multiplicand - 32 bytes = 1 word
	.align 4
multi:  .space 32 #multiplier   - 32 bytes = 1 word
	

	.text
	#a0 contains multiplicand
	#a1 contains multiplier
	#a2 contains the product before it is sent to v0
	#a3 contains 1, a necessary number for the base case
	#v0 contains the product

main:  	
	li $sp, 2147483640

	li $v0, 4		#print prompt 4 prints a null-terminated string
  	la $a0, prompt1
  	syscall

  	li $v0, 5		#read integer
  	la $a0, number
  	syscall			#enter multiplicand
  	sw $v0 number		#stores integer into number
  	
  	li $v0, 4		#print prompt
  	la $a0, prompt2
  	syscall

  	li $v0, 5		#read integer = 5
  	la $a1, multi
  	syscall			#enter multiplier
  	sw $v0, multi		#stores integer into multi
  	
  	li $a3, 1 		#stores a 1 into register a3
  	
  	li $v0, 1		#print prompt to print multiplicand
  	lw $a0, number		#CHANGED TO LB INSTEAD
  	syscall
  	
  	li $v0, 4		#print prompt for the " * "
  	la $a0, prompt3
  	syscall
  	
  	li $v0, 1		#print prompt for the multiplier
  	lw $a0, multi
  	syscall
  	
  	li $v0, 4		#print prompt for the " = "
  	la $a0, prompt4
  	syscall
  	
  	#Before jal make sure to store number into $a0 and multi into $a1
  	lw $a0, number		#$a0 = will always += $a0 if $a1 > 1
  	lw $a1, multi		#$a1 = how many times to be multiplied
  	lw $a2, number		#$a2 = number
  	
  	jal recurse		#does the recursive multiply function, at the end will return to done:
  	
done:	li $v0, 10		#10 terminates the function
	syscall
  	
recurse:			#recursive case
	addi $sp, $sp, -8	#sets up two bytes in my stack to utilize
	sw $ra, 4($sp)		#stores 4 byte return address for MAIN into stack
	sw $a0, 0($sp)		#stores $a0 into the stack
	
	#Next store $a0 + $a0 into $a2 if $a1 > 1
	#if($a1 == $a3 (contains 1)){jump to base case}
	beq $a1, $a3, base	#if $a1 (multiplier) == 1, jump to base
	
	#else 
	addi $a1, $a1, -1	#multiplier--
	add $a0, $a0, $a2	#$a0 += $a2
	jal recurse
	
	lw $ra 4($sp)
	lw $a0 0($sp)
	addi $sp, $sp, 8
	
	jr $ra			#to come back from the subroutine --> goes to done:

base:				#base case
	li $v0, 1		#print the total answer (1 for integer)
  	la $v0, ($a3)		#loads address of $a3 into $v0
  	syscall
  	jr $ra
  	
  	#- Up to four function arguments can be “passed” by placing them in
	#argument registers $a0-$a3 before calling the function with jal.
	#— A function can “return” up to two values by placing them in registers
	#$v0-$v1, before returning via jr.
