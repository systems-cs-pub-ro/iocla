%include "printf32.asm"

section .data
    myString: db "Hello, World!", 0
    ourString: db "Goodbye, World!", 0

section .text
    global main
    extern printf

main:
    mov ecx, 10                      ; N = valoarea registrului ecx
    mov eax, 2
    mov ebx, 1
    cmp eax, ebx
    ja print                        ; TODO1: eax > ebx?
    ret

print:
    PRINTF32 `%s\n\x0`, myString
    PRINTF32 `%s\n\x0`, ourString

    cmp ecx,ebx
    je end
    add ebx, 1
    jmp print
                                    ; TODO2.2: afisati "Hello, World!" de N ori
                                    ; TODO2.1: afisati "Goodbye, World!
    ret

end:
    ret
