; Iterative factorial example in NASM for x86_64 (System V AMD64)
; Uses a RBP frame in the factorial function (and in main).
; Reads an int via scanf, calls factorial(n), prints unsigned long long via printf.

section .data
fmt_prompt:  db "n = ", 0
fmt_scan:    db "%d", 0
fmt_print:   db "%llu", 10, 0    ; "%llu\n\0"

section .text
global main
extern scanf
extern printf

; unsigned long long factorial(unsigned long long n)
; iterative implementation using RBP frame.
; Input: n in RDI. Return: result in RAX.

factorial:
    push rbp
    mov rbp, rsp
    ; No other callee-saved registers used, so no further pushes necessary.

    mov rcx, rdi        ; counter = n
    cmp rcx, 1
    jbe .base_case

    mov rax, 1          ; result = 1
.loop:
    mul rcx             ; unsigned multiply: RDX:RAX = RAX * RCX -> result in RAX (low 64 bits)
    dec rcx
    cmp rcx, 1
    ja .loop
    jmp .done
.base_case:
    mov rax, 1
.done:
    mov rsp, rbp
    pop rbp
    ret


; main:
; - read int n via scanf("%d", &n)
; - call factorial(n)
; - print result via printf("%llu\n", result)

main:
    push rbp
    mov rbp, rsp
    ; allocate 16 bytes for local space (4-byte int + padding, maintains 16-byte alignment)
    sub rsp, 16

    ; printf("n = ")
    lea rdi, [rel fmt_prompt]
    ; xor eax, eax
    call printf

    ; call scanf(fmt_scan, &n)
    lea rsi, [rbp-4]           ; &n  (scanf second arg)
    lea rdi, [rel fmt_scan]    ; fmt string in RDI
    xor eax, eax               ; AL=0 for varargs (no SSE params used)
    call scanf

    ; move n (32-bit) into RDI (argument for factorial)
    mov eax, dword [rbp-4]
    mov edi, eax               ; move into 32-bit edi (zero-extends to 64-bit RDI)

    call factorial

    ; printf("%llu\n", result)
    mov rsi, rax               ; result -> second arg
    lea rdi, [rel fmt_print]   ; fmt -> first arg
    xor eax, eax               ; AL=0 for varargs
    call printf

    ; return 0
    mov eax, 0
    ; mov rsp, rbp
    ; pop rbp
    leave
    ret

