
segment .text
	
	global  update_max_cmov
	global  update_max_jmp
	extern max
	
update_max_jmp:
	enter 0,0
	mov edx, [ebp + 8]
	cmp edx, [max]
	jg update_max
	mov eax, 0
	jmp return
update_max:
        mov [max], edx
	mov eax, 1
return:
        leave
        ret



update_max_cmov: 
 	enter 0,0
	mov ecx, [max]
	mov eax, 0
	cmp [ebp+8], ecx
	cmovg ecx, [ebp+8]
	mov [max], ecx
	setg al
	leave
    ret
