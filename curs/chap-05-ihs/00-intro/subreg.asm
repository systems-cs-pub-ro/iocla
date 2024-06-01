section .text
    global main

main:
    mov eax, 1
    shl eax, 28
    mov al, 10
    mov ah, 10
    mov eax, 11
    ret

