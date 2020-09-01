/*****************************************************************
 * A simple program to illustrate how mixed-mode programs are 
 * written in C and assembly languages. The main C program calls
 * the assembly language procedure test1.
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
