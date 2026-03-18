;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; no floating point support
;; all parameters need to be 64bit wide
;; format string int8_t=%hhx int16_t=%hx int32_t=%x int64_t=%lx
;;
%macro	PRINTF64		1-*
jmp     %%endstr
%%str	db	%1, 0
%%endstr:
	pushfq
	push  	rax
	push  	rcx
	push  	rdx
	push  	rsi
	push  	rdi
	push  	r8
	push  	r9
	push  	r10
	push  	r11

	push   %%str
%if  %0 >= 2
	push	%2
%endif
%if  %0 >= 3
	push	%3
%endif
%if  %0 >= 4
	push 	%4
%endif
%if  %0 >= 5
	push 	%5
%endif
%if  %0 == 6
	push 	%6
%endif
%if  %0 > 6
	%error	"PRINTF64 accepts at most 6 arguments"
%endif
%if  %0 == 6
	pop 	r9
%endif
%if  %0 >= 5
	pop 	r8
%endif
%if  %0 >= 4
	pop 	rcx
%endif
%if  %0 >= 3
	pop 	rdx
%endif
%if  %0 >= 2
	pop	rsi
%endif
	pop	rdi
	xor	eax, eax

	call    printf


	pop		r11
	pop		r10
	pop		r9
	pop		r8
	pop		rdi
	pop		rsi
	pop		rdx
	pop		rcx
	pop		rax
	popfq
%endmacro
