section .text
    global main

main:
    push    ebp
    mov     ebp, esp

    ; ZF = 1
    ; cmp eax, eax
    ; xor eax, eax
    sub eax, eax

    ; ZF = 0
    inc eax

    ; CF = 1
    shr eax, 1

    ; CF = 0
    shr eax, 1

    ; SF = 1
    dec eax ; eax <- 0xffffffff

    ; SF = 0
    inc eax

    ; OF = 1

    ; OF = 0

    ; ZF = 1, CF = 1

    ; ZF = 0, CF = 0

    ; ZF = 0, CF = 1

    ; ZF = 1, CF = 0

    ; SF = 1, OF = 1

    ; SF = 0, OF = 0

    ; SF = 0, OF = 1
    mov eax, 0x80000000   ; signed int = -2 ^ 31
    sub eax, 1

    ; SF = 1, OF = 0

    ; SF = 1, ZF = 1
    ; N/A

    ; SF = 0, ZF = 0

    mov eax, 1
    ; SF = 0, ZF = 1
    xor eax, eax
    ;shr eax, N
    ;dec eax
    ;sub eax, 1

    ; SF = 1, ZF = 0

    ; SF = 1, CF = 1

    mov eax, 1
    ; SF = 0, CF = 0
    shl eax, 1
    add eax, 1
    sub eax, 1
    xor eax, eax

    ; SF = 0, CF = 1

    ; SF = 1, CF = 0

    pop     ebp
    ret
