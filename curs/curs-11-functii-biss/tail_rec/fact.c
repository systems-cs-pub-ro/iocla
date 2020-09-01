#include <stdio.h>

/* 
   gcc -O2 generează tail, și duplică codul din factorial_iterator(n,1) 
   * verificați codul generat pentru factorial recursiv 
   * codul pentru factoriali
   * în funcția factorial_iterator activați varianta cu recursivitate pe coadă #if 1
   * în funcția factorial_iterator activați varianta iterativă #if 0
   * analizați codul assembler produs în ambele variante cu 'make asm' 
 */


int factorial(int n) { 
    if(n <= 1) 
	return 1; 
    return n * factorial(n-1); 
}

 
int factorial_iterator(int n, int accumulator) 
{
 begin:
    if(n <= 1)
      return accumulator;
    #if 0
    return factorial_iterator(n - 1, accumulator * n);
    #else
    accumulator = accumulator * n;
    n = n - 1; 
    goto begin; 
    #endif
}

int factoriali(int n) {
    return factorial_iterator(n, 1);
}


void main()
{

  printf("Factorial = %d\n", factoriali(7)); 

}
