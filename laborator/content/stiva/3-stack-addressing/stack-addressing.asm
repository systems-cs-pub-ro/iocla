%include "../utils/printf32.asm"

%define NUM 5
   
section .text

extern printf
global main
main:
    mov ebp, esp

    ; TODO 1: replace every push by an equivalent sequence of commands (use direct addressing of memory. Hint: esp)
    mov ecx, NUM

push_nums:
    ; push ecx
    sub esp, 4
    mov dword [esp], ecx
    loop push_nums

    ; push 0
    sub esp, 4
    mov dword [esp], 0

    ; push "mere"
    sub esp, 4
    mov dword [esp], "mere"

    ;push "are "
    sub esp, 4
    mov dword [esp], "are "

    ; push "Ana "
    sub esp, 4
    mov dword [esp], "Ana "

    lea esi, [esp]
    PRINTF32 `%s\n\x0`, esi

    ; TODO 2: print the stack in "address: value" format in the range of [ESP:EBP]
    ; use PRINTF32 macro - see format above

    mov eax, esp
    mov ecx, ebp
    sub ecx, esp

print_stack:

    PRINTF32 `%x \x0`, eax
    PRINTF32 `%hhd\n\x0`, [eax]
    inc eax
    loop print_stack

    ; TODO 3: print the string

    lea esi, [esp]
    
    PRINTF32 `%s\n\x0`, esp

    ; TODO 4: print the array on the stack, element by element.

    mov ecx, NUM

    mov eax, NUM
    xor edx, edx
    mov esi, 4
    mul esi
    mov esi, ebp
    sub esi, eax
    mov eax, esi

print_nums:
    PRINTF32 `%d \x0`, dword [eax]
    add eax, 4
    loop print_nums

    PRINTF32 `\n\x0`

    ; restore the previous value of the EBP (Base Pointer)
    mov esp, ebp

    ; exit without errors
    xor eax, eax
    ret
