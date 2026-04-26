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
     asm("\
     .intel_syntax noprefix     \n\
        xor     eax, eax        \n\
        push   	ebx				\n\
        mov     ebx, [ebp+8]	\n\
        mov     ecx, [ebp+12] 	\n\
    rep1:						\n\
        jecxz   done			\n\
        dec     ecx				\n\
        add     eax, [ebx+ecx*4]\n\
        jmp     rep1			\n\
    done:						\n\
        pop    	ebx				\n\
"); 
}
