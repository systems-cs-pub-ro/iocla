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
    or eax, ebx
    PRINTF32 `Reuniunea este: \x0`
    PRINTF32 `%u\n\x0`, eax
    mov eax, 139             ; pentru a reveni la valoarea initiala a primei multimi

    ; TODO2: adaugarea unui element in multime
    or eax, 768
    PRINTF32 `Au fost adaugat elementele 8 si 9 la prima multime: \x0`
    PRINTF32 `%u\n\x0`, eax

    ; TODO3: intersectia a doua multimi
    and eax, ebx
    PRINTF32 `Intersectia este: \x0`
    PRINTF32 `%u\n\x0`, eax
    mov eax, 907             ; pentru a reveni la valoarea primei multimi (dupa adaugarea celor doua elemente)

    ; TODO4: complementul unei multimi
    not eax
    PRINTF32 `Elementele care lipsesc din prima multime: \x0`
    PRINTF32 `%u\n\x0`, eax
    mov eax, 907             ; pentru a reveni la valoarea primei multimi

    ; TODO5: eliminarea unui element
    mov ecx, 8
    not ecx
    and eax, ecx
    PRINTF32 `A fost eliminat elementul 3 din prima multime: \x0`
    PRINTF32 `%u\n\x0`, eax
    mov eax, 907

    ; TODO6: diferenta de multimi EAX-EBX
    PRINTF32 `%u\n\x0`, ebx
    not ebx
    and eax, ebx
    PRINTF32 `Diferenta dintre cele doua multimi: \x0`
    PRINTF32 `%u\n\x0`, eax
    ret
