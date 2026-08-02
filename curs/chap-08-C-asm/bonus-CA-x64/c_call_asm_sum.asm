section .text
global sum_array_asm

; int sum_array_asm(const int *arr, int n)
; arr -> RDI, n -> ESI, return -> EAX
sum_array_asm:
    xor eax, eax
    xor edx, edx

    test esi, esi
    jle .done

.loop:
    add eax, dword [rdi + rdx * 4]
    inc edx
    cmp edx, esi
    jl .loop

.done:
    ret
