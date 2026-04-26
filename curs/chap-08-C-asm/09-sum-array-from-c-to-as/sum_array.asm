; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .text

global sum_array


; unsigned long sum_array(unsigned long *a, size_t num_items)
; Returns the sum of num_items elements in the array at address a.
; 1st argument (a) is in rdi.
; 2nd argument (num_items) is in rsi.
; Return value is in rax.
sum_array:
    ; Initialize base register to array pointer.
    mov rbx, rdi

    ; Initialize counter to num_items.
    mov rcx, rsi

    ; Initialize accumulator to 0.
    xor rax, rax

    ; Sum all elements.
.again:
    add rax, [rbx + rcx*8 - 8]
    loopnz .again

    ret
