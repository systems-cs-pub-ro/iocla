;Factorial - Recursive version            FACT_PENTIUM.ASM
;
;        Objective: To demonstrate principles of recursion.
;            Input: Requests an integer N from the user.
;           Output: Outputs N!                  

%include "io.mac"

.DATA
prompt_msg  db  "Please enter a positive integer: ",0
output_msg  db  "The factorial is: ",0
error_msg   db  "Sorry! Not a positive number. Try again.",0

.CODE
      .STARTUP
      PutStr  prompt_msg     ; request the number

try_again:
      GetInt  BX             ; read number into BX
      cmp     BX,0           ; test for positive number
      jge     num_ok
      PutStr  error_msg
      nwln
      jmp     try_again

num_ok:
      call    fact

      PutStr  output_msg     ; output result
      PutInt  AX
      nwln

done:
      .EXIT

;------------------------------------------------------------
;Procedure fact receives a positive integer N in BX register.
;It returns N! in AX register.
;------------------------------------------------------------
.CODE
fact:
      cmp     BL,1           ; if N > 1, recurse
      jg      one_up
      mov     AX,1           ; return 1 for N < 2
      ret                    ; terminate recursion
                      
one_up:
      dec     BL             ; recurse with (N-1)
      call    fact
      inc     BL
      mul     BL             ; AX = AL * BL

      ret  
