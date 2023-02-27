; nasm -f elf32 -g -F dwarf dt.asm 
; gcc -g -m32 -no-pie -o dt dt.o

	
section .data
v1:	dd 0xabcd1234
v2:	dd 0x7890aabb

;; inspect with gdb command x how these variables are placed
;; in the data section
	
	db 0x55                ; just the byte 0x55 ​
	db 0x55,0x56,0x57      ; three bytes in succession ​
	db 'a',0x55            ; character constants are OK ​
msg:	
	db 'Hello world!',13,10,0     
len:	dd $ - msg	
	dw 0x1234              ; 0x34 0x12 ​
	dw 'a'                 ; 0x61 0x00 (it's just a number) ​
	dw 'ab'                ; 0x61 0x62 (character constant) ​
	dw 'abc'               ; 0x61 0x62 0x63 0x00 (string) ​
	dd 0x12345678          ; 0x78 0x56 0x34 0x12 ​
	dd 1.234567890         ; floating-point constant ​
	dq 0x123456789abcdef0  ; eight byte constant ​
	dq 1.234567e20         ; double-precision float ​
	dt 1.234567e20         ; extended-precision float​

	
section .text
	global main
	
main:
	push ebp       
	mov ebp, esp

; inspect code generated for the next instructions 
; 
	mov ebx, 0x56559026
	mov ebx, v1 
	mov ebx, [v1]
	mov eax, v2 
	mov bx, [eax]
	

	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, [len]
	int 0x80           ; apel la un serviciu linux (syscall), funcția=4 (write), ECX, EDX parametri 

iesire:
	xor eax, eax       ; vom returna 0 către shell
        pop ebp            ; refacem stiva
	ret                ; părăsim main 
