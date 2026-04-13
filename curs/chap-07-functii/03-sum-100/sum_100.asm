; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


%include "printf64.asm"


section .bss

    sum resq 1


section .text

global main


sum_100:
    ; Initialize counter to 100.
    mov rcx, 100

    ; Initialize accumulating register to 0.
    xor rax, rax

    ; Compute sum in accumulating register.
again:
    add rax, rcx
    loopnz again

    ; Store sum in the `sum` global variable.
    mov [sum], rax

    ret


main:
    push rbp
    mov rbp, rsp

    ; Call sum_100 to compute of first 100 natural numbers.
    call sum_100

    ; Print sum.
    PRINTF64 `Sum is: %lu\n\0`, qword [sum]

    leave
    ret
