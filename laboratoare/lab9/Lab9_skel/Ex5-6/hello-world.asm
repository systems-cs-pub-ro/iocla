global main
extern printf

section .data
    message: db 'Hello, World', 10, 0

section .text
main:
    push message
    call printf
    add esp, 4
    ret
