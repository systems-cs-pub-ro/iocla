// SPDX-License-Identifier: BSD-3-Clause
#include <stdio.h>
#include <unistd.h>   /* getppid() */

#include "funcs.h"
/*
 * TODO: change the argument values below so that the program produces:
 *
 *   Eureka!
 *   ret: 6699
 *   It has finally happened!
 *
 * Hints
 * -----
 *  - Disassemble diggers.o with:  objdump -d -Mintel diggers.o
 *    and look at the cmp instructions inside each function.
 *  - For omega(), the argument must equal the parent process PID.
 *    Use getppid() from <unistd.h> to obtain it at runtime.
 */
int main(void)
{
	unsigned int ret;

	alpha(0);             /* <-- fix the argument */
	ret = beta(0);        /* <-- fix the argument */
	printf("ret: %u\n", ret);
	omega(0);             /* <-- fix the argument */

	return 0;
}
