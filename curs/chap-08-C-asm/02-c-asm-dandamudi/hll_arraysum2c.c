/************************************************************
 * This program calls an assembly program to read the array 
 * input and compute its sum. This program prints the sum. 
 * The assembly program is in the file "hll_arraysum2a.asm".
 ************************************************************/
#include        <stdio.h>

#define  SIZE  10

int main(void)
{
    int    value[SIZE];
    extern int array_sum(int*, int);

    printf("sum = %d\n",array_sum(value,SIZE));
	
    return 0;
}
