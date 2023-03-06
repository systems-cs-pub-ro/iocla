%include "../utils/printf32.asm"

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

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp

    ; TODO
    ; print all three values (int_x, char_y, string_s) from simple_obj
    ; Hint: use "lea reg, [base + offset]" to save the result of
    ; "base + offset" into register "reg"

    ; TODO
    ; write the equivalent of "simple_obj->int_x = new_int"

    ; TODO
    ; write the equivalent of "simple_obj->char_y = new_char"

    ; TODO
    ; write the equivalent of "strcpy(simple_obj->string_s, new_string)"

    ; TODO
    ; print all three values again to validate the results of the
    ; three set operations above

    xor eax, eax
    leave
    ret
