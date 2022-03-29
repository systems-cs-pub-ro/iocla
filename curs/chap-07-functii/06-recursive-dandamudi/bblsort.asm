;Bubble sort procedure                      BBLSORT.ASM
;     Objective: To implement the bubble sort algorithm.
;         Input: A set of nonzero integers to be sorted.
;                Input is terminated by entering zero.
;        Output: Outputs the numbers in ascending order.

%define    CRLF  0DH,0AH
MAX_SIZE   EQU   20
%include "io.mac"
.DATA
prompt_msg  db  "Enter nonzero integers separated by <CR>.",CRLF
            db  "Enter zero to terminate the input.",0
output_msg  db  "Input numbers in ascending order:",0

.UDATA
array       resd  MAX_SIZE   ; input array for integers

.CODE
      .STARTUP
      PutStr  prompt_msg     ; request input numbers
      nwln
      mov     EBX,array      ; EBX = array pointer
      mov     ECX,MAX_SIZE   ; ECX = array size
      sub     EDX,EDX        ; number count = 0
read_loop:
      GetLInt EAX            ; read input number
      cmp     EAX,0          ; if the number is zero
      je      stop_reading   ; no more numbers to read
      mov     [EBX],EAX      ; copy the number into array
      add     EBX,4          ; EBX points to the next element
      inc     EDX            ; increment number count
      loop    read_loop      ; reads a max. of MAX_SIZE numbers
stop_reading:
      push    EDX            ; push array size onto stack
      push    array          ; place array pointer on stack
      call    bubble_sort
      PutStr  output_msg     ; display sorted input numbers
      nwln
      mov     EBX,array
      mov     ECX,EDX        ; ECX = number count
print_loop:
      PutLInt  [EBX]
      nwln
      add     EBX,4
      loop    print_loop
done:
      .EXIT
;-----------------------------------------------------------
;This procedure receives a pointer to an array of integers
; and the size of the array via the stack. It sorts the
; array in ascending order using the bubble sort algorithm.
;-----------------------------------------------------------
SORTED    EQU   0
UNSORTED  EQU   1
bubble_sort:
      pushad
      mov     EBP,ESP       
	
      ; ECX serves the same purpose as the end_index variable
      ; in the C procedure. ECX keeps the number of comparisons
      ; to be done in each pass. Note that ECX is decremented
      ; by 1 after each pass.
      mov     ECX, [EBP+40]  ; load array size into ECX

next_pass:
      dec     ECX           ; if # of comparisons is zero
      jz      sort_done     ; then we are done
      mov     EDI,ECX       ; else start another pass

      ;DL is used to keep SORTED/UNSORTED status
      mov     DL,SORTED     ; set status to SORTED

      mov     ESI,[EBP+36]  ; load array address into ESI
      ; ESI points to element i and ESI+4 to the next element
pass:
      ; This loop represents one pass of the algorithm.
      ; Each iteration compares elements at [ESI] and [ESI+4]
      ; and swaps them if ([ESI]) < ([ESI+4]).
	
      mov     EAX,[ESI]      
      mov     EBX,[ESI+4]
      cmp     EAX,EBX
      jg      swap
	
increment:
      ; Increment ESI by 4 to point to the next element
      add     ESI,4
      dec     EDI
      jnz     pass 
	
      cmp     EDX,SORTED     ; if status remains SORTED
      je      sort_done      ; then sorting is done
      jmp     next_pass      ; else initiate another pass

swap:
      ; swap elements at [ESI] and [ESI+4]
      mov     [ESI+4],EAX    ; copy [ESI] in EAX to [ESI+4]
      mov     [ESI],EBX      ; copy [ESI+4] in EBX to [ESI]
      mov     EDX,UNSORTED   ; set status to UNSORTED
      jmp     increment       

sort_done:
      popad
      ret     8
