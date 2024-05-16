; SPDX-License-Identifier: BSD-3-Clause

section .text

global get_max

get_max:
	push rbp
	mov rbp, rsp

	; [ebp+8] is array pointer
	; [ebp+12] is array length

	mov rbx, rdi
	mov rcx, rsi
	xor rax, rax

compare:
	cmp eax, [rbx+rcx*4-4]
	jge check_end
	mov eax, [rbx+rcx*4-4]
check_end:
	loopnz compare

	leave
	ret
