
segment .text
	
	global  update_max_cmov
	global  update_max_jmp
	extern max
	
update_max_jmp:
	push rbp
	mov rbp, rsp
	mov edx, edi
	cmp edx, [rel max]
	jg update_max
	mov eax, 0
	jmp return
update_max:
        mov [rel max], edx
	mov eax, 1
return:
        leave
        ret



update_max_cmov: 
 	push rbp
	mov rbp, rsp
	mov ecx, [rel max]
	mov eax, 0
	cmp edi, ecx
	cmovg ecx, edi
	mov [rel max], ecx
	setg al
	leave
    ret
