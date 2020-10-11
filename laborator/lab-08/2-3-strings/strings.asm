%include "../utils/printf32.asm"

section .data
    string db "Lorem ipsum dolor sit amet.", 0
    print_strlen db "strlen: ", 10, 0
    print_occ db "occurences of `i`:", 10, 0

    occurences dd 0
    length dd 0    
    char db 'i'

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    ; TODO1: compute the length of a string

    ; TODO1: save the result in at address length

    ; print the result of strlen
    PRINTF32 `%s\x0`, print_strlen
    PRINTF32 `%u\n\x0`, [length]

    ; TODO2: compute the number of occurences

    ; TODO2: save the result in at address occurences

    ; print the number of occurences of the char
    PRINTF32 `%s\x0`, print_occ
    PRINTF32 `%u\n\x0`,[occurences]

    xor eax, eax
    leave
    ret
