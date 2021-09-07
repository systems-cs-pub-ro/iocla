%include "../io.mac"

section .text
    global main
    extern printf

main:
    mov eax, 7       ; vrem sa aflam al N-lea numar; N = 7

    ; TODO: calculati al N-lea numar fibonacci (f(0) = 0, f(1) = 1)

    ret
