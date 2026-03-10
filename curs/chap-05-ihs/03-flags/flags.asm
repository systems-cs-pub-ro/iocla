section .text
    global main

main:
    push    rbp
    mov     rbp, rsp

    ; ZF = 1
    ; cmp rax, rax
    ; xor rax, rax
    sub rax, rax

    ; ZF = 0
    inc rax

    ; CF = 1
    shr rax, 1

    ; CF = 0
    shr rax, 1

    ; SF = 1
    dec rax ; rax <- 0xffffffffffffffff

    ; SF = 0
    inc rax

    ; OF = 1

    ; OF = 0

    ; ZF = 1, CF = 1

    ; ZF = 0, CF = 0

    ; ZF = 0, CF = 1

    ; ZF = 1, CF = 0

    ; SF = 1, OF = 1

    ; SF = 0, OF = 0

    ; SF = 0, OF = 1
    mov rax, 0x8000000000000000   ; signed long = -2 ^ 63
    sub rax, 1

    ; SF = 1, OF = 0

    ; SF = 1, ZF = 1
    ; N/A

    ; SF = 0, ZF = 0

    mov rax, 1
    ; SF = 0, ZF = 1
    xor rax, rax
    ;shr rax, N
    ;dec rax
    ;sub rax, 1

    ; SF = 1, ZF = 0

    ; SF = 1, CF = 1

    mov rax, 1
    ; SF = 0, CF = 0
    shl rax, 1
    add rax, 1
    sub rax, 1
    xor rax, rax

    ; SF = 0, CF = 1

    ; SF = 1, CF = 0

    pop     rbp
    ret
