extern printf

section .data
	message db "Hello", 0

section .text

global print_hello

;   TODO: Adăugați instrucțiunea lipsă
print_hello:
	push ebp

	push message
	call printf
	add esp, 4

	leave
	ret
