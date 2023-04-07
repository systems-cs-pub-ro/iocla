%include "printf32.asm"

section .text
    global main
    extern printf

main:
    mov al, 128
    PRINTF32 `CF si OF nu sunt active\n\x0`
    test al, al
    ;TODO: activati CF si OF

    jc cf_on
    jmp end

cf_on:
    jo cf_of_on
    jmp end

cf_of_on:
    PRINTF32 `CF si OF active\n\x0`

end:
    ret

