#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

/*
  Examinați codul assembler gennerat pentru cele 3 cazuri: 
  make asm 
  less fib.s

*/

uint32_t fiboTail(uint32_t n, uint32_t a, uint32_t b)
{
  if (n == 0) return a;
  if (n == 1) return b;
  return fiboTail(n - 1, b, a + b);
}

uint32_t fibogoto(uint32_t n, uint32_t a, uint32_t b)
{
begin:
  if (n == 0) return a;
  if (n == 1) return b;
  b = b + a; 
  a = b - a; 
  n = n - 1; 
  goto begin; 
}

uint32_t fibo(uint32_t n)
{
	if(n <= 1) return n; 
	return fibo(n-1) + fibo(n-2); 
}


int main (int nargs, char**args)
{
	int n = atoi(args[1]); 
	printf("Normal = %d\nTail = %d\nGoto = %d\n", fibo(n), fiboTail(n, 0, 1), fibogoto(n, 0, 1));
}

