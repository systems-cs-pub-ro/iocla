	BITS 64
	DEFAULT REL

	GLOBAL sum_array_sse
sum_array_sse:
	; SysV x64 ABI: rdi=a, rsi=b, rdx=c, ecx=n
	xor eax, eax

	cmp eax, ecx
	jge .end
.begin:
	movdqu xmm0, [rdi + rax*4]
	movdqu xmm1, [rsi + rax*4]
	paddd xmm0, xmm1
	movdqu [rdx + rax*4], xmm0

	add eax, 4
	cmp eax, ecx
	jl .begin
.end:
	ret

	GLOBAL sum_array_plain
sum_array_plain:
	; SysV x64 ABI: rdi=a, rsi=b, rdx=c, ecx=n
	xor eax, eax

	cmp eax, ecx
	jge .pend
.pbegin:
	mov r8d, [rdi + rax*4]
	add r8d, [rsi + rax*4]
	mov [rdx + rax*4], r8d

	add eax, 1
	cmp eax, ecx
	jl .pbegin
.pend:
	ret
