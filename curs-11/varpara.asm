;Variable number of parameters passed via stack   VARPARA.ASM
;
;        Objective: To show how variable number of parameters 
;                   can be passed via the stack.
;            Input: Requests variable number of nonzero integers.
;                   A zero terminates the input.
;           Output: Outputs the sum of input numbers.

%define CRLF   0DH,0AH    ; carriage return and line feed
	
%include "io.mac"

.DATA
prompt_msg  db  "Please input a set of nonzero integers separated by <CR>",CRLF
            db  "You must enter at least one integer.",CRLF
            db  "Enter zero to terminate the input.",0
sum_msg     db  "The sum of the input numbers is: ",0

.CODE
      .STARTUP
      PutStr  prompt_msg     ; request input numbers
      nwln
      sub     ECX,ECX        ; ECX keeps number count
read_number:
      GetLInt EAX            ; read input number
      cmp     EAX,0          ; if the number is zero
      je      stop_reading   ; no more nuumbers to read
      push    EAX            ; place the number on stack
      inc     ECX            ; increment number count
      jmp     read_number
stop_reading:
      push    ECX            ; place number count on stack
      call    variable_sum   ; returns sum in EAX
      ; clear parameter space on the stack
      inc     ECX            ; increment ECX to include count
      add     ECX,ECX        ; ECX = ECX * 4 (space in bytes)
      add     ECX,ECX       
      add     ESP,ECX        ; update ESP to clear parameter 
                             ; space on the stack      
      PutStr  sum_msg        ; display the sum
      PutLInt EAX
      nwln
done:
      .EXIT

;------------------------------------------------------------
;This procedure receives variable number of integers via the
; stack. The last parameter pushed on the stack should be
; the number of integers to be added. Sum is returned in EAX.
;------------------------------------------------------------
variable_sum:
      enter   0,0
      push    EBX            ; save EBX and ECX
      push    ECX 
      
      mov     ECX,[EBP+8]    ; ECX = # of integers to be added
      mov     EBX,EBP
      add     EBX,12         ; EBX = pointer to first number
      sub     EAX,EAX        ; sum = 0
add_loop:
      add     EAX,[SS:EBX]   ; sum = sum + next number
      add     EBX,4          ; EBX points to the next integer
      loop    add_loop       ; repeat count in ECX

      pop     ECX            ; restore registers
      pop     EBX
      leave
      ret                    ; parameter space cleared by main
