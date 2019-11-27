
extern printf

;; reassemble with different values for bigcount, repcount 
;; change the code in %rep to test with various instructions 		
;;	 
	 
section .data
	myformat: db 'instructions= %lld cycles= %lld', 0xa, 0
	before dq 0
	after dq 0
	repcount equ 250
	bigcount equ 10000000

section .text
	global main
main:
	push ebp		; need stack frame for  
	mov ebp, esp        	; gdb to work nicely with nasm -F dwarf 

	
	rdtscp
	mov [before + 4], edx
	mov [before], eax

	mov ecx, bigcount
repeat:
	;; prepare cycle with 1000 instructions 
	%rep	 repcount
	xor ebx, eax		; repsize = 4 instructions to duplicate 
	xor esi, edi
	xor ebp, ebp
	mov edx, ecx
	%endrep
	dec ecx
	jnz repeat
	;; should take bigcount*repcount*4 cycles	
	rdtscp
	
	sub eax, [before]
	sbb edx, [before+4]
	jnc print
	neg edx 		;clock ever backwards? 
	
print:
	mov [after + 4], edx
	mov [after], eax

	mov eax, 4  	        ; repsize = 4 instructions in the %rep above
	mov edx, repcount
	mul edx 		; make sure repsize * repcount < 2^32
	mov edx, bigcount 	; bigcount < 2^32
	mul edx			; edx:eax = repsize * repcount * bigcount 
 	
	push dword [after + 4]
	push dword [after]
	push edx
	push eax
	push dword myformat
	call printf
	add esp, 20 

	pop ebp 
	ret                 ; Return from the main routine

	
