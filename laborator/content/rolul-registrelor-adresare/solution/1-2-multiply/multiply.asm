%include "../utils/printf32.asm"

; https://en.wikibooks.org/wiki/X86_Assembly/Arithmetic

section .data
    num1 db 43
    num2 db 39
    num1_w dw 1349
    num2_w dw 9949
    num1_d dd 134932
    num2_d dd 994912
    print_mesaj dd 'Rezultatul este: 0x', 0

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    ; Multiplication for db
    mov al, byte [num1]
    mov bl, byte [num2]
    mul bl

    ; Print result in hexa
    PRINTF32 `%s\x0`, print_mesaj
    xor ebx, ebx
    mov bx, ax
    PRINTF32 `%hx\n\x0`, eax


    ; Multiplication for dw
    mov ax, word [num1_w]
    mov bx, word [num2_w]
    mul bx

    ; Print result in hexa
    PRINTF32 `%s\x0`, print_mesaj
    xor ebx, ebx
    mov bx, dx
    PRINTF32 `%hx\x0`, edx
    xor ebx, ebx
    mov bx, ax
    PRINTF32 `%hx\n\x0`, eax


    ; Multiplication for dd
    mov eax, dword [num1_d]
    mov ebx, dword [num2_d]
    mul ebx

    ; Print result in hexa
    PRINTF32 `%s\x0`, print_mesaj
    PRINTF32 `%x\x0`, edx
    PRINTF32 `%x\n\x0`, eax

    leave
    ret
