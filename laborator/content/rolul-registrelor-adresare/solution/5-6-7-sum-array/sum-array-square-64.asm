%include "../utils/printf32.asm"

%define ARRAY_SIZE 10

section .data
    big_numbers_array dd 20000001, 3000000, 3000000, 23456789, 56789123, 123456789, 987654321, 56473829, 87564836, 777777777
    print_format db "Array sum is ", 0

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp
    xor eax, eax

    mov ecx, ARRAY_SIZE
    xor eax, eax
    xor edx, edx
    xor esi, esi
    xor ebx, ebx
add_dword_array_element:
    push edx
    push eax
    mov eax, dword [big_numbers_array + 4 * ecx - 4]
    mov ebx, dword [big_numbers_array + 4 * ecx - 4]
    mul ebx
    mov ebx, eax
    mov esi, edx
    pop eax
    add eax, ebx
    pop edx
    adc edx, esi
    loop add_dword_array_element

    PRINTF32 `%s\x0`, print_format
    PRINTF32 `%lld\n\x0`, eax, edx

    leave
    ret