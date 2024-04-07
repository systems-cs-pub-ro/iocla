%include "printf32.asm"

section .text
    global main
    extern printf

main:
    mov eax, 7       ; vrem sa aflam al N-lea numar; N = 7
    mov ecx, 2
    mov ebx, 0 ; ebx retine valoarea lui f(i-2)
    mov edx, 1 ; edx retine valoarea lui f(i-1)
    ; TODO: calculati al N-lea numar fibonacci (f(0) = 0, f(1) = 1)

begin:
   cmp eax, 1
   je print
   add ebx, edx
   xchg ebx,edx
   dec eax
   jmp begin
print:
   PRINTF32 `%u\n\x0`, edx
ret
