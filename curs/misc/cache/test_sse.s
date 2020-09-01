	.file	"test_sse.c"
	.intel_syntax noprefix
	.text
.Ltext0:
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.section	.text.unlikely
.Ltext_cold0:
	.text
	.globl	rdtsc
	.type	rdtsc, @function
rdtsc:
.LFB21:
	.file 1 "test_sse.c"
	.loc 1 5 0
	.cfi_startproc
	.loc 1 7 0
#APP
# 7 "test_sse.c" 1
	rdtsc
# 0 "" 2
.LVL0:
	.loc 1 9 0
#NO_APP
	ret
	.cfi_endproc
.LFE21:
	.size	rdtsc, .-rdtsc
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4,,15
	.globl	sum_array_c
	.type	sum_array_c, @function
sum_array_c:
.LFB22:
	.loc 1 13 0
	.cfi_startproc
.LVL1:
	push	edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	push	esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	.loc 1 15 0
	xor	eax, eax
	.loc 1 13 0
	push	ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	.loc 1 13 0
	mov	ecx, DWORD PTR [esp+28]
	mov	edi, DWORD PTR [esp+16]
	mov	esi, DWORD PTR [esp+20]
	mov	ebx, DWORD PTR [esp+24]
	.loc 1 15 0
	test	ecx, ecx
	jle	.L2
.LVL2:
	.p2align 4,,10
	.p2align 3
.L6:
	.loc 1 16 0 discriminator 3
	mov	edx, DWORD PTR [edi+eax*4]
	add	edx, DWORD PTR [esi+eax*4]
	mov	DWORD PTR [ebx+eax*4], edx
	.loc 1 15 0 discriminator 3
	add	eax, 1
.LVL3:
	cmp	eax, ecx
	jne	.L6
.LVL4:
.L2:
	.loc 1 17 0
	pop	ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
.LVL5:
	pop	esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
.LVL6:
	pop	edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
.LVL7:
	ret
	.cfi_endproc
.LFE22:
	.size	sum_array_c, .-sum_array_c
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"%d "
	.section	.text.unlikely
.LCOLDB3:
	.text
.LHOTB3:
	.p2align 4,,15
	.globl	print_array
	.type	print_array, @function
print_array:
.LFB23:
	.loc 1 20 0
	.cfi_startproc
.LVL8:
	push	edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	push	esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	push	ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	.loc 1 20 0
	mov	esi, DWORD PTR [esp+20]
	.loc 1 21 0
	xor	ebx, ebx
	.loc 1 20 0
	mov	edi, DWORD PTR [esp+16]
	.loc 1 21 0
	test	esi, esi
	jle	.L12
.LVL9:
	.p2align 4,,10
	.p2align 3
.L14:
	.loc 1 22 0 discriminator 3
	sub	esp, 8
	.cfi_def_cfa_offset 24
	push	DWORD PTR [edi+ebx*4]
	.cfi_def_cfa_offset 28
	.loc 1 21 0 discriminator 3
	add	ebx, 1
.LVL10:
	.loc 1 22 0 discriminator 3
	push	OFFSET FLAT:.LC2
	.cfi_def_cfa_offset 32
	call	printf
.LVL11:
	.loc 1 21 0 discriminator 3
	add	esp, 16
	.cfi_def_cfa_offset 16
	cmp	ebx, esi
	jne	.L14
.LVL12:
.L12:
	.loc 1 23 0
	mov	DWORD PTR [esp+16], 10
	.loc 1 24 0
	pop	ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	pop	esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	pop	edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	.loc 1 23 0
	jmp	putchar
.LVL13:
	.cfi_endproc
.LFE23:
	.size	print_array, .-print_array
	.section	.text.unlikely
.LCOLDE3:
	.text
.LHOTE3:
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align 4
.LC4:
	.string	"could not allocate 3 x %llu bytes of RAM\n"
	.section	.rodata.str1.1
.LC5:
	.string	"Add arrays of %llu bytes\n"
.LC6:
	.string	"  SSE: clocks spent = %15llu\n"
	.globl	__udivdi3
	.section	.rodata.str1.4
	.align 4
.LC7:
	.string	"PLAIN: clocks spent = %15llu, (%llux slower)\n"
	.align 4
.LC8:
	.string	"    C: clocks spent = %15llu, (%llux slower)\n"
	.section	.text.unlikely
.LCOLDB9:
	.section	.text.startup,"ax",@progbits
.LHOTB9:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB24:
	.loc 1 35 0
	.cfi_startproc
	lea	ecx, [esp+4]
	.cfi_def_cfa 1, 0
	and	esp, -16
	push	DWORD PTR [ecx-4]
	push	ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	mov	ebp, esp
	push	edi
	push	esi
	push	ebx
	push	ecx
	.cfi_escape 0xf,0x3,0x75,0x70,0x6
	.cfi_escape 0x10,0x7,0x2,0x75,0x7c
	.cfi_escape 0x10,0x6,0x2,0x75,0x78
	.cfi_escape 0x10,0x3,0x2,0x75,0x74
	.loc 1 39 0
	xor	edi, edi
	.loc 1 35 0
	sub	esp, 52
	.loc 1 39 0
	mov	eax, DWORD PTR SIZE
	mov	DWORD PTR SIZE+4, edi
	and	eax, -16
	.loc 1 40 0
	push	eax
	.loc 1 39 0
	mov	esi, eax
	mov	DWORD PTR SIZE, eax
	.loc 1 40 0
	call	malloc
