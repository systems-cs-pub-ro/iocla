;Fibonacci numbers (stack version)    PROCFIB2.ASM
;
;        Objective: To compute Fibonacci number using the stack
;                   for local variables.
;            Input: Requests a positive integer from the user.
;           Output: Outputs the largest Fibonacci number that
;                   is less than or equal to the input number.
%include "io.mac"

.DATA
prompt_msg   db  "Please input a positive number (>1): ",0
output_msg1  db  "The largest Fibonacci number less than "
             db  "or equal to ",0
output_msg2  db  " is ",0

.CODE
      .STARTUP
      PutStr   prompt_msg     ; request input number
      GetLInt  EDX            ; EDX = input number
      call     fibonacci
      PutStr   output_msg1    ; print Fibonacci number
      PutLInt  EDX
      PutStr   output_msg2
      PutLInt  EAX
      nwln
done:
      .EXIT

;-----------------------------------------------------------
;Procedure fibonacci receives an integer in EDX and computes
; the largest Fibonacci number that is less than the input
; number. The Fibonacci number is returned in EAX.
;-----------------------------------------------------------
%define FIB_LO  dword [EBP-4]
%define FIB_HI  dword [EBP-8]
fibonacci:
      enter   8,0            ; space for two local variables
      push    EBX
      ; FIB_LO maintains the smaller of the last two Fibonacci
      ;  numbers computed; FIB_HI maintains the larger one.
      mov     FIB_LO,1       ; initialize FIB_LO and FIB_HI to
      mov     FIB_HI,1       ;  first two Fibonacci numbers
fib_loop:
      mov     EAX,FIB_HI     ; compute next Fibonacci number
      mov     EBX,FIB_LO
      add     EBX,EAX
      mov     FIB_LO,EAX
      mov     FIB_HI,EBX
      cmp     EBX,EDX        ; compare with input number in EDX
      jle     fib_loop       ; if not greater, find next number
      ; EAX contains the required Fibonacci number
      pop     EBX
      leave                  ; clears local variable space
      ret


