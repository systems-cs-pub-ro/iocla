section .text

global main

main:
	push ebp
	mov ebp, esp

	jmp oldlabel
	mov edx, 3
	mov ecx, 2
	mov ebx, 1
	mov eax, 0
	xor eax, eax

oldlabel:
	mov eax, 1
	xor eax, eax
	inc eax
	jmp oldlabel

label:
	add eax, 1
	inc eax
	jmp label


	leave
	ret
