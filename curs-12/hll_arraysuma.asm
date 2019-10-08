;-----------------------------------------------------------
; This procedure receives an array pointer and its size via
; the stack. It computes the array sum and returns it.
;-----------------------------------------------------------
segment .text
	
global  array_sum

array_sum:
      enter   0,0
      mov     EDX,[EBP+8]    ; copy array pointer to EDX
      mov     ECX,[EBP+12]   ; copy array size to ECX
      sub     EBX,EBX        ; array index = 0
      sub     EAX,EAX        ; sum = 0 (EAX keeps the sum)
add_loop:
      add     EAX,[EDX+EBX*4]
      inc     EBX            ; increment array index
      cmp     EBX,ECX
      jl      add_loop
      leave	
      ret