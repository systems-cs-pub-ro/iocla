;-----------------------------------------------------------
; This procedure receives three integers via the stack.
; It adds the first two arguments and subtracts the third one.
; It is called from the C program.
;-----------------------------------------------------------
segment .text
	
global  test1
	
test1:
      enter   0,0
      mov     EAX,[EBP+8]        ;  get argument1 (x)
      add     EAX,[EBP+12]       ;  add argument 2 (y)
      sub     EAX,[EBP+16]       ;  subtract argument3 (5)
      leave	
      ret