section .text
    global i_vector_op
    global i_vector_op_avx

i_vector_op:
    push rbp
    mov rbp, rsp

    ; I'll use rdx below, so I copy its value in r9
    ; Also, loop changes the value of rcx, so I make a copy in r10
    mov r9, rdx
    mov r10, rcx

; I square each element of A and place the result in C
square_loop:
    mov eax, [rdi + 4 * rcx - 4]
    mov edx, eax
    mul edx
    mov [r9 + 4 * rcx - 4], eax
    loop square_loop

    mov rcx, r10

; I multiply each element of B with 2, and add it to C
x2_loop:
    mov eax, [rsi + 4 * rcx - 4]
    mov edx, 2
    mul edx
    add [r9 + 4 * rcx - 4], eax
    loop x2_loop

    leave
    ret

i_vector_op_avx:
    ; Optimize the code above
    ret