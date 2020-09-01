;Sample indirect jump example    IJUMP.ASM
;
;        Objective: To demonstrate the use of indirect jump.
;            Input: Requests a digit character from the user.
;           Output: Appropriate class selection message.
%include "io.mac"

.DATA
jump_table  dd  code_for_0   ; indirect jump pointer table
            dd  code_for_1
            dd  code_for_2
            dd  default_code ; default code for digits 3-9
            dd  default_code
            dd  default_code
            dd  default_code
            dd  default_code
            dd  default_code
            dd  default_code

prompt_msg  db  "Type a digit: ",0
msg_0       db  "Economy class selected.",0
msg_1       db  "Business class selected.",0
msg_2       db  "First class selected.",0
msg_default db  "Not a valid code!",0
msg_nodigit db  "Not a digit! Try again.",0

.CODE
        .STARTUP
read_again:
        PutStr   prompt_msg    ; request a digit
        sub      EAX,EAX       ; EAX = 0
        GetCh    AL            ; read input digit and
        cmp      AL,'0'        ; check to see if it is a digit
        jb       not_digit
        cmp      AL,'9'
        ja       not_digit
        ; if digit, proceed
        sub      AL,'0'        ; convert to numeric equivalent
        mov      ESI,EAX       ; ESI is index into jump table
        add      ESI,ESI       ; ESI = ESI * 4
        add      ESI,ESI
        jmp      [jump_table+ESI] ; indirect jump based on ESI
test_termination:
        cmp      AL,2
        ja       done
        jmp      read_again 
code_for_0:
        PutStr   msg_0
        nwln
        jmp      test_termination
code_for_1:
        PutStr   msg_1
        nwln
        jmp      test_termination
code_for_2:
        PutStr   msg_2
        nwln
        jmp      test_termination
default_code:
        PutStr   msg_default
        nwln
        jmp      test_termination

not_digit:
        PutStr   msg_nodigit
        nwln
        jmp      read_again
done:
        .EXIT
