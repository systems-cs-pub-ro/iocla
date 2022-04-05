%include "printf32.asm"

section .text
    global main
    extern printf

main:
    mov eax, 7       ; vrem sa aflam al N-lea numar; N = 7
    cmp eax, 1
    je end
    cmp eax, 0
    je end

    ; TODO: calculati al N-lea numar fibonacci (f(0) = 0, f(1) = 1)
    mov ebx, 0
    mov ecx, 1

fibo:
    xchg ebx, ecx
    add ecx, ebx
    sub eax, 1
    cmp eax, 1
    ja fibo
    mov eax, ecx

end:
    PRINTF32 `%d\n\x0`, eax
    ret
