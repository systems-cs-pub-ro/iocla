%include "../utils/printf32.asm"

; https://en.wikibooks.org/wiki/X86_Assembly/Arithmetic

section .data
    num1 db 2
    num2 db 3
    num1_w dw 1349
    num2_w dw 9949
    num1_d dd 134932
    num2_d dd 994912

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp
    mov eax, 0
    mov ebx, 0
    mov edx, 0

    ; Multiplication for db
    mov al, byte [num1]
    mov bl, byte [num2]
    mul bl

    ; Print result in hexa
    PRINTF32 `Rezultatul este: %d\n\x0`, eax

   ; TODO: Implement multiplication for dw and dd data types.
    mov ax, word[num1_w]
    mov dx, word[num2_w]
    mul dx

    PRINTF32 `Rezultatul este: 0x%d\n\x0`, eax

    mov eax, dword[num1_d]
    mov edx, dword[num2_d]
    mul edx

    PRINTF32 `Rezultatul este: 0x%d\n\x0`, eax

    leave
    ret
