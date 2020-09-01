	
section .data
	msg db `Trebuie urmărită stiva în gdb\nla locurile indicate.\n\x0`
	z dd 0x01020304

 	
section .text
	global main
	extern printf
main:
	push ebp        ; cadru de stivă standard
	mov ebp, esp    ; 
pushz:
	push dword [z]
			; în gdb x/4ub $esp răspunde 0xffffd294:  4  3  2  1​
			; esp pointează la octetul LSB al ultimului element​
			; inserat​
                        ; x/4ub &z răspunde la fel - stack și data folosesc little endian
	mov ebx, [esp] 	; ebx conține 0x1020304, dar valoarea rămâne în stivă

popabcd:	
	mov esi, 0x0a0b0c0d
	mov [esp-4], esi; esp-4 pointează la primul spațiu liber ​
	sub esp, 4      ; echivalent cu push esi​
			; x/8ub $esp răspunde 0xffffd290: 13 12 11 10 4 3 2 1

	pop edi
	pop eax		; edi = esi = 0x0a0b0c0d; eax = ebx = 0x01020304 ​
			; stiva are aceeași stare ca la început​ (pushz)
			; sub esp e spațiu liber​
iesire:
	push msg
	call printf
	add esp, 4
	
	xor eax, eax	; vom returna 0 către shell
	pop ebp		; refacem stiva
	ret		; părăsim main 
