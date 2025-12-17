; nasm -f elf64 -g -F dwarf hello.asm 
; gcc -g  -o hello hello.o
; ./hello
; 
	
section .data
	msg db 'Hello, world!', 0xa
	len dd $ - msg

 	
section .text
	global main
	
main:

	mov ax, 0x102      	; o constantă într-un registru de 16 biți
				; AX = 258 în zecimal/decimal, 0x102 în hexa, 100000010 în binar
	mov ah, -1         	; o constantă într-un registru de 8 biți
	mov al, 1          	; AX este de fapt AH concatenat cu AL (high and low)
adunare:                    	; etichetă
	add al, ah         	; aritmetică pe 8 biți
				; urmăriți registrul FLAGS
				; *exercițiu*: încercați diverse valori, și observați ZF, CF, OF, PF 
	mov eax, 0x1234ABCD	; EAX este pe 32 biți, partea de jos (least significant) se numește AX
				; în AX avem 0xABCD     
       ; jmp iesire         	; decomenteaza pentru a sări peste print string   
  	mov rdi, 0x1
    	mov rsi, msg
    	mov rdx, [len]
    	mov rax, 0x1
    	syscall
      ; apel la un serviciu linux (syscall), funcția=1 (write), RSI, RDI parametri 

iesire:
	xor rax, rax       ; vom returna 0 către shell
	ret                ; părăsim main 
