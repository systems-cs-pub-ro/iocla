%include "printf32.asm"

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
    mov ecx, eax
    or ecx, ebx
    PRINTF32 `%u\n\x0`, ecx ; afiseaza prima multime

    ; TODO2: adaugarea unui element in multime
    mov ecx, eax
    or ecx, 0x0100
    PRINTF32 `%u\n\x0`, ecx ; afiseaza prima multime

    ; TODO3: intersectia a doua multimi
    mov ecx, eax
    and ecx, ebx
    PRINTF32 `%u\n\x0`, ecx ; afiseaza prima multime

    ; TODO4: complementul unei multimi
    mov ecx, eax
    not ecx
    PRINTF32 `%u\n\x0`, ecx ; afiseaza prima multime

    ; TODO5: eliminarea unui element
    mov ecx, eax
    sub ecx, 0x0100
    PRINTF32 `%u\n\x0`, ecx ; afiseaza prima multime

    ; TODO6: diferenta de multimi EAX-EBX
    mov ecx, ebx
    and ecx, eax
    xor edx, ecx
    PRINTF32 `%u\n\x0`, edx

    xor eax, eax
    ret
