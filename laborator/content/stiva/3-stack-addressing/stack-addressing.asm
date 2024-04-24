%include "printf32.asm"

%define NUM 5
   
section .text

extern printf
global main
main:
    mov ebp, esp

    ; TODO 1: replace every push by an equivalent sequence of commands (use direct addressing of memory. Hint: esp)
    mov ecx, NUM
push_nums:
    sub esp, 4
    mov dword [esp], ecx
    loop push_nums
    
    sub esp, 4
    mov dword [esp], 0

    sub esp, 4
    mov dword [esp], "mere"
    sub esp, 4
    mov dword [esp], "are "
    sub esp, 4
    mov dword [esp], "Ana "

    lea esi, [esp]
    PRINTF32 `%s\n\x0`, esi

    ; TODO 2: print the stack in "address: value" format in the range of [ESP:EBP]
    ; use PRINTF32 macro - see format above

    mov ecx, esi
.loop:
    movzx ebx, byte [ecx] 
    PRINTF32 `address: %d\n\x0`, ebx
    inc ecx
    cmp ecx, ebp
    jb .loop    
    
    ; TODO 3: print the string

    lea ecx, [esi]
.loop2:
    movzx ebx, byte [ecx] 
    PRINTF32 `Char: %c\n\x0`, ebx
    inc ecx
    lea ebx, [esi + 12]
    cmp ecx, ebx
    jb .loop2

    ; TODO 4: print the array on the stack, element by element.

    lea ecx, [esi + 3 * 4]
.loop3:
    PRINTF32 `Number: %d\n\x0`, dword [ecx]
    add ecx, 4
    lea ebx, [esi + 8 * 4]
    cmp ecx, ebx
    jb .loop3
        
    ; restore the previous value of the EBP (Base Pointer)
    mov esp, ebp

    ; exit without errors
    xor eax, eax
    ret
