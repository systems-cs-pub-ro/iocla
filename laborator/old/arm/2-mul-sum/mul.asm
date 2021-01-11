.global main
main:
    // prologue
    push {r11, lr}
    add r11, sp, #0

    // initialization
    mov r0, #10           // n
    and r1, r1, #0        // sum
    mov r2, #1            // current number

    // TODO Compute sum of squares; place result in r1


    // print result
    ldr r0, =output
    bl printf

    // epilogue
    sub sp, r11, #0
    pop {r11, pc}

.data
output:
  .asciz "%d\n"
