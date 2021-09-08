extern puts

section .rodata

    hi_str db "Hi!", 0
    bye_str db "Bye!", 0

section .text

hi:
    push ebp
    mov ebp, esp

    push hi_str
    call puts

    leave
    ret

bye:
    push ebp
    mov ebp, esp

    push bye_str
    call puts

    leave
    ret

main:
    push ebp
    mov ebp, esp

    call hi
    call bye

    leave
    ret
