/************************************************************
 * This program reads 10 integers into an array and calls an 
 * assembly language program to compute the array sum. 
 * The assembly program is in the file "hll_arraysuma.asm".
 ************************************************************/
#include        <stdio.h>

#define  SIZE  10

int main(void)
{
    int    value[SIZE], sum, i;
    extern int array_sum(int*, int);

    printf("Input %d array values:\n", SIZE);  
    for (i = 0; i < SIZE; i++)
        scanf("%d",&value[i]);

    sum = array_sum(value,SIZE);
    printf("Array sum = %d\n", sum);  
	
    return 0;
}
