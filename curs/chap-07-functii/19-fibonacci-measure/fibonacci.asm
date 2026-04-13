; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .rodata

    prompt db "Introduce N: ", 0
    scanf_format db "%lu", 0
    result_iterative_msg db "Iterative cycles: %lu", 10, 0
    result_recursive_msg db "Recursive cycles: %lu", 10, 0


section .text

extern printf
extern scanf
global main


fibonacci_recursive:
    cmp rdi, 2
    jge .continue

    ; If N is 0 or 1, return 1.
    mov rax, 1
    jmp .out

.continue:
    ; If N >= 2, compute fibonacci(N-1) + fibonacci(N-2).

    ; fibonacci(N-1): Save rdi value and result on stack.
    dec rdi
    push rdi
    call fibonacci_recursive
    pop rdi

    ; Save result.
    push rax

    ; fibonacci(N-2)
    dec rdi
    call fibonacci_recursive

    ; Add two results together
    pop rdx
    add rax, rdx

.out:
    ret


fibonacci_iterative:
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
    ; - start_time (unsigned long, 8 bytes): address is [rbp-24].
    ; - end_time (unsigned long, 8 bytes): address is [rbp-32].
    sub rsp, 32

    ; Print prompt.
    lea rdi, [prompt]
    xor rax, rax            ; no vector register arguments
    call printf

    ; Read N using scanf.
    lea rdi, [scanf_format]
    lea rsi, [rbp-16]
    xor rax, rax            ; no vector register arguments
    call scanf

    ; Serialize and read TSC before.
    cpuid                   ; Serialize execution.
    rdtsc                   ; Read timestamp counter.
    shl rdx, 32
    or rax, rdx             ; Combine into 64-bit value.
    mov [rbp-24], rax

    ; Call fibonaci_iterative(N).
    mov rdi, [rbp-16]
    call fibonacci_iterative

    ; Read TSC after.
    rdtsc
    shl rdx, 32
    or rax, rdx
    mov [rbp-32], rax

    ; Calculate difference.
    mov rax, [rbp-32]
    sub rax, [rbp-24]

    ; Print result.
    mov rdi, result_iterative_msg
    mov rsi, rax
    xor rax, rax            ; no vector register arguments
    call printf

    ; Serialize and read TSC before.
    cpuid                   ; Serialize execution.
    rdtsc                   ; Read timestamp counter.
    shl rdx, 32
    or rax, rdx             ; Combine into 64-bit value.
    mov [rbp-24], rax

    ; Call fibonaci_recursive(N).
    mov rdi, [rbp-16]
    call fibonacci_recursive

    ; Read TSC after.
    rdtsc
    shl rdx, 32
    or rax, rdx
    mov [rbp-32], rax

    ; Calculate difference.
    mov rax, [rbp-32]
    sub rax, [rbp-24]

    ; Print result.
    mov rdi, result_recursive_msg
    mov rsi, rax
    xor rax, rax            ; no vector register arguments
    call printf

    leave
    ret
