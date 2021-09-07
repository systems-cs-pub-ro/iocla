.global main
main:
    // prologue
    push {r11, lr}
    add r11, sp, #0

    mov r0, #0
    mov r1, #2
    sub r3, r1, r0
    beq exit

    // print result
    ldr r0, =output
    bl printf

exit:
    // epilogue
    sub sp, r11, #0
    pop {r11, pc}

.data
output:
  .asciz "Nothing special here\n"