.LVL14:
	.loc 1 41 0
	mov	DWORD PTR [esp], esi
	.loc 1 40 0
	mov	DWORD PTR v1, eax
	mov	DWORD PTR [ebp-32], eax
	.loc 1 41 0
	call	malloc
.LVL15:
	.loc 1 42 0
	mov	DWORD PTR [esp], esi
	.loc 1 41 0
	mov	ebx, eax
	mov	DWORD PTR v2, eax
	.loc 1 42 0
	call	malloc
.LVL16:
	.loc 1 43 0
	mov	ecx, DWORD PTR [ebp-32]
	add	esp, 16
	.loc 1 42 0
	mov	edx, eax
	mov	DWORD PTR r, eax
	.loc 1 43 0
	test	ecx, ecx
	sete	cl
	test	ebx, ebx
	sete	al
	or	cl, al
	jne	.L34
	test	edx, edx
	je	.L34
	mov	eax, DWORD PTR TIMES
	mov	edx, DWORD PTR TIMES+4
	.loc 1 65 0
	sub	esp, 4
	shld	edx, eax, 2
	sal	eax, 2
	mov	ecx, edx
	imul	ecx, esi
	mul	esi
	add	edx, ecx
	push	edx
	push	eax
	push	OFFSET FLAT:.LC5
	call	printf
.LVL17:
.LBB16:
.LBB17:
	.loc 1 7 0
#APP
# 7 "test_sse.c" 1
	rdtsc
# 0 "" 2
#NO_APP
.LBE17:
.LBE16:
	.loc 1 67 0
	xor	esi, esi
.LBB20:
.LBB18:
	.loc 1 7 0
	mov	DWORD PTR [ebp-32], eax
.LBE18:
.LBE20:
	.loc 1 67 0
	add	esp, 16
	xor	edi, edi
	mov	eax, DWORD PTR TIMES+4
	or	eax, DWORD PTR TIMES
.LBB21:
.LBB19:
	.loc 1 7 0
	mov	DWORD PTR [ebp-28], edx
.LVL18:
.LBE19:
.LBE21:
	.loc 1 67 0
	je	.L24
.LVL19:
	.p2align 4,,10
	.p2align 3
.L40:
	.loc 1 68 0 discriminator 3
	push	DWORD PTR SIZE
	push	DWORD PTR r
	push	DWORD PTR v2
	push	DWORD PTR v1
	call	sum_array_sse
.LVL20:
	.loc 1 67 0 discriminator 3
	add	esi, 1
.LVL21:
	adc	edi, 0
.LVL22:
	add	esp, 16
	cmp	DWORD PTR TIMES+4, edi
	ja	.L40
	jnb	.L47
.LVL23:
.L24:
.LBB22:
.LBB23:
	.loc 1 7 0
#APP
# 7 "test_sse.c" 1
	rdtsc
# 0 "" 2
.LVL24:
#NO_APP
.LBE23:
.LBE22:
	.loc 1 69 0
	sub	eax, DWORD PTR [ebp-32]
.LVL25:
	sbb	edx, DWORD PTR [ebp-28]
	.loc 1 70 0
	sub	esp, 4
	.loc 1 69 0
	mov	DWORD PTR [ebp-48], eax
	.loc 1 70 0
	push	edx
	push	eax
	push	OFFSET FLAT:.LC6
	.loc 1 69 0
	mov	DWORD PTR [ebp-44], edx
.LVL26:
	.loc 1 70 0
	call	printf
.LVL27:
.LBB24:
.LBB25:
	.loc 1 7 0
#APP
# 7 "test_sse.c" 1
	rdtsc
# 0 "" 2
#NO_APP
.LBE25:
.LBE24:
	.loc 1 73 0
	xor	esi, esi
.LBB28:
.LBB26:
	.loc 1 7 0
	mov	DWORD PTR [ebp-32], eax
.LVL28:
.LBE26:
.LBE28:
	.loc 1 73 0
	add	esp, 16
	xor	edi, edi
	mov	eax, DWORD PTR TIMES+4
	or	eax, DWORD PTR TIMES
.LBB29:
.LBB27:
	.loc 1 7 0
	mov	DWORD PTR [ebp-28], edx
.LVL29:
.LBE27:
.LBE29:
	.loc 1 73 0
	je	.L22
.LVL30:
	.p2align 4,,10
	.p2align 3
.L41:
	.loc 1 74 0 discriminator 3
	push	DWORD PTR SIZE
	push	DWORD PTR r
	push	DWORD PTR v2
	push	DWORD PTR v1
	call	sum_array_plain
.LVL31:
	.loc 1 73 0 discriminator 3
	add	esi, 1
.LVL32:
	adc	edi, 0
.LVL33:
	add	esp, 16
	cmp	DWORD PTR TIMES+4, edi
	ja	.L41
	jnb	.L48
.LVL34:
.L22:
.LBB30:
.LBB31:
	.loc 1 7 0
#APP
# 7 "test_sse.c" 1
	rdtsc
# 0 "" 2
.LVL35:
#NO_APP
.LBE31:
.LBE30:
	.loc 1 75 0
	sub	eax, DWORD PTR [ebp-32]
.LVL36:
	sbb	edx, DWORD PTR [ebp-28]
	.loc 1 76 0
	sub	esp, 16
	push	DWORD PTR [ebp-44]
.LVL37:
	push	DWORD PTR [ebp-48]
	.loc 1 75 0
	mov	esi, eax
	.loc 1 76 0
	push	edx
	push	eax
	.loc 1 75 0
	mov	edi, edx
