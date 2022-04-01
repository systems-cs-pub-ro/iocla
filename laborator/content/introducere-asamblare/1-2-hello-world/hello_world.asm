%include "printf32.asm"

section .data
    myString: db "Hello, World!", 0
    Pa: db "Goodbye, World!", 0

section .text
    global main
    extern printf

main:
    mov ecx, 6                      ; N = valoarea registrului ecx
    jmp while_
    mov eax, 5
    mov ebx, 1
    cmp eax, ebx
    jg print                        ; TODO1: eax > ebx?
    ret

while_:
    dec ecx
    jz end_while
    PRINTF32 `%s\n\x0`, myString
    jmp while_
end_while:

print:
    PRINTF32 `%s\n\x0`, Pa
                                    ; TODO2.2: afisati "Hello, World!" de N ori
                                    ; TODO2.1: afisati "Goodbye, World!"

    ret
