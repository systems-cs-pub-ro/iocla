/************************************************************
 * This program reads three constants (a, b, c) and calls an 
 * assembly language program to compute the roots of the 
 * quadratic equation. 
 * The assembly program is in the file "quada.asm".
 ************************************************************/
#include        <stdio.h>

int main(void)
{
    double     a, b, c, root1, root2;
    extern int quad_roots(double, double, double, double*, double*);

    printf("Enter quad constants a, b, c: ");  
    scanf("%lf %lf %lf",&a, &b, &c);

    if (quad_roots(a, b, c, &root1, &root2))
        printf("Root1 = %lf and root2 = %lf\n", root1, root2); 
    else
        printf("There are no real roots.\n"); 
	
    return 0;
}