.LVL38:
	.loc 1 76 0
	call	__udivdi3
.LVL39:
	add	esp, 20
	push	edx
	push	eax
	push	edi
	push	esi
	push	OFFSET FLAT:.LC7
	call	printf
.LVL40:
.LBB32:
.LBB33:
	.loc 1 7 0
#APP
# 7 "test_sse.c" 1
	rdtsc
# 0 "" 2
#NO_APP
.LBE33:
.LBE32:
	.loc 1 79 0
	mov	edi, DWORD PTR TIMES+4
.LBB36:
.LBB34:
	.loc 1 7 0
	mov	DWORD PTR [ebp-56], eax
.LBE34:
.LBE36:
	.loc 1 79 0
	add	esp, 32
	mov	eax, DWORD PTR TIMES
.LBB37:
.LBB35:
	.loc 1 7 0
	mov	DWORD PTR [ebp-52], edx
.LVL41:
.LBE35:
.LBE37:
	.loc 1 79 0
	mov	DWORD PTR [ebp-40], edi
	or	edi, eax
	mov	DWORD PTR [ebp-36], eax
	je	.L26
	mov	ecx, DWORD PTR SIZE
	mov	edi, DWORD PTR r
	mov	esi, DWORD PTR v2
.LVL42:
	mov	ebx, DWORD PTR v1
	mov	DWORD PTR [ebp-32], 0
	mov	DWORD PTR [ebp-28], 0
.LVL43:
	.p2align 4,,10
	.p2align 3
.L29:
.LBB38:
.LBB39:
	.loc 1 15 0 discriminator 3
	xor	eax, eax
	test	ecx, ecx
	jle	.L31
.LVL44:
	.p2align 4,,10
	.p2align 3
.L37:
	.loc 1 16 0
	mov	edx, DWORD PTR [ebx+eax*4]
	add	edx, DWORD PTR [esi+eax*4]
	mov	DWORD PTR [edi+eax*4], edx
	.loc 1 15 0
	add	eax, 1
.LVL45:
	cmp	eax, ecx
	jne	.L37
.LVL46:
.L31:
.LBE39:
.LBE38:
	.loc 1 79 0
	add	DWORD PTR [ebp-32], 1
.LVL47:
	adc	DWORD PTR [ebp-28], 0
.LVL48:
	mov	eax, DWORD PTR [ebp-32]
	mov	edx, DWORD PTR [ebp-28]
	xor	eax, DWORD PTR [ebp-36]
	xor	edx, DWORD PTR [ebp-40]
	or	edx, eax
	jne	.L29
.LVL49:
.L26:
.LBB40:
.LBB41:
	.loc 1 7 0
#APP
# 7 "test_sse.c" 1
	rdtsc
# 0 "" 2
.LVL50:
#NO_APP
.LBE41:
.LBE40:
	.loc 1 81 0
	sub	eax, DWORD PTR [ebp-56]
.LVL51:
	sbb	edx, DWORD PTR [ebp-52]
	.loc 1 82 0
	sub	esp, 16
	push	DWORD PTR [ebp-44]
.LVL52:
	push	DWORD PTR [ebp-48]
	.loc 1 81 0
	mov	esi, eax
	.loc 1 82 0
	push	edx
	push	eax
	.loc 1 81 0
	mov	edi, edx
.LVL53:
	.loc 1 82 0
	call	__udivdi3
.LVL54:
	add	esp, 20
	push	edx
	push	eax
	push	edi
	push	esi
	push	OFFSET FLAT:.LC8
	call	printf
.LVL55:
	.loc 1 85 0
	add	esp, 32
	.loc 1 86 0
	lea	esp, [ebp-16]
	xor	eax, eax
	pop	ecx
	.cfi_remember_state
	.cfi_restore 1
	.cfi_def_cfa 1, 0
	pop	ebx
	.cfi_restore 3
	pop	esi
	.cfi_restore 6
.LVL56:
	pop	edi
	.cfi_restore 7
	pop	ebp
	.cfi_restore 5
	lea	esp, [ecx-4]
	.cfi_def_cfa 4, 4
	ret
.LVL57:
	.p2align 4,,10
	.p2align 3
.L47:
	.cfi_restore_state
	.loc 1 67 0 discriminator 3
	cmp	DWORD PTR TIMES, esi
	ja	.L40
	jmp	.L24
.LVL58:
	.p2align 4,,10
	.p2align 3
.L48:
	.loc 1 73 0 discriminator 3
	cmp	DWORD PTR TIMES, esi
	ja	.L41
	jmp	.L22
.LVL59:
.L34:
	.loc 1 44 0
	push	eax
	push	edi
	push	esi
	push	OFFSET FLAT:.LC4
	call	printf
.LVL60:
	.loc 1 45 0
	mov	DWORD PTR [esp], -1
	call	exit
.LVL61:
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE9:
	.section	.text.startup
.LHOTE9:
	.globl	TIMES
	.data
	.align 8
	.type	TIMES, @object
	.size	TIMES, 8
TIMES:
	.long	131072
	.long	0
	.globl	SIZE
	.align 8
	.type	SIZE, @object
	.size	SIZE, 8
SIZE:
	.long	4096
	.long	0
	.comm	r,4,4
	.comm	v2,4,4
	.comm	v1,4,4
	.text
.Letext0:
	.section	.text.unlikely
