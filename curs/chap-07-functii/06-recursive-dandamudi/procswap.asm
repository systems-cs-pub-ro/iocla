;Parameter passing via the stack      PROCSWAP.ASM
;
;        Objective: To show parameter passing via the stack.
;            Input: Requests a character string from the user.
;           Output: Outputs the input string with the first
;                   two characters swapped.

BUF_LEN     EQU  41          ; string buffer length
%include "io.mac"

.DATA
prompt_msg  db    "Please input a string: ",0
output_msg  db    "The swapped string is: ",0

.UDATA
string      resb  BUF_LEN      ;input string < BUF_LEN chars.

.CODE
      .STARTUP
      PutStr  prompt_msg     ; request string input
      GetStr  string,BUF_LEN ; read string from the user

      mov     EAX,string     ; EAX = string[0] pointer
      push    EAX            
      inc     EAX            ; EAX = string[1] pointer
      push    EAX            
      call    swap           ; swaps the first two characters
      PutStr  output_msg     ; display the swapped string
      PutStr  string
      nwln
done:
      .EXIT

;-----------------------------------------------------------
;Procedure swap receives two pointers (via the stack) to
; characters of a string. It exchanges these two characters.
;-----------------------------------------------------------
.CODE
swap:
      enter   0,0          
      push    EBX            ; save EBX - procedure uses EBX
      ; swap begins here. Because of xchg, AL is preserved.
      mov     EBX,[EBP+12]   ; EBX = first character pointer
      xchg    AL,[EBX]
      mov     EBX,[EBP+8]    ; EBX = second character pointer
      xchg    AL,[EBX]
      mov     EBX,[EBP+12]   ; EBX = first character pointer
      xchg    AL,[EBX]
      ; swap ends here
      pop     EBX            ; restore registers
      leave
      ret     8              ; return and clear parameters