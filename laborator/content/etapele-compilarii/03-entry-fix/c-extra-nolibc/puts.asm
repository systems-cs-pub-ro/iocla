section .text

global puts

; /usr/include/x86_64-linux-gnu/asm/unistd_32.h
__NR_write equ 4

; Argument is message to be printed to standard output.
puts:
    push ebp
    mov ebp, esp

    ; Call __NR_write(1, message, message_len) (system call).
    ;
    ; Use x86 Linux system call convention.
    ; https://en.wikibooks.org/wiki/X86_Assembly/Interfacing_with_Linux#Making_a_system_call
    ;
    ; eax stores the system call id.
    ; ebx stores the first system call argument: 1 (standard output).
    ; ecx stores the second system call argument: message.
    ; edc stores the third system call argument: message length.

    ; Store the write system call id in eax.
    mov eax, __NR_write

    ; Store standard output file descriptor (1) in ebx.
    mov ebx, 1

    ; Store function argument (message) in ecx.
    mov ecx, [ebp+8]

    ; Compute message length in edx.
    ; Find NUL byte address of message using edi. Start from message address (ecx).
    ; Then edx <- edi - ecx.
    mov edi, ecx
    dec edi
again:
    inc edi
    cmp byte [edi], 0
    jne again

    mov edx, edi
    sub edx, ecx

    ; Do system call.
    int 0x80

    leave
    ret
