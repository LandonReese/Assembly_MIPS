#Landon Reese ReverseIt --> Reese, Landon
	.data
prompt1:.asciiz "Enter your name: "
	.ascii "    "
prompt2:.asciiz "Reversed: "
prompt3:.asciiz ", "
name:   .space 100

	.text
	#a1 contains the original total name we've inputted
	#t1 contains our word, starts blank until filled
	#t2 contains ' '
	#a0 contains name
	#

main:  	li $v0, 4		#print prompt
  	la $a0, prompt1
  	syscall

  	li $v0, 8		#read string
  	la $a0 name
  	li $a1, 100		#load immediate into a1 of size 100
  	syscall			#enter name

  	li $v0, 4		#print "Reversed: "
  	la $a0, prompt2		#load address of prompt2 into a0
  	syscall			#call to print prompt2

  	la $t1, name		#base address of buffer
  	addi $t1, $t1, -1

  	
  	li $t2, ' ' 		#stores a space into register t2
  	#li $t3, 0($a0)		#hopefulle stores the first letter
  
  
#loop1 loops until it finds a space after the first name
loop1:	addi $t1, $t1, 1	#$t1++
	lbu $t0, 0($t1)		#t0 = t1 load byte unsigned from register t0 into t1
	
	#beq $t0, $zero, exit
	
  	bne $t0, $t2, loop1	#post test loop that keeps us in the loop until we find a space
  	#end loop1	
  	
#at this exact point, we have incremented until we have found a space		
#loop2 loops until it finds the newline character after the last name, printing out the last name as it loops

loop2:	addi $t1, $t1, 1	#t1++ increments to 1 after space
	lbu $t0, 0($t1)		#read character after space
	beq $t0, '\n', exit	#if the function reaches the end of the name, exit
  	li $v0, 11		#function code 11 prints a character
  	add $a0, $t0, $zero
  	syscall	
  	bne $t0, $zero, loop2	#keeps us in the loop until we find the end
  	#end loop2
  	
exit:	li $v0, 4		#print prompt
  	la $a0, prompt3		#prints ", "
  	syscall
  	
 #PROMPT AT THIS EXACT POINT IN TIME (Landon Reese)
 #"Reversed: Reese, "
  	
#next step: loop back to find a previous space
#substep t1 -= 1 until you find a space before the last name

#last name backwards traversal
loop3:	addi $t1, $t1, -1	#$t1--
	lbu $t0, 0($t1)	
	
#test	#li $v0, 11		#print character
  	#add $a0, $t0, $zero	#prints in loop3
  	#syscall
  		#t0 = t1 load byte unsigned from register t0 into t1
	bne $t0, $t2, loop3	#post test loop that keeps us in the loop until we find a space
  	#end loop3	
  	
#substep t1 -= 1 until you find the space before the first name
#first name backwards traversal
loop4:	addi $t1, $t1, -1	#$t1--
	lbu $t0, 0($t1)		#t0 = t1 load byte unsigned from register t0 into t1
	
#test	#li $v0, 11		#print character TEST
  	#add $a0, $t0, $zero	#prints in loop3
  	#syscall
	
  	bne $t0, $t2, loop4	#if the byte is not equal to a space, -1 and try again
  	#end loop4
  	
#substep 3 += t1 and print until you reach the space
#places me at the index right before the first name

	addi $t1, $t1, 1	#Places me from index of -1 to index of first name 0

#loop4 4 is printing Reversed: as :desreveR
loop5:	addi $t1, $t1, 1	#t1++ increments to 1 after space
	lbu $t0, 0($t1)		#read character after space
	#beq $t0, '\n', exit	#if the function reaches the end of the name, exit
  	li $v0, 11		#function code 11 prints a character
  	add $a0, $t0, $zero
  	syscall	
  	bne $t0, $t2, loop5	#keeps us in the loop until we find the end
  	#end loop5