%include "../utils/printf32.asm"

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    mov eax, 211    ; to be broken down into powers of 2
    mov ebx, 0      ; stores the current power

    ; TODO - print the powers of 2 that generate number stored in EAX
    mov ecx, 1
    mov esi, 1
start:
    test eax, ecx
    jz next
    PRINTF32 `%d \x0`, ecx
next:
	shl ecx, 1
	inc esi
	cmp esi, 32
	jne start

PRINTF32 `\n \x0`
    leave
    ret