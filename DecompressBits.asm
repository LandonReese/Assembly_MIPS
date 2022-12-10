#Landon Reese --- Decompress Bits
          .data

chars:    .ascii "ABCDEFGHIJKLMNOPQRSTUVWXYZ .,!-'"

msg1:     .word 0x93EA9646, 0xCDE50442, 0x34D29306, 0xD1F33720

          .word 0x56033D01, 0x394D963B, 0xDE7BEFA4  

msg1end:

	  .text 
	  la $t0, msg1		#268501024 address stores pointer to msg1	nextByte
	  la $t1, msg1end	#268501052 address stores pointer to msg1End
	  
	  #lbu $t2, 0($t0)	#loads HEX 46 into $t1, prints 70 (decimal equivalent)
	  
	  #sb $0, bits		#bits = 0
	  #sb $0, buffer		#buffer = 0
	  #li $v0, 1		#print code 1 prints an integer
	  #la $a0, ($t1)
	  #syscall

while:	  
	  bgt $t2, 5, endif	#if $t2(bits) > 5, go to endif
	  lbu $t4, 0($t0)	#lbu nextByte into temp put 8 bits into 32 so it doesn't sign extend
	  addiu $t0, $t0, 1	#nextByte++
	  sll $t3, $t3, 8 	#buffer = (buffer << 8); lui in buffer, then ori temp
	  or $t3, $t3, $t4	#buffer = buffer | temp;
	  addiu $t2, $t2, 8	#bits += 8;
	  
endif:				#line 23

	  addi $t2, $t2, -5	#decreases num of bits by 5
	  srlv $t5, $t3, $t2	#right shift buffer by 8 in temp2 //3 needs to be changed to bits as an int
	  and $t5, $t5, 0x1F	#temp2 & 0x1F to convert into 5 bits to then print
	  
	  li $v0, 11		#system code 11 prints character
	  lbu $a0, chars($t5)	
	  syscall		#prints character?
	  
	  blt $t1, $t0, whileExit	#if t1(msgEnd) < t0(nextByte) goto whileExit
	  j while
whileExit:
	  li $v0, 10		#10 = exit
	  syscall
	  
####################################-NOTES-####################################
#1 Byte = 8 Bits
#2 Bytes = Halfword, 16 bits

#	  lbu $t2, 1($t0)	#loads HEX 96 into $t1, prints 150(decimal equivalent)
#	  lbu $t3, 2($t0)	#loads HEX EA into $t3, prints 234(decimal equivalent) 
#	  lbu $t4, 3($t0)	#loads HEX 93 into $t4, prints 147(decimal equivalent) 
#	  lbu $t5, 4($t0)	#loads HEX 42 into $t5, prints 66 (decimal equivalent) 
#	  lbu $t6, 5($t0)	#loads HEX 04 into $t6, prints 4  (decimal equivalent) 
	  
	  #li $v0, 1		#print code 1 prints an integer
	  #la $a0, ($t1)
	  #syscall
	  
	  #15	while (nextbyte < msgend){
#16		if(bits < 5){
#17			temp = *nextbyte;	address, la into temp
#18			nextbyte++;  		increments
#19			buffer = (buffer << 8); lui in buffer, then ori temp
#20			buffer = buffer | temp;
#21			bits += 8;
#22		}
#23 endif
#24		bits -= 5;
#25		temp2 = buffer >> bits;
#26		temp2 = temp2 & 0x1F;
#27		std::cout << chars[temp2]
#28	}

#msg1:     .word 0x93EA9646, 0xCDE50442, 0x34D29306, 0xD1F33720 .word 0x56033D01, 0x394D963B, 0xDE7BEFA4  
#$t0 contains address of msg1		nextByte
#$t1 contains address of (msg1+1)	msgEnd
#$t2 contains bits
#$t3 contains buffer
#$t4 contains temp
#$t5 contains temp2
