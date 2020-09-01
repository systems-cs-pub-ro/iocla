global computeLength
global computeLength2

section .text
computeLength:
    push ebp
    mov ebp, esp

    xor eax, eax
    ;TODO: Implement byte count using a software loop

    mov esp, ebp
    pop ebp
    ret

computeLength2:
    push ebp
    mov ebp, esp

    xor eax, eax
    ;TODO: Implement byte count using a hardware loop

    mov esp, ebp
    pop ebp
    ret
