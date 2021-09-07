.global main
main:
    // prologue
    push {r11, lr}
    add r11, sp, #0

    // pretty print
    ldr r0, =printlen
    bl printf

    // TODO 1: call strlen

    // TODO 1: call printf to print result of strlen

    // print occurences pretty string
    ldr r0, =printocr
    bl printf

    // TODO 3: call substr

    // epilogue
    sub sp, r11, #0
    pop {r11, pc}

// TODO 1: implement strlen
strlen:
    push {r11}
    add r11, sp, #0

    sub sp, r11, #0
    pop {r11}
    bx lr

// TODO 2: implement starts_with
starts_with:
    push {r11}
    add r11, sp, #0


    sub sp, r11, #0
    pop {r11}
    bx lr


// TODO 3: implement substr
substr:
    push {r4, r5, r6, r11, lr}
    add r11, sp, #0


    sub sp, r11, #0
    pop {r4, r5, r6, r11, pc}

.data
str:
  .asciz "This string is the bomb"
subs:
  .asciz "is"
output:
  .asciz "%d\n"
chr:
  .asciz "%c\n"
printlen:
  .asciz "String length is:\n"
printocr:
  .asciz "Substring appears at positions:\n"
