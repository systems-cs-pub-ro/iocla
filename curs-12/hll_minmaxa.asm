;-------------------------------------------------------------
; Assembly program for the min_max function - called from the
; C program in the file hll_minmaxc.c. This function finds 
; the minimum and maximum of the three integers it receives.
;-------------------------------------------------------------
global  min_max

min_max:	
      enter   0,0
      ; EAX keeps minimum number and EDX maximum
      mov     EAX,[EBP+8]     ; get value 1
      mov     EDX,[EBP+12]    ; get value 2
      cmp     EAX,EDX         ; value 1 < value 2?
      jl      skip1           ; if so, do nothing
      xchg    EAX,EDX         ; else, exchange 
skip1:
      mov     ECX,[EBP+16]    ; get value 3
      cmp     ECX,EAX         ; value 3 < min in EAX?
      jl      new_min
      cmp     ECX,EDX         ; value 3 < max in EDX?
      jl      store_result
      mov     EDX,ECX
      jmp     store_result
new_min:
      mov     EAX,ECX
store_result:
      mov     EBX,[EBP+20]    ; EBX = &minimum
      mov     [EBX],EAX
      mov     EBX,[EBP+24]    ; EBX = &maximum
      mov     [EBX],EDX
      leave
      ret
