%include "../utils/printf32.asm"

struc my_struct
    int_x: resb 4
    char_y: resb 1
    string_s: resb 32
endstruc

section .data
    string_format db "%s", 10, 0
    int_format db "%d", 10, 0
    char_format db "%c", 10, 0

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

get_int:
    ; TODO --- return the int value from struct
    ; int get_int(struct my_struct *obj)

    ; Common entry instructions used to set the function stack frame.
    ; Do not modify them.
    push ebp
    mov ebp, esp

    ; The first argument is a pointer to the beginning of the structure, so you
    ; must use it to calculate the actual address of the data you want to get.
    ; TODO --- move the int's value to `eax` to return it

    ; Instructions used to clear the function stack frame and return to the
    ; caller functions. Do not modify them.
    leave
    ret

get_char:
    ; TODO --- return the char value from struct
    ; char get_char(struct my_struct *obj)

    ; Common entry instructions used to set the function stack frame.
    ; Do not modify them.
    push ebp
    mov ebp, esp

    ; The first argument is a pointer to the beginning of the structure, so you
    ; must use it to calculate the actual address of the data you want to get.
    ; TODO --- move the char's value to `eax` to return it.

    ; Instructions used to clear the function stack frame and return to the
    ; caller functions. Do not modify them.
    leave
    ret

get_string:
    ; TODO --- return a pointer to the string value from struct
    ; char* get_string(struct my_struct *obj)

    ; Common entry instructions used to set the function stack frame.
    ; Do not modify them.
    push ebp
    mov ebp, esp

    ; The first argument is a pointer to the beginning of the structure, so you
    ; must use it to calculate the actual address of the data you want to get.
    ; TODO --- move the string's address to `eax` to return it.

    ; Instructions used to clear the function stack frame and return to the
    ; caller functions. Do not modify them.
    leave
    ret

set_int:
    ; TODO --- set the int value from struct with the new one
    ; void set_int(struct my_struct *obj, int x)

    ; Common entry instructions used to set the function stack frame.
    ; Do not modify them.
    push ebp
    mov ebp, esp

    ; The first argument is a pointer to the beginning of the structure, so you
    ; must use it to calculate the actual address of the data you want to set.

    ; Instructions used to clear the function stack frame and return to the
    ; caller functions. Do not modify them.
    leave
    ret

set_char:
    ; TODO --- set the char value from struct with the new one
    ; void set_char(struct my_struct *obj, char y)

    ; Common entry instructions used to set the function stack frame.
    ; Do not modify them.
    push ebp
    mov ebp, esp

    ; The first argument is a pointer to the beginning of the structure, so you
    ; must use it to calculate the actual address of the data you want to set.

    ; Instructions used to clear the function stack frame and return to the
    ; caller functions. Do not modify them.
    leave
    ret

set_string:
    ; TODO --- set the string value from struct with the new one
    ; void set_string(struct my_struct *obj, char* s)

    ; Common entry instructions used to set the function stack frame.
    ; Do not modify them.
    push ebp
    mov ebp, esp

    ; The first argument is a pointer to the beginning of the structure, so you
    ; must use it to calculate the actual address of the data you want to set.

    ; Instructions used to clear the function stack frame and return to the
    ; caller functions. Do not modify them.
    leave
    ret

main:
    push ebp
    mov ebp, esp

    mov edx, [new_int]
    push edx
    push sample_obj
    call set_int
    add esp, 8

    push sample_obj
    call get_int
    add esp, 4

    ;uncomment when get_int is ready
    ;push eax
    ;push int_format
    ;call printf
    ;add esp, 8

    movzx edx, byte [new_char]
    ; movzx is the same as
    ; xor edx, edx
    ; mov dl, byte [new_char]
    push edx
    push sample_obj
    call set_char
    add esp, 8

    push sample_obj
    call get_char
    add esp, 4

    ;uncomment when get_char is ready
    ;push eax
    ;push char_format
    ;call printf
    ;add esp, 8

    mov edx, new_string
    push edx
    push sample_obj
    call set_string
    add esp, 8

    push sample_obj
    call get_string
    add esp, 4

    ;uncomment when get_string is ready
    ;push eax
    ;push string_format
    ;call printf
    ;add esp, 8

    xor eax, eax
    leave
    ret
