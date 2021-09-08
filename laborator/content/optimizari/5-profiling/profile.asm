extern printf
global main

section .data
    str: db "Clock ticks: %llu", 10, 0

section .text
main:
    push ebp
    mov ebp, esp

    ; Number of cycles
    mov ecx, 1000 * 1000 * 1000

    ; TODO:
    ; 1. call rdtscp. Take into account what registers it changes
    ; 2. save the values from 'edx' and 'eax' to other registers
    ; 3. implement a simple loop using 'loop', then using a jump instruction
    ; 4. call rdtscp again
    ; 5. subtract from 'eax' the former value of 'eax', then from 'edx' the
    ; former value of 'edx'. HINT: use 'sbb' to account for an underflow
    ; in 'eax'
    ;
    ; NOTE: we only care about the difference between 'loop' and the jump
    ; The instruction(s) in the loop do not have to perform anything useful

    push edx
    push eax
    push str
    call printf
    add esp, 12

    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
