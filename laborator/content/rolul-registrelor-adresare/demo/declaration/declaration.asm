%include "../../utils/printf32.asm"

%define ARRAY_SIZE 13
%define DECIMAL_PLACES 5

; http://www.tortall.net/projects/yasm/manual/html/nasm-pseudop.html
; db = define byte - 1 byte
; dw = define word - 2 bytes
; dd = define double word - 4 bytes
; dq = define quad word - 8 bytes
; resb = reserve byte
; resw = reserve word
; resd = reserve double word

section .bss
    var1        resd 1   ; Declare an uninitialized double word (4 bytes)
    var3        DB ?     ; Declare an uninitialized byte
    var4        DW ?     ; Declare an uninitialized word (2 bytes)

section .data

    num_array       dw 76, 12, 65, 19, 781, 671, 431, 761, 782, 12, 91, 25, 9
    decimal_point   db ".",0
    var             db 64       ; Declare a byte with value 64
                    db 10       ; Declare a byte with value 10.
                                ; This byte can be found at address (var + 1)
    Y               dd 3000     ; Declare a double word (4 bytes)
    Z               dd 1, 2, 3  ; Declare a double word array
    var5            equ 2
    my_array        times 3 db 8, 9, 10

section .text

extern printf
global main
main:
    push ebp
    mov ebp, esp

    xor eax, eax
    mov ecx, ARRAY_SIZE

    mov al, [var]

    PRINTF32 `var: %d\n\x0`, eax

    leave
    ret