.Letext_cold0:
	.file 2 "/usr/lib/gcc/x86_64-linux-gnu/4.9/include/stddef.h"
	.file 3 "/usr/include/bits/types.h"
	.file 4 "/usr/include/libio.h"
	.file 5 "/usr/include/stdint.h"
	.file 6 "/usr/include/stdio.h"
	.file 7 "/usr/include/stdlib.h"
	.file 8 "<built-in>"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x69d
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF64
	.byte	0x1
	.long	.LASF65
	.long	.LASF66
	.long	.Ldebug_ranges0+0x60
	.long	0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF8
	.byte	0x2
	.byte	0xd4
	.long	0x30
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF0
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.long	.LASF1
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.long	.LASF2
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF3
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF4
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.long	.LASF5
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF6
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF7
	.uleb128 0x2
	.long	.LASF9
	.byte	0x3
	.byte	0x37
	.long	0x61
	.uleb128 0x2
	.long	.LASF10
	.byte	0x3
	.byte	0x83
	.long	0x85
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.long	.LASF11
	.uleb128 0x2
	.long	.LASF12
	.byte	0x3
	.byte	0x84
	.long	0x6f
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF13
	.uleb128 0x5
	.byte	0x4
	.uleb128 0x6
	.byte	0x4
	.long	0xa6
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF14
	.uleb128 0x7
	.long	.LASF44
	.byte	0x94
	.byte	0x4
	.byte	0xf5
	.long	0x22d
	.uleb128 0x8
	.long	.LASF15
	.byte	0x4
	.byte	0xf6
	.long	0x5a
	.byte	0
	.uleb128 0x8
	.long	.LASF16
	.byte	0x4
	.byte	0xfb
	.long	0xa0
	.byte	0x4
	.uleb128 0x8
	.long	.LASF17
	.byte	0x4
	.byte	0xfc
	.long	0xa0
	.byte	0x8
	.uleb128 0x8
	.long	.LASF18
	.byte	0x4
	.byte	0xfd
	.long	0xa0
	.byte	0xc
	.uleb128 0x8
	.long	.LASF19
	.byte	0x4
	.byte	0xfe
	.long	0xa0
	.byte	0x10
	.uleb128 0x8
	.long	.LASF20
	.byte	0x4
	.byte	0xff
	.long	0xa0
	.byte	0x14
	.uleb128 0x9
	.long	.LASF21
	.byte	0x4
	.value	0x100
	.long	0xa0
	.byte	0x18
	.uleb128 0x9
	.long	.LASF22
	.byte	0x4
	.value	0x101
	.long	0xa0
	.byte	0x1c
	.uleb128 0x9
	.long	.LASF23
	.byte	0x4
	.value	0x102
	.long	0xa0
	.byte	0x20
	.uleb128 0x9
	.long	.LASF24
	.byte	0x4
	.value	0x104
	.long	0xa0
	.byte	0x24
	.uleb128 0x9
	.long	.LASF25
	.byte	0x4
	.value	0x105
	.long	0xa0
	.byte	0x28
	.uleb128 0x9
	.long	.LASF26
	.byte	0x4
	.value	0x106
	.long	0xa0
	.byte	0x2c
	.uleb128 0x9
	.long	.LASF27
	.byte	0x4
	.value	0x108
	.long	0x265
	.byte	0x30
	.uleb128 0x9
	.long	.LASF28
	.byte	0x4
	.value	0x10a
	.long	0x26b
	.byte	0x34
	.uleb128 0x9
	.long	.LASF29
	.byte	0x4
	.value	0x10c
	.long	0x5a
	.byte	0x38
	.uleb128 0x9
	.long	.LASF30
	.byte	0x4
	.value	0x110
	.long	0x5a
	.byte	0x3c
	.uleb128 0x9
	.long	.LASF31
	.byte	0x4
	.value	0x112
	.long	0x7a
	.byte	0x40
	.uleb128 0x9
	.long	.LASF32
	.byte	0x4
	.value	0x116
	.long	0x3e
	.byte	0x44
	.uleb128 0x9
	.long	.LASF33
	.byte	0x4
	.value	0x117
	.long	0x4c
	.byte	0x46
	.uleb128 0x9
	.long	.LASF34
	.byte	0x4
	.value	0x118
	.long	0x271
	.byte	0x47
	.uleb128 0x9
	.long	.LASF35
	.byte	0x4
	.value	0x11c
	.long	0x281
	.byte	0x48
	.uleb128 0x9
	.long	.LASF36
	.byte	0x4
	.value	0x125
	.long	0x8c
	.byte	0x4c
	.uleb128 0x9
	.long	.LASF37
	.byte	0x4
	.value	0x12e
	.long	0x9e
	.byte	0x54
	.uleb128 0x9
	.long	.LASF38
	.byte	0x4
	.value	0x12f
	.long	0x9e
	.byte	0x58
	.uleb128 0x9
	.long	.LASF39
	.byte	0x4
	.value	0x130
	.long	0x9e
	.byte	0x5c
	.uleb128 0x9
	.long	.LASF40
	.byte	0x4
	.value	0x131
	.long	0x9e
	.byte	0x60
	.uleb128 0x9
	.long	.LASF41
	.byte	0x4
	.value	0x132
	.long	0x25
	.byte	0x64
	.uleb128 0x9
	.long	.LASF42
	.byte	0x4
	.value	0x134
	.long	0x5a
	.byte	0x68
	.uleb128 0x9
	.long	.LASF43
	.byte	0x4
	.value	0x136
	.long	0x287
	.byte	0x6c
	.byte	0
	.uleb128 0xa
	.long	.LASF67
	.byte	0x4
	.byte	0x9a
	.uleb128 0x7
	.long	.LASF45
	.byte	0xc
	.byte	0x4
	.byte	0xa0
	.long	0x265
	.uleb128 0x8
	.long	.LASF46
	.byte	0x4
	.byte	0xa1
	.long	0x265
	.byte	0
	.uleb128 0x8
	.long	.LASF47
	.byte	0x4
	.byte	0xa2
	.long	0x26b
	.byte	0x4
	.uleb128 0x8
	.long	.LASF48
	.byte	0x4
	.byte	0xa6
	.long	0x5a
	.byte	0x8
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.long	0x234
	.uleb128 0x6
	.byte	0x4
	.long	0xad
	.uleb128 0xb
	.long	0xa6
	.long	0x281
	.uleb128 0xc
	.long	0x97
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.long	0x22d
	.uleb128 0xb
	.long	0xa6
	.long	0x297
	.uleb128 0xc
	.long	0x97
	.byte	0x27
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.long	0x29d
	.uleb128 0xd
	.long	0xa6
	.uleb128 0x2
	.long	.LASF49
	.byte	0x5
	.byte	0x33
	.long	0x30
	.uleb128 0x2
	.long	.LASF50
	.byte	0x5
	.byte	0x3a
	.long	0x68
	.uleb128 0xe
	.long	.LASF58
	.byte	0x1
	.byte	0x5
	.long	0x2ad
	.byte	0x1
	.long	0x2d4
	.uleb128 0xf
	.long	.LASF51
	.byte	0x1
	.byte	0x6
	.long	0x2ad
	.byte	0
	.uleb128 0x10
	.long	.LASF61
	.byte	0x1
	.byte	0xd
	.byte	0x1
	.long	0x30e
	.uleb128 0x11
	.string	"a"
	.byte	0x1
	.byte	0xd
	.long	0x30e
	.uleb128 0x11
	.string	"b"
	.byte	0x1
	.byte	0xd
	.long	0x30e
	.uleb128 0x11
	.string	"c"
	.byte	0x1
	.byte	0xd
	.long	0x30e
	.uleb128 0x11
	.string	"n"
	.byte	0x1
	.byte	0xd
	.long	0x5a
	.uleb128 0x12
	.string	"i"
	.byte	0x1
	.byte	0xe
	.long	0x5a
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.long	0x2a2
	.uleb128 0x13
	.long	0x2b8
	.long	.LFB21
	.long	.LFE21-.LFB21
	.uleb128 0x1
	.byte	0x9c
	.long	0x334
	.uleb128 0x14
	.long	0x2c8
	.uleb128 0x6
	.byte	0x50
	.byte	0x93
	.uleb128 0x4
	.byte	0x52
	.byte	0x93
	.uleb128 0x4
	.byte	0
	.uleb128 0x13
	.long	0x2d4
	.long	.LFB22
	.long	.LFE22-.LFB22
	.uleb128 0x1
	.byte	0x9c
	.long	0x375
	.uleb128 0x15
	.long	0x2e0
	.long	.LLST0
	.uleb128 0x15
	.long	0x2e9
	.long	.LLST1
	.uleb128 0x15
	.long	0x2f2
	.long	.LLST2
	.uleb128 0x15
	.long	0x2fb
	.long	.LLST3
	.uleb128 0x16
	.long	0x304
	.long	.LLST4
	.byte	0
	.uleb128 0x17
	.long	.LASF52
	.byte	0x1
	.byte	0x13
	.long	.LFB23
	.long	.LFE23-.LFB23
	.uleb128 0x1
	.byte	0x9c
	.long	0x3c9
	.uleb128 0x18
	.string	"v"
	.byte	0x1
	.byte	0x13
	.long	0x30e
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x18
	.string	"n"
	.byte	0x1
	.byte	0x13
	.long	0x5a
	.uleb128 0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x19
	.string	"i"
	.byte	0x1
	.byte	0x14
	.long	0x5a
	.long	.LLST5
	.uleb128 0x1a
	.long	.LVL11
	.long	0x60c
	.uleb128 0x1b
	.long	.LVL13
	.long	0x623
	.uleb128 0x1c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1
	.byte	0x3a
	.byte	0
	.byte	0
	.uleb128 0x1d
	.long	.LASF53
	.byte	0x1
	.byte	0x22
	.long	0x5a
	.long	.LFB24
	.long	.LFE24-.LFB24
	.uleb128 0x1
	.byte	0x9c
	.long	0x5a5
	.uleb128 0x12
	.string	"ts0"
	.byte	0x1
	.byte	0x24
	.long	0x2ad
	.uleb128 0x19
	.string	"ts1"
	.byte	0x1
	.byte	0x24
	.long	0x2ad
	.long	.LLST6
	.uleb128 0x19
	.string	"ts2"
	.byte	0x1
	.byte	0x24
	.long	0x2ad
	.long	.LLST7
	.uleb128 0x19
	.string	"i"
	.byte	0x1
	.byte	0x24
	.long	0x2ad
	.long	.LLST8
	.uleb128 0x1e
	.long	0x2b8
	.long	.LBB16
	.long	.Ldebug_ranges0+0
	.byte	0x1
	.byte	0x42
	.long	0x43b
	.uleb128 0x1f
	.long	.Ldebug_ranges0+0
	.uleb128 0x16
	.long	0x2c8
	.long	.LLST9
	.byte	0
	.byte	0
	.uleb128 0x20
	.long	0x2b8
	.long	.LBB22
	.long	.LBE22-.LBB22
	.byte	0x1
	.byte	0x45
	.long	0x462
	.uleb128 0x21
	.long	.LBB23
	.long	.LBE23-.LBB23
	.uleb128 0x16
	.long	0x2c8
	.long	.LLST10
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x2b8
	.long	.LBB24
	.long	.Ldebug_ranges0+0x20
	.byte	0x1
	.byte	0x48
	.long	0x485
	.uleb128 0x1f
	.long	.Ldebug_ranges0+0x20
	.uleb128 0x16
	.long	0x2c8
	.long	.LLST11
	.byte	0
	.byte	0
	.uleb128 0x20
	.long	0x2b8
	.long	.LBB30
	.long	.LBE30-.LBB30
	.byte	0x1
	.byte	0x4b
	.long	0x4ac
	.uleb128 0x21
	.long	.LBB31
	.long	.LBE31-.LBB31
	.uleb128 0x16
	.long	0x2c8
	.long	.LLST12
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x2b8
	.long	.LBB32
	.long	.Ldebug_ranges0+0x40
	.byte	0x1
	.byte	0x4e
	.long	0x4cf
	.uleb128 0x1f
	.long	.Ldebug_ranges0+0x40
	.uleb128 0x16
	.long	0x2c8
	.long	.LLST13
	.byte	0
	.byte	0
	.uleb128 0x20
	.long	0x2d4
	.long	.LBB38
	.long	.LBE38-.LBB38
	.byte	0x1
	.byte	0x50
	.long	0x51a
	.uleb128 0x15
	.long	0x2fb
	.long	.LLST14
	.uleb128 0x15
	.long	0x2f2
	.long	.LLST15
	.uleb128 0x15
	.long	0x2e9
	.long	.LLST16
	.uleb128 0x15
	.long	0x2e0
	.long	.LLST17
	.uleb128 0x21
	.long	.LBB39
	.long	.LBE39-.LBB39
	.uleb128 0x16
	.long	0x304
	.long	.LLST18
	.byte	0
	.byte	0
	.uleb128 0x20
	.long	0x2b8
	.long	.LBB40
	.long	.LBE40-.LBB40
	.byte	0x1
	.byte	0x51
	.long	0x541
	.uleb128 0x21
	.long	.LBB41
	.long	.LBE41-.LBB41
	.uleb128 0x16
	.long	0x2c8
	.long	.LLST19
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	.LVL14
	.long	0x63c
	.uleb128 0x1a
	.long	.LVL15
	.long	0x63c
	.uleb128 0x1a
	.long	.LVL16
	.long	0x63c
	.uleb128 0x1a
	.long	.LVL17
	.long	0x60c
	.uleb128 0x1a
	.long	.LVL20
	.long	0x652
	.uleb128 0x1a
	.long	.LVL27
	.long	0x60c
	.uleb128 0x1a
	.long	.LVL31
	.long	0x672
	.uleb128 0x1a
	.long	.LVL40
	.long	0x60c
	.uleb128 0x1a
	.long	.LVL55
	.long	0x60c
	.uleb128 0x1a
	.long	.LVL60
	.long	0x60c
	.uleb128 0x1a
	.long	.LVL61
	.long	0x692
	.byte	0
	.uleb128 0x22
	.long	.LASF54
	.byte	0x6
	.byte	0xa8
	.long	0x26b
	.uleb128 0x22
	.long	.LASF55
	.byte	0x6
	.byte	0xa9
	.long	0x26b
	.uleb128 0x23
	.string	"v1"
	.byte	0x1
	.byte	0x19
	.long	0x30e
	.uleb128 0x5
	.byte	0x3
	.long	v1
	.uleb128 0x23
	.string	"v2"
	.byte	0x1
	.byte	0x19
	.long	0x30e
	.uleb128 0x5
	.byte	0x3
	.long	v2
	.uleb128 0x23
	.string	"r"
	.byte	0x1
	.byte	0x19
	.long	0x30e
	.uleb128 0x5
	.byte	0x3
	.long	r
	.uleb128 0x24
	.long	.LASF56
	.byte	0x1
	.byte	0x1a
	.long	0x2ad
	.uleb128 0x5
	.byte	0x3
	.long	SIZE
	.uleb128 0x24
	.long	.LASF57
	.byte	0x1
	.byte	0x1b
	.long	0x2ad
	.uleb128 0x5
	.byte	0x3
	.long	TIMES
	.uleb128 0x25
	.long	.LASF59
	.byte	0x6
	.value	0x16a
	.long	0x5a
	.long	0x623
	.uleb128 0x26
	.long	0x297
	.uleb128 0x27
	.byte	0
	.uleb128 0x28
	.long	.LASF68
	.byte	0x8
	.byte	0
	.long	.LASF69
	.long	0x5a
	.long	0x63c
	.uleb128 0x26
	.long	0x5a
	.byte	0
	.uleb128 0x25
	.long	.LASF60
	.byte	0x7
	.value	0x1d2
	.long	0x9e
	.long	0x652
	.uleb128 0x26
	.long	0x25
	.byte	0
	.uleb128 0x29
	.long	.LASF62
	.byte	0x1
	.byte	0xb
	.long	0x672
	.uleb128 0x26
	.long	0x30e
	.uleb128 0x26
	.long	0x30e
	.uleb128 0x26
	.long	0x30e
	.uleb128 0x26
	.long	0x5a
	.byte	0
	.uleb128 0x29
	.long	.LASF63
	.byte	0x1
	.byte	0xc
	.long	0x692
	.uleb128 0x26
	.long	0x30e
	.uleb128 0x26
	.long	0x30e
	.uleb128 0x26
	.long	0x30e
	.uleb128 0x26
	.long	0x5a
	.byte	0
	.uleb128 0x2a
	.long	.LASF70
	.byte	0x7
	.value	0x21f
	.uleb128 0x26
	.long	0x5a
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x2115
	.uleb128 0x19
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x2111
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2a
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.long	.LVL1
	.long	.LVL4
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL4
	.long	.LVL7
	.value	0x1
	.byte	0x57
	.long	.LVL7
	.long	.LFE22
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST1:
	.long	.LVL1
	.long	.LVL4
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	.LVL4
	.long	.LVL6
	.value	0x1
	.byte	0x56
	.long	.LVL6
	.long	.LFE22
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	0
	.long	0
