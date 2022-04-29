%include "../utils/printf32.asm"

%define ARRAY_SIZE 13
%define DECIMAL_PLACES 5

section .data

    num_array dw 76, 12, 65, 19, 781, 671, 431, 761, 782, 12, 91, 25, 9
    decimal_point db ".",0


section .text

extern printf
global main
main:
    xor eax, eax
    mov ecx, ARRAY_SIZE

    ; TODO1 - compute the sum of the vector numbers - store it in eax

label1:
    mov bx, word [num_array + 2 * (ecx - 1)]
    add eax, ebx
    loop label1

    PRINTF32 `Sum of numbers: %d\n\x0`, eax

    ; TODO2 - compute the quotient of the mean

    xor edx, edx
    mov ebx, ARRAY_SIZE
    div ebx

    PRINTF32 `Mean of numbers: %d\x0`, eax
    PRINTF32 `.\x0`

    mov ecx, DECIMAL_PLACES
    mov esi, 10
compute_decimal_place:

    ; TODO3 - compute the current decimal place - store it in eax

    mov eax, edx
    mul esi
    xor edx, edx
    div ebx

    PRINTF32 `%d\x0`, eax
    dec ecx
    cmp ecx, 0
    jg compute_decimal_place

    PRINTF32 `\n\x0`
    xor eax, eax
    ret
