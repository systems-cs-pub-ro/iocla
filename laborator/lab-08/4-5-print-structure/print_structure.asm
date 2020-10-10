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

    lea eax, [sample_student + name]
    PRINTF32 `%s\x0`, string_name
    PRINTF32 `%s\n\x0`, eax
    lea eax, [sample_student + surname]
    PRINTF32 `%s\x0`, string_surname
    PRINTF32 `%s\n\x0`, eax
    mov al, byte [sample_student + age]
    PRINTF32 `%s\x0`, string_age
    xor ebx, ebx
    mov bl, al
    PRINTF32 `%u\n\x0`, ebx
    lea eax, [sample_student + group]
    PRINTF32 `%s\x0`, string_group
    PRINTF32 `%s\n\x0`, eax
    mov al, byte [sample_student + gender]
    PRINTF32 `%s\x0`, string_gender
    xor ebx, ebx
    mov bl, al
    PRINTF32 `%u\n\x0`, ebx
    mov ax, [sample_student + birth_year]
    PRINTF32 `%s\x0`, string_year
    xor ebx, ebx
    mov bx, ax
    PRINTF32 `%hu\n\x0`, ebx

    leave
    ret
