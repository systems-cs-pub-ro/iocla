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
    mov dword[esp], ecx
    loop push_nums

    ; push 0
    ; push "mere"
    ; push "are "
    ; push "Ana "
    sub esp, 4
    mov dword[esp], 0
    sub esp, 4
    mov dword[esp], "mere"
    sub esp, 4
    mov dword[esp], "are "
    sub esp, 4
    mov dword[esp], "Ana "

    ; TODO 2: print the stack in "address: value" format in the range of [ESP:EBP]
    ; use PRINTF32 macro - see format above

    mov edx, esp
print_num:
    cmp edx, ebp
    je print_string
    PRINTF32 `%x:\x0`, edx
    PRINTF32 `%hhx\n\x0`, byte[edx]
    inc edx
    jmp print_num

print_string:
    ; TODO 3: print the string
    lea esi, [esp]
    PRINTF32 `%s\n\x0`, esi

    add esp, 16
    mov edx, esp

    ; TODO 4: print the array on the stack, element by element.
print_array:
    cmp edx, ebp
    je print_all
    PRINTF32 `%d \x0`, dword[edx]
    add edx, 4
    jmp print_array


print_all:


    ; restore the previous value of the EBP (Base Pointer)
    mov esp, ebp

    ; exit without errors
    xor eax, eax
    ret