.LLST2:
	.long	.LVL1
	.long	.LVL4
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	.LVL4
	.long	.LVL5
	.value	0x1
	.byte	0x53
	.long	.LVL5
	.long	.LFE22
	.value	0x2
	.byte	0x91
	.sleb128 8
	.long	0
	.long	0
.LLST3:
	.long	.LVL1
	.long	.LVL4
	.value	0x2
	.byte	0x91
	.sleb128 12
	.long	.LVL4
	.long	.LFE22
	.value	0x1
	.byte	0x51
	.long	0
	.long	0
.LLST4:
	.long	.LVL1
	.long	.LVL2
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.long	.LVL2
	.long	.LVL4
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST5:
	.long	.LVL8
	.long	.LVL9
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.long	.LVL9
	.long	.LVL10
	.value	0x1
	.byte	0x53
	.long	.LVL10
	.long	.LVL11
	.value	0x3
	.byte	0x73
	.sleb128 -1
	.byte	0x9f
	.long	.LVL11
	.long	.LVL12
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST6:
	.long	.LVL26
	.long	.LVL27-1
	.value	0x6
	.byte	0x50
	.byte	0x93
	.uleb128 0x4
	.byte	0x52
	.byte	0x93
	.uleb128 0x4
	.long	0
	.long	0
