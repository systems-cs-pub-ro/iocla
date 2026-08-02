; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .rodata

    fmt2 db "sum2(1,2) = %ld", 10, 0
    fmt3 db "sum3(1,2,3) = %ld", 10, 0
    fmt4 db "sum4(1,2,3,4) = %ld", 10, 0
    fmt5 db "sum5(1,2,3,4,5) = %ld", 10, 0
    fmt6 db "sum6(1,2,3,4,5,6) = %ld", 10, 0
    fmt7 db "sum7(1,2,3,4,5,6,7) = %ld", 10, 0
    fmt8 db "sum8(1,2,3,4,5,6,7,8) = %ld", 10, 0


section .text

extern sum2
extern sum3
extern sum4
extern sum5
extern sum6
extern sum7
extern sum8
extern printf
global main


; Helper macro: print rax with given format string pointer in rbx.
%macro PRINT_RESULT 1
    lea rdi, [%1]
    mov rsi, rax
    xor rax, rax
    call printf
%endmacro


main:
    push rbp
    mov rbp, rsp

    ; Call sum2(1, 2).
    ; Arguments 1-6 go in rdi, rsi, rdx, rcx, r8, r9.
    mov rdi, 1
    mov rsi, 2
    call sum2
    PRINT_RESULT fmt2

    ; Call sum3(1, 2, 3).
    mov rdi, 1
    mov rsi, 2
    mov rdx, 3
    call sum3
    PRINT_RESULT fmt3

    ; Call sum4(1, 2, 3, 4).
    mov rdi, 1
    mov rsi, 2
    mov rdx, 3
    mov rcx, 4
    call sum4
    PRINT_RESULT fmt4

    ; Call sum5(1, 2, 3, 4, 5).
    mov rdi, 1
    mov rsi, 2
    mov rdx, 3
    mov rcx, 4
    mov r8, 5
    call sum5
    PRINT_RESULT fmt5

    ; Call sum6(1, 2, 3, 4, 5, 6).
    mov rdi, 1
    mov rsi, 2
    mov rdx, 3
    mov rcx, 4
    mov r8, 5
    mov r9, 6
    call sum6
    PRINT_RESULT fmt6

    ; Call sum7(1, 2, 3, 4, 5, 6, 7).
    ; The 7th argument goes on the stack (pushed before the call).
    push qword 7            ; 7th argument on the stack
    mov rdi, 1
    mov rsi, 2
    mov rdx, 3
    mov rcx, 4
    mov r8, 5
    mov r9, 6
    call sum7
    add rsp, 8              ; clean up the stack argument
    PRINT_RESULT fmt7

    ; Call sum8(1, 2, 3, 4, 5, 6, 7, 8).
    ; Arguments 7 and 8 go on the stack (pushed in reverse order).
    push qword 8            ; 8th argument
    push qword 7            ; 7th argument
    mov rdi, 1
    mov rsi, 2
    mov rdx, 3
    mov rcx, 4
    mov r8, 5
    mov r9, 6
    call sum8
    add rsp, 16             ; clean up two stack arguments
    PRINT_RESULT fmt8

    xor rax, rax            ; return 0
    leave
    ret
