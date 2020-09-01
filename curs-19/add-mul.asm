section .data

    b dd 1.1
    c dd 2.2
    a dd 1.58
    t dq 50.12
    r dd 0

section .text

global main

main:
    push ebp
    mov ebp, esp

    fld dword [b]
    fld dword [c]
    fmul
    fld dword [a]
    fadd
    fstp dword [r]
    fld qword [t]
    fstp qword [t]

    leave
    ret
