; nasm -f elf32 -g -F dwarf hello.asm 
; gcc -g -m32 -o hello hello.o
; se poate compila cu gcc sau rula în sasm
; 
section .data
	fmts db '%s',0
	fmtx db '%x', 10, 0		
	msg db 'Hello, world!', 0xa, 0
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
