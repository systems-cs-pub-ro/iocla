section .text

global sum

sum:
    push rbp
    mov rbp, rsp

    ; rdi <- last number, passed as argument
    mov ecx, edi
    ; eax is sum
    xor eax, eax
again:
    add eax, ecx
    loop again

    leave
    ret
