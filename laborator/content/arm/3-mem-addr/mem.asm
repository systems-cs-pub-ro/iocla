.global main
main:
    // prologue
    push {r11, lr}
    add r11, sp, #0

    ldr r5, =nums
    ldr r1, [r5]

    // print result
    ldr r0, =output
    bl printf

    // epilogue
    sub sp, r11, #0
    pop {r11, pc}

.data
nums:
  .byte 5, 2, -3, 7, 8

nums_size:
  .byte 5

output:
  .asciz "%d\n"
