%include "printf32.asm"

section .text

; esp -> stack pointer
; ebp -> base pointer

extern printf
global main
main:
    push ebp
    mov ebp, esp

    push dword 10 ; sub esp, 4;  mov [esp], 10;
    push dword 11 ; sub esp, 4;  mov [esp], 11;
    push dword 12 ; sub esp, 4;  mov [esp], 12;
    push dword 13 ; sub esp, 4;  mov [esp], 13;
    push dword 14 ; sub esp, 4;  mov [esp], 13;


    pusha  ; push all registers on the stack
    popa  ; pop all registers from the stack

    ; Version 1
    pop eax; ; mov eax, [esp]; add esp, 4
    pop eax; ; mov eax, [esp]; add esp, 4
    pop eax; ; mov eax, [esp]; add esp, 4
    pop eax; ; mov eax, [esp]; add esp, 4
    pop eax; ; mov eax, [esp]; add esp, 4

    ; Version 2
    ; add esp, 20 ; 4 * number_of_push

    ; Version 3
    ; mov esp, ebp

    ; sub esp <-> add esp -> use to allocate/deallocate memory

    ; Aloc 8 bytes <-> 2 int
    ; sub esp, 8
    ; mov [esp], 10
    ; mov [esp + 4], 12

    leave
    ret
