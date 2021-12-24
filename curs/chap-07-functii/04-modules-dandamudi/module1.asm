;Multimodule program for string length   MODULE1.ASM
;
;        Objective: To show parameter passing via registers.
;            Input: Requests two integers from keyboard.
;           Output: Outputs the sum of the input integers.

BUF_SIZE  EQU  41   ; string buffer size
%include "io.mac"

.DATA
prompt_msg   db   "Please input a string: ",0
length_msg   db   "String length is: ",0

.UDATA
string1      resb   BUF_SIZE

.CODE
extern   string_length
      .STARTUP
      PutStr  prompt_msg        ; request a string
      GetStr  string1,BUF_SIZE  ; read string input

      mov     EBX,string1    ; EBX = string pointer
      call    string_length  ; returns string length in AX
      PutStr  length_msg     ; display string length
      PutInt  AX
      nwln
done:
      .EXIT
