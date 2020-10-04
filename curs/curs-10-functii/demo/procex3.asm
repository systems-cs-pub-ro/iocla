;Parameter passing via the stack      PROCEX3.ASM
;
;        Objective: To show parameter passing via the stack.
;            Input: Requests two integers from the user.
;           Output: Outputs the sum of the input integers.
%include "io.mac"

SECTION .data
prompt_msg1  db   "Please input the first number: ",0
prompt_msg2  db   "Please input the second number: ",0
sum_msg      db   "The sum is ",0

.CODE
SECTION	.text
  global _start				;	.STARTUP
_start:
	nop
      PutStr  prompt_msg1    ; request first number
      GetInt  CX             ; CX = first number
 
      PutStr  prompt_msg2    ; request second number
      GetInt  DX             ; DX = second number
 
      push    CX             ; place first number on stack
      push    DX             ; place second number on stack
      call    sum            ; returns sum in AX
      PutStr  sum_msg        ; display sum
      PutInt  AX
      nwln
done:
      .EXIT

;-----------------------------------------------------------
;Procedure sum receives two integers via the stack.
; The sum of the two integers is returned in AX.
;-----------------------------------------------------------
sum:
      enter   0,0            ; save EBP
      mov     AX,[EBP+10]    ; sum = first number
      add     AX,[EBP+8]     ; sum = sum + second number
      leave                  ; restore EBP
      ret     4              ; return and clear parameters
