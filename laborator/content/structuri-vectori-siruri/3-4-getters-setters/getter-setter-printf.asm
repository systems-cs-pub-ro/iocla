%include "printf32.asm"

struc my_struct
    int_x: resb 4
    char_y: resb 1
    string_s: resb 32
endstruc

section .data
    sample_obj:
        istruc my_struct
            at int_x, dd 1000
            at char_y, db 'a'
            at string_s, db 'My string is better than yours', 0
        iend

    new_int dd 2000
    new_char db 'b'
    new_string db 'Are you sure?', 0

int_format db "int_x: %d", 10, 0
char_format db "char_y: %c", 10, 0
string_format db "string_s: %s", 10, 0

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp

    mov eax, [new_int]
    mov dword [sample_obj + int_x], eax

    lea eax, [sample_obj + int_x]
    push dword [eax]
    push int_format
    call printf
    add esp, 8

    mov  al, [new_char]
    mov byte [sample_obj + char_y], al

    lea eax, [sample_obj + char_y]
    movzx eax, byte [eax]
    push eax
    push char_format
    call printf
    add esp, 8

    mov eax, [new_string]
    mov [sample_obj + string_s], eax
    mov eax, [new_string + 4]
    mov [sample_obj + string_s + 4], eax
    mov eax, [new_string + 8]
    mov [sample_obj + string_s + 8], eax
    mov [sample_obj + string_s + 8], eax
    mov eax, [new_string + 12]
    mov [sample_obj + string_s + 12], eax



    lea eax, [sample_obj + string_s]
    push eax
    push string_format
    call printf
    add esp, 8

    xor eax, eax
    leave
    ret
