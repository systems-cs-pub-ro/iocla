;Fibonacci numbers (register version)    PROCFIB1.ASM
;
;        Objective: To compute Fibonacci number using registers
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
      PutStr   output_msg1    ; display Fibonacci number
      PutLInt  EDX
      PutStr   output_msg2
      PutLInt  EAX
      nwln
done:
      .EXIT

;-----------------------------------------------------------
;Procedure fibonacci receives an integer in EDX and computes
; the largest Fibonacci number that is less than or equal to
; the input number. The Fibonacci number is returned in EAX.
;-----------------------------------------------------------
fibonacci:
      push    EBX
      ; EAX maintains the smaller of the last two Fibonacci
      ;  numbers computed; EBX maintains the larger one.
      mov     EAX,1           ; initialize EAX and EBX to
      mov     EBX,EAX         ;  first two Fibonacci numbers
fib_loop:
      add     EAX,EBX         ; compute next Fibonacci number
      xchg    EAX,EBX         ; maintain the required order
      cmp     EBX,EDX         ; compare with input number in EDX
      jle     fib_loop        ; if not greater, find next number
      ; EAX contains the required Fibonacci number
      pop     EBX
      ret
