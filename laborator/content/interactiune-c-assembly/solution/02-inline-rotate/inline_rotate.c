// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

#define NUM	0x12345678

int main(void)
{
	size_t n = NUM;
	size_t rot_left = 0;
	size_t rot_right = 0;

	__asm__ (
	/* Use rol instruction to shift n by 8 bits left.
	 * Place result in rot_left variable.
	 */
	"mov eax, %1\n\t"
	"rol %1, 8\n\t"
	"mov %0, eax\n\t"
	: "=r" (rot_left)
	: "r" (n)
	: "eax"
	);

	__asm__ (
	/* Use ror instruction to shift n by 8 bits right.
	 * Place result in rot_right variable.
	 */
	"mov eax, %1\n\t"
	"ror eax, 8\n\t"
	"mov %0, eax\n\t"
	: "=r" (rot_right)
	: "r" (n)
	: "eax", "ecx"
	);


	/* NOTE: Output variables are passed by address, input variables
	 * are passed by value.
	 */
	printf("init: 0x%08x, rot_left: 0x%08x, rot_right: 0x%08x\n",
			n, rot_left, rot_right);

	return 0;
}
