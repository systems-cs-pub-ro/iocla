; SPDX-License-Identifier: BSD-3-Clause
; diggers.asm — 64-bit x86-64 NASM exercise
;
; Implement three functions used by test.c.  Each function only does
; something useful when called with the *right* argument — students must
; figure out what that argument is.
;
; 64-bit System V AMD64 ABI calling convention (Linux):
;   Arguments  : RDI (1st), RSI (2nd), RDX (3rd), RCX (4th), R8 (5th), R9 (6th)
;   Return value: RAX
;   Caller-saved: RAX, RCX, RDX, RSI, RDI, R8-R11
;   Callee-saved: RBX, RBP, R12-R15
;   Stack must be 16-byte aligned before a CALL instruction.
;
; Functions to implement:
;   void          alpha(unsigned int a)  – prints "Eureka!" when a == 0x5397
;   unsigned int  beta (unsigned int b)  – returns 6699  when b == 144
;   void          omega(unsigned int c)  – prints "It has finally happened!"
;                                          when c == getppid()
;
; Compile:  nasm -f elf64 -g -Fdwarf -o diggers.o diggers.asm
; Link:     gcc -no-pie -fno-PIC test.o diggers.o -o test

global alpha, beta, omega

extern puts
extern getppid

section .rodata
    eureka_msg   db "Eureka!", 0
    happened_msg db "It has finally happened!", 0

section .text

; ─── alpha(unsigned int a) ────────────────────────────────────────────────────
; First argument arrives in EDI (lower 32 bits of RDI).
; Prints "Eureka!" only if a == 0x5397.
alpha:
    push    rbp
    mov     rbp, rsp
    ; sub rsp, 0  ; no locals needed

    cmp     edi, 0x5397         ; check magic value
    jne     .alpha_done

    lea     rdi, [rel eureka_msg]
    call    puts                ; puts("Eureka!")

.alpha_done:
    pop     rbp
    ret

; ─── beta(unsigned int b) ─────────────────────────────────────────────────────
; First argument arrives in EDI.
; Returns 6699 in EAX if b == 144, otherwise returns 0.
beta:
    push    rbp
    mov     rbp, rsp

    xor     eax, eax            ; default return value: 0
    cmp     edi, 144            ; check magic value
    jne     .beta_done

    mov     eax, 6699           ; return 6699

.beta_done:
    pop     rbp
    ret

; ─── omega(unsigned int c) ───────────────────────────────────────────────────
; First argument arrives in EDI.
; Prints "It has finally happened!" if c equals the parent process PID.
;
; getppid() is a system call that returns the parent PID in EAX.
; We save our argument on the stack before calling getppid() because
; the call is allowed to clobber RDI.
omega:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 16             ; reserve 16 bytes (maintain 16-byte alignment)

    mov     dword [rbp - 4], edi    ; save argument c on the stack

    call    getppid             ; EAX = parent PID

    cmp     eax, dword [rbp - 4]   ; compare parent PID with c
    jne     .omega_done

    lea     rdi, [rel happened_msg]
    call    puts                ; puts("It has finally happened!")

.omega_done:
    add     rsp, 16
    pop     rbp
    ret