.LLST7:
	.long	.LVL38
	.long	.LVL42
	.value	0x6
	.byte	0x56
	.byte	0x93
	.uleb128 0x4
	.byte	0x57
	.byte	0x93
	.uleb128 0x4
	.long	.LVL53
	.long	.LVL56
	.value	0x6
	.byte	0x56
	.byte	0x93
	.uleb128 0x4
	.byte	0x57
	.byte	0x93
	.uleb128 0x4
	.long	0
	.long	0
.LLST8:
	.long	.LVL18
	.long	.LVL19
	.value	0xa
	.byte	0x9e
	.uleb128 0x8
	.quad	0
	.long	.LVL19
	.long	.LVL21
	.value	0x6
	.byte	0x56
	.byte	0x93
	.uleb128 0x4
	.byte	0x57
	.byte	0x93
	.uleb128 0x4
	.long	.LVL22
	.long	.LVL23
	.value	0x6
	.byte	0x56
	.byte	0x93
	.uleb128 0x4
	.byte	0x57
	.byte	0x93
	.uleb128 0x4
	.long	.LVL29
	.long	.LVL30
	.value	0xa
	.byte	0x9e
	.uleb128 0x8
	.quad	0
	.long	.LVL30
	.long	.LVL32
	.value	0x6
	.byte	0x56
	.byte	0x93
	.uleb128 0x4
	.byte	0x57
	.byte	0x93
	.uleb128 0x4
	.long	.LVL33
	.long	.LVL34
	.value	0x6
	.byte	0x56
	.byte	0x93
	.uleb128 0x4
	.byte	0x57
	.byte	0x93
	.uleb128 0x4
	.long	.LVL41
	.long	.LVL43
	.value	0xa
	.byte	0x9e
	.uleb128 0x8
	.quad	0
	.long	.LVL43
	.long	.LVL47
	.value	0x2
	.byte	0x75
	.sleb128 -32
	.long	.LVL48
	.long	.LVL49
	.value	0x2
	.byte	0x75
	.sleb128 -32
	.long	.LVL57
	.long	.LVL59
	.value	0x6
	.byte	0x56
	.byte	0x93
	.uleb128 0x4
	.byte	0x57
	.byte	0x93
	.uleb128 0x4
	.long	0
	.long	0
