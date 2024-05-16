; SPDX-License-Identifier: BSD-3-Clause

BITS 64
section .text

global get_max

get_max:
	push rbp
	mov rbp, rsp

	push rbx

	; [ebp+8] is array pointer
	; [ebp+12] is array length


	mov rbx, rdi 
	mov rcx, rsi 
	xor rax, rax

compare:
	cmp eax, [rbx+rcx*4-4]
	jge check_end
	mov r8, rcx 
	sub r8, 1
	mov [rdx], r8
	mov eax, [rbx+rcx*4-4]
check_end:
	loopnz compare

	pop rbx

	leave
	ret
