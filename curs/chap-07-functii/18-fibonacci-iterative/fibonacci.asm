; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .rodata

    prompt db "Introduce N: ", 0
    scanf_format db "%lu", 0
    printf_format db "Fibonnaci(N) is: %lu", 10, 0


section .text

extern printf
extern scanf
global main


fibonacci:
    cmp rdi, 2
    jge .continue

    mov rax, 1
    jmp .out

.continue:
    ; Use rax as accumulator.
    ; Use rdx as secondary value.
    mov rax, 1
    mov rdx, 1

    ; Go from 2 to N and add values.
    ; Use rcx as counter.
    mov rcx, rdi
    sub rcx, 1
.again:
    ; Make rdx = fibonacci(N-1) and rax = fibonacci(N-2)
    xchg rax, rdx
    ; Compute in rax = fibonacci(N) = fibonacci(N-1) + fibonacci(N-2).
    add rax, rdx

    loop .again

.out:
    ret


main:
    push rbp
    mov rbp, rsp

    ; Allocate space on the stack. Keep it 16 bytes-aligned.
    ; Allocate space for:
    ; - N (unsigned long, 8 bytes): address is [rbp-16].
    sub rsp, 16

    ; Print prompt.
    lea rdi, [prompt]
    xor rax, rax            ; no vector register arguments
    call printf

    ; Read N using scanf.
    lea rdi, [scanf_format]
    lea rsi, [rbp-16]
    xor rax, rax            ; no vector register arguments
    call scanf

    ; Call fibonaci(N).
    mov rdi, [rbp-16]
    call fibonacci

    ; Print fibonacci.
    lea rdi, [printf_format]
    mov rsi, rax
    xor rax, rax            ; no vector register arguments
    call printf

    leave
    ret
