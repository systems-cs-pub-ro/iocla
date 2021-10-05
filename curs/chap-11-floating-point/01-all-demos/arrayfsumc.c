/************************************************************
 * This program reads SIZE values into an array and calls 
 * an assembly language program to compute the array sum. 
 * The assembly program is in the file "arrayfsuma.asm".
 ************************************************************/
#include        <stdio.h>

#define  SIZE  10

int main(void)
{
    double     value[SIZE];
    int        i;
    extern double array_fsum(double*, int);

    printf("Input %d array values:\n", SIZE);  
    for (i = 0; i < SIZE; i++)
        scanf("%lf",&value[i]);

    printf("Array sum = %lf\n", array_fsum(value,SIZE));  
	
    return 0;
}
