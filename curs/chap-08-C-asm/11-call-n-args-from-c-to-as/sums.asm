; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .text

global sum2
global sum3
global sum4
global sum5
global sum6
global sum7
global sum8


; long sum2(long a, long b)
; Arguments: rdi=a, rsi=b
sum2:
    mov rax, rdi
    add rax, rsi
    ret

; long sum3(long a, long b, long c)
; Arguments: rdi=a, rsi=b, rdx=c
sum3:
    mov rax, rdi
    add rax, rsi
    add rax, rdx
    ret

; long sum4(long a, long b, long c, long d)
; Arguments: rdi=a, rsi=b, rdx=c, rcx=d
sum4:
    mov rax, rdi
    add rax, rsi
    add rax, rdx
    add rax, rcx
    ret

; long sum5(long a, long b, long c, long d, long e)
; Arguments: rdi=a, rsi=b, rdx=c, rcx=d, r8=e
sum5:
    mov rax, rdi
    add rax, rsi
    add rax, rdx
    add rax, rcx
    add rax, r8
    ret

; long sum6(long a, long b, long c, long d, long e, long f)
; Arguments: rdi=a, rsi=b, rdx=c, rcx=d, r8=e, r9=f
sum6:
    mov rax, rdi
    add rax, rsi
    add rax, rdx
    add rax, rcx
    add rax, r8
    add rax, r9
    ret

; long sum7(long a, long b, long c, long d, long e, long f, long g)
; Arguments: rdi=a, rsi=b, rdx=c, rcx=d, r8=e, r9=f, [rsp+8]=g
sum7:
    mov rax, rdi
    add rax, rsi
    add rax, rdx
    add rax, rcx
    add rax, r8
    add rax, r9
    add rax, [rsp+8]        ; 7th argument is on the stack
    ret

; long sum8(long a, long b, long c, long d, long e, long f, long g, long h)
; Arguments: rdi=a, rsi=b, rdx=c, rcx=d, r8=e, r9=f, [rsp+8]=g, [rsp+16]=h
sum8:
    mov rax, rdi
    add rax, rsi
    add rax, rdx
    add rax, rcx
    add rax, r8
    add rax, r9
    add rax, [rsp+8]        ; 7th argument is on the stack
    add rax, [rsp+16]       ; 8th argument is on the stack
    ret
