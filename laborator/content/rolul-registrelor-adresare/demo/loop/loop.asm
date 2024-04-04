%include "../../utils/printf32.asm"

%define ARRAY_SIZE 9
; loop = loope

section .data
    my_array   times ARRAY_SIZE dd 0

section .text

extern printf
global main
main:
    push ebp
    mov ebp, esp

    xor eax, eax

    mov ecx, ARRAY_SIZE
for_print_before:
    PRINTF32 `my_array[%d]: %d\n\x0`, ecx, [my_array + ecx*4]
    loop for_print_before

    mov ecx, ARRAY_SIZE
for:
    cmp ecx, 3
    jle label1
    inc dword [my_array + ecx*4]
    loop for

label1:
    mov ecx, ARRAY_SIZE
for_print_after:
    PRINTF32 `my_array[%d]: %d\n\x0`, ecx, [my_array + ecx*4]
    loop for_print_after

    leave
    ret

