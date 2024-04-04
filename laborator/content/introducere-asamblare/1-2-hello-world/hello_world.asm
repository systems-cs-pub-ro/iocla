%include "printf32.asm"

section .data
    myString: db "Hello, World!", 0
    goodbye_string: db "Goodbye, world!", 0

section .text
    global main
    extern printf

main:
    mov ecx, 6
    mov eax, 2
    mov ebx, 1
    cmp eax, ebx
    jg print
    jmp print_goodbye
    ret

print:
    PRINTF32 `%s\n\x0`, myString

for:
    cmp ecx, 1
    je endfor
    dec ecx
    PRINTF32 `%s\n\x0`, myString
    jmp for
endfor:

print_goodbye:
    PRINTF32 `%s\n\x0`, goodbye_string

    ret
