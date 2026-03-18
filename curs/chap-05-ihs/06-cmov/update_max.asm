
segment .text
	
	global  update_max_cmov
	global  update_max_jmp
	extern max
	
update_max_jmp:
	cmp edi, [max]
	jg update_max
	mov eax, 0
	jmp return
update_max:
        mov [max], edi
	mov eax, 1
return:
        ret



update_max_cmov: 
	mov ecx, [max]
	mov eax, 0
	cmp edi, ecx
	cmovg ecx, edi
	mov [max], ecx
	setg al
	ret
