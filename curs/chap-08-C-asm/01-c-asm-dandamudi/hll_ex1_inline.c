/*****************************************************************
 * A simple program to illustrate how mixed-mode programs are 
 * written in C and assembly languages. This program uses inline
 * assembly code in the test1 function.
 *****************************************************************/
#include        <stdio.h>

int main(void)
{
        int    x = 25, y = 70;
        int    value;
        extern int test1 (int, int, int);

        value = test1(x, y, 5);
        printf("Result = %d\n", value);
	
        return 0;
}

int test1(int x, int y, int z)
{
       asm("movl  %0,%%eax;" 
           "addl  %1,%%eax;"
           "subl  %2,%%eax;"
            :/* no outputs */        /* outputs */
            : "r"(x), "r"(y), "r"(z) /* inputs */
            :"cc","%eax");           /* clobber list */
}
