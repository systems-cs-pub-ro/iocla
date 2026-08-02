; SPDX-License-Identifier: BSD-3-Clause


section .text

global array_fsum


; double array_fsum(double *value, int size)
;   rdi = value
;   esi = size
;   xmm0 = return value
array_fsum:
      ; xorpd is a fast idiom to set xmm0 to +0.0.
      ; We accumulate in xmm0 because FP return values use xmm0 in SysV ABI.
      xorpd xmm0, xmm0
      xor eax, eax

.add_loop:
      cmp eax, esi
      jge .done

      ; addsd performs scalar double-precision add: sum += value[i].
      ; We use SSE scalar ops (xmm) instead of x87 stack math for modern x64 code.
      addsd xmm0, [rdi + rax * 8]
      inc eax
      jmp .add_loop

.done:
      ret