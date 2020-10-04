; nasm -f elf32 -g -F dwarf endian.asm 
; gcc -g -m32 -o endian endian.o

 
section .data
	fmts db '%s', 10, 0
	msg db 'Încărcați binarul în gdb, și examinati variabilele a,b,c.', 0xa, 0
	a db 1, 2, 3, 4, 0xa, 0xb, 0xc, 0xd, 'a', 'b','c','d'
	b dw 0x0102, 0x0304, 0x0a0b, 0x0c0d, 4127, -27714
	c dd 0x01020304, 0xabcd6789, 100, -100
;	d dd a, b, c, d		
 	
section .text
	global main
	extern printf
	
main:   
	push msg
	push fmts
	call printf
	add esp, 8

iesire:
	mov eax, 1  
	ret         
