%include "../io.mac"

section .text
    global main
    extern printf

main:
    ;cele doua multimi se gasesc in eax si ebx
    mov eax, 139
    mov ebx, 169
    PRINTF32 `%u\n\x0`, eax ; afiseaza prima multime
    PRINTF32 `%u\n\x0`, ebx ; afiseaza cea de-a doua multime

    ; TODO1: reuniunea a doua multimi


    ; TODO2: adaugarea unui element in multime


    ; TODO3: intersectia a doua multimi


    ; TODO4: complementul unei multimi


    ; TODO5: eliminarea unui element


    ; TODO6: diferenta de multimi EAX-EBX


    xor eax, eax
    ret
