%include "printf32.asm"

%define ARRAY_1_LEN 5
%define ARRAY_2_LEN 7
%define ARRAY_OUTPUT_LEN 12

section .data

array_1 dd 27, 46, 55, 83, 84
array_2 dd 1, 4, 21, 26, 59, 92, 105
array_output times 12 dd 0


section .text

extern printf
global main
main:
    mov ebp, esp
    mov eax, 0 ; counter used for array_1
    mov ebx, 0 ; counter used for array_2
    mov ecx, 0 ; counter used for the output array
    sub esp, ARRAY_OUTPUT_LEN

array_1_stack:
    mov ecx, [array_1 + 4 * edx]
    mov [eax], ecx
    inc edx
    add eax, 4
    cmp edx, ARRAY_1_LEN
    jl array_1_on_stack
    mov eax, esp
    sub esp, 4 * ARRAY_2_LEN
    mov ebx, esp
    mov edx, 0
array_2_stack:
    mov ecx, [array_2 + 4 * edx]
    mov [ebx], ecx
    inc edx
    add ebx, 4
    cmp edx, ARRAY_2_LEN
    jl array_2_on_stack
    mov ebx, esp
    sub esp, 4 * ARRAY_OUTPUT_LEN
    mov ecx, esp

merge_arrays:
    mov edx, [eax]
    cmp edx, [ebx]
    jg array_2_lower
array_1_lower:
    mov [ecx], edx
    add eax, 4
    add ecx, 4
    jmp verify_array_end
array_2_lower:
    mov edx, [ebx]
    mov [ecx], edx
    add ebx, 4
    add ecx, 4

verify_array_end:
    mov edx, ebp
    cmp eax, edx
    jge copy_array_2
    sub edx, 4 * ARRAY_1_LEN
    cmp ebx, ebp
    jge copy_array_1
    jmp merge_arrays

copy_array_1:
     xor edx, edx
    mov eax, [eax]
    mov [ecx], edx
    add ecx, 4
    add eax, 4
    cmp eax, ebp
    jb copy_array_1
    jmp print_array
copy_array_2:
    xor edx, edx
    mov edx, [ebx]
    mov [ecx], edx
    add ecx, 4
    add ebx, 4
    mov edx, ebp
    sub edx, 4 * ARRAY_1_LEN
    cmp ebx, edx
    jb copy_array_2
print_array:
    PRINTF32 `Array merged:\n\x0`
    xor eax, eax
    xor ecx, ecx
print:
    mov eax, [array_output + 4 * ecx]
    PRINTF32 `%d \x0`, eax
    inc ecx
    cmp ecx, ARRAY_OUTPUT_LEN
    jb print

    PRINTF32 `\n\x0`
    xor eax, eax
    mov esp, ebp
    ret
