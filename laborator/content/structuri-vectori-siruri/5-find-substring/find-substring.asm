%include "printf32.asm"

section .data
source_text: db "ABCABCBABCBABCBBBABABBCBABCBAAACCCB", 0
substring: db "BABC", 0

print_format: db "Substring found at index: %d", 10, 0

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    ; TODO: Print the start indices for all occurrences of the substring in source_text
    xor ecx, ecx
    mov eax, source_text
loop:
    mov ebx, substring

strstr_loop:
    cmp byte [ebx], 0
    je found_str
    mov dl, [eax]
    cmp byte [ebx], dl
    jne exit_loop
    inc eax
    inc ebx
    inc ecx
    jmp strstr_loop

found_str:
    push ecx
    push print_format
    call printf
    add esp, 8

exit_loop:
    inc eax
    cmp byte [eax], 0
    je end_label
    jmp loop

end_label:
    leave
    ret
