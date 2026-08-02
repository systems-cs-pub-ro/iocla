// SPDX-License-Identifier: BSD-3-Clause

/*
 * Inline assembly variant for array summation using x87 instructions.
 */

double array_fsum(double *value, int size)
{
	double sum;

	asm("fldz; "
	    "add_loop: jrcxz done; "
	    "decq %%rcx; "
	    "faddl (%%rbx, %%rcx, 8); "
	    "jmp add_loop; "
	    "done: "
	    : "=t"(sum)
	    : "b"(value), "c"((long)size)
	    : "cc");

	return sum;
}
