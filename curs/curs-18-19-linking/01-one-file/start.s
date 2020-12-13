    .text

.globl _start

# /usr/include/x86_64-linux-gnu/asm/unistd_32.h
.equ __NR_exit, 1

_start:
    call main

    # Call __NR_exit(main_return_value) (system call).
    #
    # Use x86 Linux system call convention.
    # https://en.wikibooks.org/wiki/X86_Assembly/Interfacing_with_Linux#Making_a_system_call
    #
    # ebx stores the first system call argument.
    # eax stores the system call id.

    # eax is main return value. Store it in ebx.
    movl %eax, %ebx

    # Store the exit system call id in rax.
    movl $__NR_exit, %eax

    # Do system call.
    int $0x80
