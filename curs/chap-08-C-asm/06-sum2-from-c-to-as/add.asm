; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .text

global add


; long add(long a, long b)
; Returns a + b.
; 1st argument (a) is in rdi.
; 2nd argument (b) is in rsi.
; Return value is in rax.
add:
    mov rax, rdi
    add rax, rsi
    ret
