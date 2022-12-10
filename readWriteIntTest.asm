	.data
number: .space 4
	.text
main:
	li $v0, 5		#read int
  	la $a0, number
  	syscall	
  	sw $v0 number
  	#move $t1, $v0
  	
  	li $v0, 1		#print int
  	lw $a0, number
  	syscall	