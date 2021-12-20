/*
 * Don't forget to include "positions.h"
 */

.section .text
.global add_vect

/* 
 * void add_vect(int *v1, int *v2, int n, int *v)
 *
 * add v1 and v2, that have both the length n, and store the result in v3.
 * also, substract from v3 the values provided in positions.S, as described
 * in the task
 */

add_vect:
	pushl 	%ebp
	movl	%esp, %ebp

	leave
	ret
