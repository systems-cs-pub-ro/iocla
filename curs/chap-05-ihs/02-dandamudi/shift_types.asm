section .text

global main
main:
	push ebp
	mov ebp, esp

	mov eax, 0xabcdef01
	shl eax, 1
	mov eax, 0xabcdef01
	sal eax, 1

	leave
	ret
