;Procedures for number input/output    GETPUT.ASM
;	Objective: Use arithmetic instructions to write simple
;		   8-bit integer input and output functions:
;			 PutInt8 - displays a signed integer
;			 GetInt8 - reads a signed integer
;	   Inputs: PutInt8 - 8-bit integer in AL register
;		   Getint8 - an integer from keyboard
;	   Output: According to the function. In GetInt8,
;		   Carry flag is used to indicate "out of range" 
;		   error if the input number is not between
;                  -128 and +127 (both inclusive).
%include "io.mac"
global  PutInt8, GetInt8

.UDATA
number   resb    5

.CODE
;-----------------------------------------------------------
;GetInt8 procedure reads an integer from the keyboard and
;stores its equivalent binary in AL register. If the number
;is within -128 and +127 (both inclusive), CF is cleared;
;otherwise, CF is set to indicate out-of-range error.
;No error check is done to see if the input consists of
;digits only. All registers are preserved except for AX.
;-----------------------------------------------------------
GetInt8:
	push    BX           ; save registers
	push    ECX
	push    DX
	push    ESI
	sub     DX,DX        ; DX = 0
	sub     BX,BX        ; BX = 0
	GetStr  number,5     ; get input number
	mov     ESI,number
get_next_char:
	mov     DL,[ESI]     ; read input from buffer
	cmp     DL,'-'       ; is it negative sign?
	je      sign         ; if so, save the sign
	cmp     DL,'+'       ; is it positive sign?
	jne     digit        ; if not, process the digit
sign:
	mov     BH,DL        ; BH keeps sign of input number
	inc     ESI
	jmp     get_next_char
digit:
	sub     AX,AX        ; AX = 0
	mov     BL,10        ; BL holds the multiplier
	sub     DL,'0'       ; convert ASCII to numeric
	mov     AL,DL
	mov     ECX,2         ; maximum two more digits to read
convert_loop:
	inc     ESI
	mov     DL,[ESI]
	cmp     DL,0         ; NULL?
	je      convert_done ; if so, done reading the number
	sub     DL,'0'       ; else, convert ASCII to numeric
	mul     BL           ; multiply total (in AL) by 10
	add     AX,DX        ; and add the current digit
	loop    convert_loop
convert_done:
	cmp     AX,128       
	ja      out_of_range ; if AX > 128, number out of range
	jb      number_OK    ; if AX < 128, number is valid
	cmp     BH,'-'       ; if AX = 128, must be a negative;
	jne     out_of_range ; otherwise, an invalid number
number_OK:
	cmp     BH,'-'       ; number negative?
	jne     number_done  ; if not, we are done
	neg     AL           ; else, convert to 2's complement
number_done:
	clc                  ; CF = 0 (no error)
	jmp     done
out_of_range:
	stc                  ; CF = 1 (range error)
done:
	pop     ESI          ; restore registers
	pop     DX
	pop     ECX
	pop     BX
	ret
	
;-----------------------------------------------------------
;PutInt8 procedure displays a signed 8-bit integer that is
;in AL register. All registers are preserved.
;-----------------------------------------------------------
PutInt8:
	enter   3,0          ; reserves 3 bytes of buffer space
	push    AX
	push    BX
	push    ESI
	test    AL,80H       ; negative number?
	jz      positive
negative:
	PutCh   '-'          ; sign for negative numbers
	neg     AL           ; convert to magnitude
positive:
	mov     BL,10        ; divisor  = 10
	sub     ESI,ESI      ; ESI = 0 (ESI points to buffer)
repeat1:
	sub     AH,AH        ; AH = 0 (AX is the dividend)
	div     BL           
	; AX/BL leaves AL = quotient & AH = remainder
	add     AH,'0'       ; convert remainder to ASCII
	mov     [EBP+ESI-3],AH ; copy into the buffer
	inc     ESI
	cmp     AL,0         ; quotient = zero?
	jne     repeat1      ; if so, display the number
display_digit:               
	dec     ESI
	mov     AL,[EBP+ESI-3]; display digit pointed by ESI
	PutCh   AL
	jnz     display_digit ; if ESI<0, done displaying
display_done:
	pop     ESI           ; restore registers
	pop     BX
	pop     AX
	leave                ; clears local buffer space
	ret        

