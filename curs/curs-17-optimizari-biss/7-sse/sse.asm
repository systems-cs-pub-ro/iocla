	BITS 32
	GLOBAL sum_array_sse
sum_array_sse:
	push ebp
	mov ebp, esp
	push esi
	push edi
	
	push ebx
	mov ecx, [ebp + 20] ; ecx = n
	mov esi, [ebp + 8] ; esi = a
	mov edi, [ebp + 12] ; edi = b
	mov ebx, [ebp + 16] ; ebx = c
	; n = n / 16	shr ecx, 4		
	xor eax, eax

	cmp eax, ecx
	jge end
begin:
	movdqu xmm0, [esi]
	movdqu xmm1, [edi]
	paddd xmm0, xmm1
	movdqu [ebx], xmm0
	
	add esi, 16
	add edi, 16
	add ebx, 16
	add eax, 4	
	cmp eax, ecx
	jl begin
end:
	pop ebx
	pop edi
	pop esi
	leave
	ret


GLOBAL sum_array_plain 
sum_array_plain:
	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx
	push edx
	
	mov ecx, [ebp + 20] ; ecx = n
	mov esi, [ebp + 8] ; esi = a
	mov edi, [ebp + 12] ; edi = b
	mov ebx, [ebp + 16] ; ebx = c

	xor eax, eax

	cmp eax, ecx
	jge pend
pbegin:
	mov edx, [esi+eax*4]
	add edx, [edi+eax*4]
	mov [ebx+eax*4], edx
	
	;; add esi, 4		
	;; add edi, 4
	;; add ebx, 4
	add eax, 1	
	cmp eax, ecx
	jl pbegin
pend:
	pop edx
	pop ebx
	pop edi
	pop esi
	leave
	ret
