section .text

global sum

sum:
    push ebp
    mov ebp, esp

    ; ecx <- last number, passed as argument
    mov ecx, [ebp+8]
    ; eax is sum
    xor eax, eax
again:
    add eax, ecx
    loop again

    leave
    ret
