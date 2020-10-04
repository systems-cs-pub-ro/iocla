; nasm -f elf32 -g -F dwarf hello.asm 
; gcc -g -m32 -o hello hello.o
; se poate compila cu gcc sau rula în sasm
; 
	
section .data
	msg db 'Hello, world!', 0xa
	len dd $ - msg

	
section .text
	global main
	
main:
        push ebp
        mov ebp, esp; for correct debugging
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, [len]
	int 0x80

	xor eax, eax
        pop ebp
	ret
