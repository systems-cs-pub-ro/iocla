	
section .data
	msg db `Trebuie urmărită stiva în gdb\nla locurile indicate.\n\x0`
	z dd 0x01020304

 	
section .text
	global main
	extern printf
main:
	push ebp           	; cadru de stivă adăugat de sasm
	mov ebp, esp       	; for correct debugging
pushz:
	push dword [z]
				; în gdb x/4ub $esp  răspunde 0xffffd2e4:  4  3  2  1​
				; esp pointează la octetul LSB al ultimului element​
				; inserat​
	mov ebx, [esp]
	pop eax			; ebx și eax conțin 0x1020304​
popabcd:	
	mov esi, 0x0a0b0c0d
	mov [esp-4], esi 	; esp-4 pointează la primul spațiu liber ​
	sub esp, 4       	; echivalent cu push esi​
	pop edi
				; edi = esi = 0x0a0b0c0d ​
				; stiva are aceeași stare ca la început​
				; sub esp e spațiu liber​
iesire:
	push msg
	call printf
	add esp, 4
	
	xor eax, eax       	; vom returna 0 către shell
        pop ebp            	; refacem stiva
	ret                	; părăsim main 
