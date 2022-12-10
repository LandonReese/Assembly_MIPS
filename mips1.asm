	.data
	
hw:	.asciiz "Hello World"
	
	.text
	.globl main
main:
	la $a0, 4
	syscall $v0, 0x00000004
	li $v0, 10 #exit ###li stands for load immediate
	syscall