;Test routine for GetPut.asm      TEST_GETPUT.ASM
;
;        Objective: To test 8-bit integer input & output
;            Input: Requests an integer from the user.
;           Output: Outputs the input number.
%include "io.mac"

section .data
prompt_msg  db   "Please input a number (-128 to +127): ",0
output_msg  db   "The number is ",0


section .text	
;; .CODE			
EXTERN   GetInt8, PutInt8
	global _start
_start:	
	xor ax, ax
	PutStr  prompt_msg    
	call    GetInt8           

	PutStr  output_msg    
	call    PutInt8
	nwln
done:
	.EXIT
