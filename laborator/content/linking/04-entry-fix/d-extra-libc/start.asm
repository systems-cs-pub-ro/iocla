extern __libc_csu_init
extern __libc_csu_fini
extern __libc_start_main
extern my_main

section .text

global _start
global _dl_relocate_static_pie

; Adapted from GNU Libc i386 start.S
;   https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/i386/start.S;hb=HEAD
_start:
    ; Align stack.
    xor ebp, ebp
    pop esi
    mov ecx, esp
    and esp, 0xfffffff0

    push eax
    push esp
    push edx

    push __libc_csu_fini
    push __libc_csu_init
    push ecx
    push esi
    push my_main
    call __libc_start_main

    hlt

_dl_relocate_static_pie:
    repz ret
