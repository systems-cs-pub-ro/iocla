%include "../../util/printf64.asm"

section .bss
    sum: resq 1

section .text
    global main
    extern printf

main:
        push    rbp
        mov     rbp, rsp
        mov     eax, 0      ; eax is the loop counter
        mov     edx, 0      ; edx is sum
begin:
        cmp     eax, 100
        ja      out
        add     edx, eax
        add     eax, 1
        jmp     begin
out:
        mov [sum], rdx

        PRINTF64 `%ld\n\x0`, qword [sum]
        nop
        pop     rbp
        ret
