extern main

section .text

; /usr/include/x86_64-linux-gnu/asm/unistd_32.h
__NR_exit equ 1

global _start

_start:
    call main

    ; Call __NR_exit(main_return_value) (system call).
    ;
    ; Use x86 Linux system call convention.
    ; https://en.wikibooks.org/wiki/X86_Assembly/Interfacing_with_Linux#Making_a_system_call
    ;
    ; ebx stores the first system call argument.
    ; eax stores the system call id.

    ; eax is main return value. Store it in ebx.
    mov ebx, eax

    ; Store the exit system call id in rax.
    mov eax, __NR_exit

    ; Do system call.
    int 0x80
