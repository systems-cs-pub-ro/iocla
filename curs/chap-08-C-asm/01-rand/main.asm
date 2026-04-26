; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .rodata

    printf_format db "Random number: %d", 10, 0


section .text

extern rand
global main


main:
    push rbp
    mov rbp, rsp

    ; Call rand() - no arguments, returns random number in rax (eax).
    call rand

    ; We do nothing with the result.

    xor rax, rax            ; return 0
    leave
    ret
