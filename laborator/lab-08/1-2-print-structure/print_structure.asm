%include "../utils/printf32.asm"

struc stud_struct
    name: resb 32
    surname: resb 32
    age: resb 1
    group: resb 8
    gender: resb 1
    birth_year: resw 1
endstruc

section .data
    string_format db "%s", 0
    string_endline_format db "%s", 10, 0
    dec_format db "%d", 10, 0

sample_student:
    istruc stud_struct
        at name, db 'Andrei', 0
        at surname, db 'Voinea', 0
        at age, db 21
        at group, db '321CA', 0
        at gender, db 1
        at birth_year, dw 1994
    iend

string_name db "Name: ", 0
string_surname db "Surname: ", 0
string_age db "Age: ", 0
string_group db "Group: ", 0
string_gender db "Gender: ", 0
string_year db "Birth year: ", 0

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    ; TODO: Update name, surname, birth_year, gender and age such that:
    ; birth_year is 1993
    ; age is 22
    ; group is '323CA'

    lea ebx, [string_name]
    push ebx
    push string_format
    call printf
    add esp, 8
    lea eax, [sample_student + name]
    push eax
    push string_endline_format
    call printf
    add esp, 8

    lea ebx, [string_surname]
    push ebx
    push string_format
    call printf
    add esp, 8
    lea eax, [sample_student + surname]
    push eax
    push string_endline_format
    call printf
    add esp, 8

    lea ebx, [string_age]
    push ebx
    push string_format
    call printf
    add esp, 8
    mov al, byte [sample_student + age]
    xor ebx, ebx
    mov bl, al
    push ebx
    push dec_format
    call printf
    add esp, 8

    lea ebx, [string_group]
    push ebx
    push string_format
    call printf
    add esp, 8
    lea eax, [sample_student + group]
    push eax
    push string_endline_format
    call printf
    add esp, 8

    lea ebx, [string_gender]
    push ebx
    push string_format
    call printf
    add esp, 8
    mov al, byte [sample_student + gender]
    xor ebx, ebx
    mov bl, al
    push ebx
    push dec_format
    call printf
    add esp, 8

    lea ebx, [string_year]
    push ebx
    push string_format
    call printf
    add esp, 8
    mov ax, [sample_student + birth_year]
    xor ebx, ebx
    mov bx, ax
    push ebx
    push dec_format
    call printf
    add esp, 8

    leave
    ret
