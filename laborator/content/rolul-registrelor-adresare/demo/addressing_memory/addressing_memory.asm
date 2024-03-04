%include "../../utils/printf32.asm"

%define ARRAY_SIZE 10

section .data
    my_array   times ARRAY_SIZE dd 0

section .text

extern printf
global main
main:
    push ebp
    mov ebp, esp

    xor eax, eax

    xor ecx, ecx
for_print_before:
    PRINTF32 `my_array[%d]: %d\n\x0`, ecx, [my_array + ecx*4]
    inc ecx
    cmp ecx, ARRAY_SIZE
    jl for_print_before

    xor ecx, ecx
for:
    inc dword [my_array + ecx*4]
    inc ecx
    cmp ecx, ARRAY_SIZE
    jl for

    xor ecx, ecx
for_print_after:
    PRINTF32 `my_array[%d]: %d\n\x0`, ecx, [my_array + ecx*4]
    inc ecx
    cmp ecx, ARRAY_SIZE
    jl for_print_after

    leave
    ret

