section .text

global main
	;; Use different values in al and bl register and run under GDB to see flags. 
main:
	push ebp
	mov ebp, esp

	mov al, 0x80
	mov bl, 0x80
adunare:	 
	add al, bl

	leave
	ret
