/************************************************************
 * This program reads 10 integers into an array and calls an 
 * assembly language program to compute the array sum. 
 * It uses inline assembly code in array_sum function.
 ************************************************************/
#include        <stdio.h>

#define  SIZE  10

int main(void)
{
    int    value[SIZE], sum, i;
    int    array_sum(int*, int);

    printf("Input %d array values:\n", SIZE);  
    for (i = 0; i < SIZE; i++)
        scanf("%d",&value[i]);

    sum = array_sum(value,SIZE);
    printf("Array sum = %d\n", sum);  
	
    return 0;
}

int array_sum(int* value, int size)
{
         asm("      xorl  %%eax,%%eax;"   /* sum = 0 */
             "rep1: jecxz done;       "
             "      decl  %%ecx;      "
             "      addl  (%%ebx,%%ecx,4),%%eax;"
             "      jmp   rep1;       "
             "done:                   "
              : /* no outputs */
              :"b"(value),"c"(size)       /* inputs */
              :"%eax","cc");              /* clobber list */
}
