; nasm -f elf32 -g -F dwarf hello.asm 
; gcc -g -m32 -o hello hello.o
; se poate compila cu gcc sau rula în sasn 
; 
	
section .data
	msg db 'Hello, world!', 0xa
	len dd $ - msg

 	
section .text
	global main
	
main:
         mov ebp, esp; for correct debugging
         push ebp           ; cadru de stivă adăugat de sasm
         mov ebp, esp       ; for correct debugging
	mov ax, 0x102      ; o constantă într-un registru de 16 biți
                            ; AX = 258 în zecimal/decimal, 0x102 în hexa, 100000010 în binar
	mov ah, -1         ; o constantă într-un registru de 8 biți
	mov al, 1          ; AX este de fapt AH concatenat cu AL (high and low)
adunare:                    ; etichetă
	add al, ah         ; aritmetică pe 8 biți
                            ; urmăriți registrul FLAGS
                            ; *exercițiu*: încercați diverse valori, și observați ZF, CF, OF, PF 
	mov eax, 0x1234ABCD; EAX este pe 32 biți, partea de jos (least significant) se numește AX
                            ; în AX avem 0xABCD     
       ; jmp iesire         ; decomenteaza pentru a sări peste print string   
	and eax, 0xffff0000
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, [len]
	int 0x80           ; apel la un serviciu linux (syscall), funcția=4 (write), ECX, EDX parametri 

iesire:
	xor eax, eax       ; vom returna 0 către shell
         pop ebp            ; refacem stiva
	ret                ; părăsim main 
