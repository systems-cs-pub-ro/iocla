;Parameter passing via registers      PROCEX2.ASM
;
;        Objective: To show parameter passing via registers.
;            Input: Requests a character string from the user.
;           Output: Outputs the length of the input string.

%include "io.mac"
BUF_LEN     EQU  41          ; string buffer length

.DATA
prompt_msg  db  "Please input a string: ",0
length_msg  db  "The string length is ",0

.UDATA
string      resb  BUF_LEN    ;input string < BUF_LEN chars.

.CODE
      .STARTUP
begin:
      PutStr  prompt_msg     ; request string input
      GetStr  string,BUF_LEN ; read string from keyboard
 
      mov     EBX,string     ; EBX = string address
      call    str_len        ; returns string length in AX
      PutStr  length_msg     ; display string length
      PutInt  AX
      nwln
done:
      .EXIT

;-----------------------------------------------------------
;Procedure str_len receives a pointer to a string in EBX.
;String length is returned in AX.
;-----------------------------------------------------------
str_len:
      push    EBX
      sub     AX,AX          ; string length = 0
repeat:
      cmp     byte [EBX],0   ; compare with NULL char.
      je      str_len_done   ; if NULL we are done
      inc     AX             ; else, increment string length
      inc     EBX            ; point EBX to the next char.
      jmp     repeat         ;  and repeat the process
str_len_done:
      pop     EBX
      ret