.LLST9:
	.long	.LVL18
	.long	.LVL28
	.value	0x2
	.byte	0x75
	.sleb128 -32
	.long	.LVL57
	.long	.LVL58
	.value	0x2
	.byte	0x75
	.sleb128 -32
	.long	0
	.long	0
.LLST10:
	.long	.LVL24
	.long	.LVL25
	.value	0x6
	.byte	0x50
	.byte	0x93
	.uleb128 0x4
	.byte	0x52
	.byte	0x93
	.uleb128 0x4
	.long	0
	.long	0
.LLST11:
	.long	.LVL29
	.long	.LVL37
	.value	0x2
	.byte	0x75
	.sleb128 -32
	.long	.LVL58
	.long	.LVL59
	.value	0x2
	.byte	0x75
	.sleb128 -32
	.long	0
	.long	0
.LLST12:
	.long	.LVL35
	.long	.LVL36
	.value	0x6
	.byte	0x50
	.byte	0x93
	.uleb128 0x4
	.byte	0x52
	.byte	0x93
	.uleb128 0x4
	.long	0
	.long	0
.LLST13:
	.long	.LVL41
	.long	.LVL52
	.value	0x2
	.byte	0x75
	.sleb128 -56
	.long	0
	.long	0
.LLST14:
	.long	.LVL43
	.long	.LVL49
	.value	0x1
	.byte	0x51
	.long	0
	.long	0
