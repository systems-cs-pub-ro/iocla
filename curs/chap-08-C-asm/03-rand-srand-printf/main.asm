; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .rodata

    printf_format db "Random number: %d", 10, 0


section .text

extern time
extern srand
extern rand
extern printf
global main


main:
    push rbp
    mov rbp, rsp

    ; Call time(NULL) to get current epoch time.
    xor rdi, rdi            ; NULL pointer
    call time

    ; Call srand(seed) to initialize the random number generator.
    mov rdi, rax
    call srand

    ; Call rand() to generate a random number.
    call rand

    ; Call printf(format, number) - 2 arguments.
    ; rdi = format string (1st argument)
    ; rsi = random number (2nd argument)
    lea rdi, [printf_format]
    mov rsi, rax
    xor rax, rax            ; no vector register arguments
    call printf

    xor rax, rax            ; return 0
    leave
    ret
