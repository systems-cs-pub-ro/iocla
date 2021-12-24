%include "../io.mac"

section .bss
    sum: resd 1

section .text
    global main
    extern printf

main:
        push    ebp
        mov     ebp, esp
        mov     eax, 0      ; eax is the loop counter
        mov     edx, 0      ; edx is sum
begin:
        cmp     eax, 100
        ja      out
        add     edx, eax
        add     eax, 1
        jmp     begin
out:
        mov [sum], edx

        PRINTF32 `%d\n\x0`, [sum]
        nop
        pop     ebp
        ret