.LLST15:
	.long	.LVL43
	.long	.LVL49
	.value	0x1
	.byte	0x57
	.long	0
	.long	0
.LLST16:
	.long	.LVL43
	.long	.LVL49
	.value	0x1
	.byte	0x56
	.long	0
	.long	0
.LLST17:
	.long	.LVL43
	.long	.LVL49
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST18:
	.long	.LVL43
	.long	.LVL44
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.long	.LVL44
	.long	.LVL46
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST19:
	.long	.LVL50
	.long	.LVL51
	.value	0x6
	.byte	0x50
	.byte	0x93
	.uleb128 0x4
	.byte	0x52
	.byte	0x93
	.uleb128 0x4
	.long	0
	.long	0
	.section	.debug_aranges,"",@progbits
	.long	0x24
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x4
	.byte	0
	.value	0
	.value	0
	.long	.Ltext0
	.long	.Letext0-.Ltext0
	.long	.LFB24
	.long	.LFE24-.LFB24
	.long	0
	.long	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.long	.LBB16
	.long	.LBE16
	.long	.LBB20
	.long	.LBE20
	.long	.LBB21
	.long	.LBE21
	.long	0
	.long	0
	.long	.LBB24
	.long	.LBE24
	.long	.LBB28
	.long	.LBE28
	.long	.LBB29
	.long	.LBE29
	.long	0
	.long	0
	.long	.LBB32
	.long	.LBE32
	.long	.LBB36
	.long	.LBE36
	.long	.LBB37
	.long	.LBE37
	.long	0
	.long	0
	.long	.Ltext0
	.long	.Letext0
	.long	.LFB24
	.long	.LFE24
	.long	0
	.long	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF59:
	.string	"printf"
.LASF10:
	.string	"__off_t"
.LASF16:
	.string	"_IO_read_ptr"
.LASF60:
	.string	"malloc"
.LASF28:
	.string	"_chain"
.LASF8:
	.string	"size_t"
.LASF34:
	.string	"_shortbuf"
.LASF52:
	.string	"print_array"
.LASF22:
	.string	"_IO_buf_base"
.LASF7:
	.string	"long long unsigned int"
.LASF56:
	.string	"SIZE"
.LASF6:
	.string	"long long int"
.LASF4:
	.string	"signed char"
.LASF29:
	.string	"_fileno"
.LASF17:
	.string	"_IO_read_end"
.LASF11:
	.string	"long int"
.LASF15:
	.string	"_flags"
.LASF23:
	.string	"_IO_buf_end"
.LASF32:
	.string	"_cur_column"
.LASF69:
	.string	"putchar"
.LASF9:
	.string	"__quad_t"
.LASF31:
	.string	"_old_offset"
.LASF36:
	.string	"_offset"
.LASF61:
	.string	"sum_array_c"
.LASF63:
	.string	"sum_array_plain"
.LASF45:
	.string	"_IO_marker"
.LASF54:
	.string	"stdin"
.LASF0:
	.string	"unsigned int"
.LASF62:
	.string	"sum_array_sse"
.LASF3:
	.string	"long unsigned int"
.LASF20:
	.string	"_IO_write_ptr"
.LASF68:
	.string	"__builtin_putchar"
.LASF47:
	.string	"_sbuf"
.LASF2:
	.string	"short unsigned int"
.LASF64:
	.string	"GNU C 4.9.2 -m32 -masm=intel -mtune=generic -march=i586 -g -O3"
.LASF66:
	.string	"/tmp/capitol-09-demo"
.LASF35:
	.string	"_lock"
.LASF30:
	.string	"_flags2"
.LASF42:
	.string	"_mode"
.LASF55:
	.string	"stdout"
.LASF13:
	.string	"sizetype"
.LASF65:
	.string	"test_sse.c"
.LASF24:
	.string	"_IO_save_base"
.LASF21:
	.string	"_IO_write_end"
.LASF50:
	.string	"uint64_t"
.LASF67:
	.string	"_IO_lock_t"
.LASF44:
	.string	"_IO_FILE"
.LASF48:
	.string	"_pos"
.LASF27:
	.string	"_markers"
.LASF1:
	.string	"unsigned char"
.LASF5:
	.string	"short int"
.LASF33:
	.string	"_vtable_offset"
.LASF70:
	.string	"exit"
.LASF49:
	.string	"uint32_t"
.LASF58:
	.string	"rdtsc"
.LASF14:
	.string	"char"
.LASF46:
	.string	"_next"
.LASF12:
	.string	"__off64_t"
.LASF18:
	.string	"_IO_read_base"
.LASF26:
	.string	"_IO_save_end"
.LASF37:
	.string	"__pad1"
.LASF38:
	.string	"__pad2"
.LASF39:
	.string	"__pad3"
.LASF40:
	.string	"__pad4"
.LASF41:
	.string	"__pad5"
.LASF43:
	.string	"_unused2"
.LASF25:
	.string	"_IO_backup_base"
.LASF57:
	.string	"TIMES"
.LASF53:
	.string	"main"
.LASF19:
	.string	"_IO_write_base"
.LASF51:
	.string	"result"
	.ident	"GCC: (Debian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
