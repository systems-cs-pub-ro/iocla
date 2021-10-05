	;; adaptat cu macrourile SASM - ușor diferite !
	
;Sample indirect jump example    IJUMP.ASM
;
;        Objective: To demonstrate the use of indirect jump.
;            Input: Requests a digit character from the user.
;           Output: Appropriate class selection message.
%include "io.inc"

section .data
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
key         db 0

section .text
global main
main:
    mov ebp, esp; for correct debugging         
read_again:
        PRINT_STRING   prompt_msg    ; request a digit
        sub      EAX,EAX       ; EAX = 0
        GET_CHAR key
        mov      AL, [key]            ; read input digit and
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
        PRINT_STRING   msg_0
        NEWLINE
        jmp      test_termination
code_for_1:
        PRINT_STRING   msg_1
        NEWLINE
        jmp      test_termination
code_for_2:
        PRINT_STRING   msg_2
        NEWLINE
        jmp      test_termination
default_code:
        PRINT_STRING   msg_default
        NEWLINE
        jmp      test_termination

not_digit:
        PRINT_STRING   msg_nodigit
        NEWLINE
        jmp      read_again
done:
	mov 	eax, 1   	
	mov 	ebx, 0
	int     0x80		; exit(0)
        
