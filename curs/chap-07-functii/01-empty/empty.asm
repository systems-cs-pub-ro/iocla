; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .text

global main


empty:
    ret


main:
    push rbp
    mov rbp, rsp

    call empty
    call empty
    call empty

    leave
    ret
