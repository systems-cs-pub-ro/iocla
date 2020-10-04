;-------------------------------------------------------------
; This procedure receives an array pointer and its size via
; the stack. It computes the array sum and returns it via ST0.
;-------------------------------------------------------------
segment .text
global  array_fsum

array_fsum:
      enter   0,0
      mov     EDX,[EBP+8]       ; copy array pointer to EDX
      mov     ECX,[EBP+12]      ; copy array size to ECX
      fldz                      ; ST0 = 0 (ST0 keeps the sum)
add_loop:
      jecxz   done
      dec     ECX               ; update array index
      fadd    qword[EDX+ECX*8]  ; ST0 = ST0 + arrary_element
      jmp     add_loop
done:
      leave	
      ret