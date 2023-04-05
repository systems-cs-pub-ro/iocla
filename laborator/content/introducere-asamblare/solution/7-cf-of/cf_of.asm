%include "printf32.asm"

section .text
    global main
    extern printf

main:

    mov al, 0xDE
    PRINTF32 `CF si OF nu sunt active\n\x0`
    test al, al
    add al, 0x22
    jz cf_of_on
    jmp end

cf_of_on:
    PRINTF32 `CF si OF activ\n\x0`

end:
    ret

