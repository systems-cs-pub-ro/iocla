; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .rodata

    printf_format db "Random number: %d", 10, 0


section .text

extern time
extern srand
extern rand
global main


main:
    push rbp
    mov rbp, rsp

    ; Call time(NULL) - 1st argument is NULL (0), returns current epoch time in rax.
    xor rdi, rdi            ; NULL pointer
    call time

    ; Call srand(time) - 1st argument is the seed (return value of time in rax).
    ; srand() receives an argument and returns void.
    mov rdi, rax
    call srand

    ; Call rand() - no arguments, returns a random number in rax (eax).
    call rand

    ; We do nothing with the result.

    xor rax, rax            ; return 0
    leave
    ret
