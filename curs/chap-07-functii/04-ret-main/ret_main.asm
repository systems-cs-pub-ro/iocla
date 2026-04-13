; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .text

global main


main:
    push rbp
    mov rbp, rsp

    mov rax, 42

    leave
    ret
