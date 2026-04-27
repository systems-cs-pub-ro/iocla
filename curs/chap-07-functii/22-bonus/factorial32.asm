; Iterative factorial example in NASM for x86 32-bit (cdecl calling convention)
; Uses an EBP frame in the factorial function (and in main).
; Reads an int via scanf, calls factorial(n), prints unsigned int via printf.

section .data
fmt_prompt:  db "n = ", 0
fmt_scan:    db "%d", 0
fmt_print:   db "%u", 10, 0    ; "%u\n\0"

section .text
global main
extern scanf
extern printf

; unsigned int factorial(unsigned int n)
; iterative implementation using EBP frame.
; Input: n on stack at [ebp+8]. Return: result in EAX.

factorial:
    push ebp
    mov ebp, esp
    ; No other callee-saved registers used, so no further pushes necessary.

    mov ecx, [ebp+8]    ; ecx = n (first argument on stack)
    cmp ecx, 1
    jbe .base_case

    mov eax, 1          ; result = 1
.loop:
    mul ecx             ; unsigned multiply: EDX:EAX = EAX * ECX -> result in EAX (low 32 bits)
    dec ecx
    cmp ecx, 1
    ja .loop
    jmp .done
.base_case:
    mov eax, 1
.done:
    pop ebp
    ret


; main:
; - read int n via scanf("%d", &n)
; - call factorial(n)
; - print result via printf("%u\n", result)

main:
    push ebp
    mov ebp, esp
    ; allocate 4 bytes for local variable n
    sub esp, 4

    ; printf("n = ")
    push fmt_prompt
    call printf
    add esp, 4          ; clean up stack (1 arg * 4 bytes)

    ; call scanf(fmt_scan, &n)
    lea eax, [ebp-4]    ; &n
    push eax            ; second arg: &n
    push fmt_scan       ; first arg: format string
    call scanf
    add esp, 8          ; clean up stack (2 args * 4 bytes)

    ; call factorial(n)
    mov eax, [ebp-4]    ; load n
    push eax            ; push argument
    call factorial
    add esp, 4          ; clean up stack (1 arg * 4 bytes)

    ; printf("%u\n", result)
    push eax            ; second arg: result (still in EAX)
    push fmt_print      ; first arg: format string
    call printf
    add esp, 8          ; clean up stack (2 args * 4 bytes)

    ; return 0
    mov eax, 0
    mov esp, ebp
    pop ebp
    ret
