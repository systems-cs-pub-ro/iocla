; SPDX-License-Identifier: BSD-3-Clause


section .rodata

      two dq 2.0
      four dq 4.0


section .text

global quad_roots


; int quad_roots(double a, double b, double c, double *root1, double *root2)
;   xmm0 = a, xmm1 = b, xmm2 = c
;   rdi = root1, rsi = root2
;   eax = 1 if real roots exist, 0 otherwise
quad_roots:
      ; discriminant = b * b - 4 * a * c
      ; Copy b from xmm1 to xmm3 so we keep input registers available.
      movapd xmm3, xmm1
      ; mulsd = scalar double multiply (low 64 bits): xmm3 = b * b.
      mulsd xmm3, xmm1

      ; Build 4*a*c in xmm4.
      movapd xmm4, xmm0
      mulsd xmm4, xmm2
      mulsd xmm4, [rel four]

      ; xmm3 now holds the discriminant delta.
      subsd xmm3, xmm4

      ; If discriminant < 0, there are no real roots.
      ; xorpd zeroes xmm4; this gives us 0.0 for the comparison.
      xorpd xmm4, xmm4
      ; ucomisd compares two scalar doubles and sets CPU flags for jb/jbe/jae.
      ucomisd xmm3, xmm4
      jb .no_real_roots

      ; sqrtsd computes sqrt(delta) in scalar double precision.
      sqrtsd xmm4, xmm3

      ; denominator = 2 * a
      movapd xmm5, xmm0
      mulsd xmm5, [rel two]

      ; base = -b
      ; Build -b as (0.0 - b) without touching the original b in xmm1.
      xorpd xmm6, xmm6
      subsd xmm6, xmm1

      ; root1 = (-b + sqrt(discriminant)) / (2 * a)
      movapd xmm7, xmm6
      addsd xmm7, xmm4
      divsd xmm7, xmm5
      ; movsd stores one scalar double to *root1.
      movsd [rdi], xmm7

      ; root2 = (-b - sqrt(discriminant)) / (2 * a)
      subsd xmm6, xmm4
      divsd xmm6, xmm5
      ; Pointers to outputs are in integer registers (rdi/rsi), data is in xmm regs.
      movsd [rsi], xmm6

      mov eax, 1
      ret

.no_real_roots:
      xor eax, eax
      ret