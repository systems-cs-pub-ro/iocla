section .rodata
    fmt db "result: %f", 10, 0

section .data
    result dq 0

section .text

extern printf
global main

main:
    push ebp
    mov ebp, esp

    sub esp, 4
    mov dword [esp], 0x40000000
    fld dword [esp]
    fadd dword [esp]
    fstp qword [result]

    push dword [result+4]
    push dword [result]
    push fmt
    call printf
    add esp, 8

    leave
    ret
