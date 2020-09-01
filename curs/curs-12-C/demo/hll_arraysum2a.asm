;-----------------------------------------------------------
; This procedure receives an array pointer and its size 
; via the stack. It first reads the array input from the 
; user and then computes the array sum. 
; The sum is returned to the C program.
;-----------------------------------------------------------
segment .data
scan_format    db   "%d",0
printf_format  db   "Input %d array values:",10,13,0

segment .text
	
global  array_sum
extern  printf,scanf	

array_sum:
      enter   0,0
      mov     ECX,[EBP+12]   ; copy array size to ECX
      push    ECX            ; push array size
      push    dword printf_format
      call    printf
      add     ESP,8          ; clear the stack 

      mov     EDX,[EBP+8]    ; copy array pointer to EDX
      mov     ECX,[EBP+12]   ; copy array size to ECX
read_loop:
      push    ECX            ; save loop count
      push    EDX            ; push array pointer
      push    dword scan_format
      call    scanf
      add     ESP,4          ; clear stack of one argument
      pop     EDX            ; restore array pointer in EDX
      pop     ECX            ; restore loop count
      add     EDX,4          ; update array pointer
      dec     ECX
      jnz     read_loop

      mov     EDX,[EBP+8]    ; copy array pointer to EDX
      mov     ECX,[EBP+12]   ; copy array size to ECX
      sub     EAX,EAX        ; EAX = 0 (EAX keeps the sum)
add_loop:
      add     EAX,[EDX]
      add     EDX,4          ; update array pointer
      dec     ECX
      jnz     add_loop
      leave	
      ret