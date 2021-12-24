extern printf
extern atoi

section .rodata

    fmt_str: db "Sum is: %u", 10, 0
    argv_fmt_str: db "argv[1]: %s", 10, 0

section .text

global main


sum:
    push ebp
    mov ebp, esp

    ; ecx <- last number, passed as argument
    mov ecx, [ebp+8]
    ; eax is sum
    xor eax, eax
again:
    add eax, ecx
    loop again

    leave
    ret


main:
    push ebp
    mov ebp, esp

    ; Check number of arguments (argc == 2).
    cmp dword [ebp+8], 2
    je ok

    ; Wrong number of arguments
    mov eax, 1
    jmp exit

ok:

    ; sum(argv[1]);
    ; ebx -> argv (char **)
    mov ebx, [ebp+12]
    ; ebx -> argv[1] (char *)
    mov ebx, [ebx+4]

    push ebx
    push argv_fmt_str
    call printf
    add esp, 8

    ; eax <- atoi(argv[1]) (int <- char *)
    push ebx
    call atoi
    add esp, 4

    ; eax is now an integer representation of argv[1]
    push eax
    call sum
    add esp, 4

    ; printf("Sum is: %u\n", sum);
    push eax
    push fmt_str
    call printf
    add esp, 8

    mov eax, 0

exit:
    leave
    ret
