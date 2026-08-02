; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .text

global read_cycles


; uint64_t read_cycles(void)
; Returns the current CPU cycle count read via the rdtsc instruction.
; Result: high 32 bits in edx, low 32 bits in eax; combined into rax.
read_cycles:
    rdtsc                   ; edx:eax = current timestamp counter
    shl rdx, 32             ; shift high 32 bits to upper half of rdx
    or rax, rdx             ; combine into 64-bit value in rax
    ret
