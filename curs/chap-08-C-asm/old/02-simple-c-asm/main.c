#include <stdio.h>

extern long proc(long, long*, int, int*, short, short*, char, char* );


long call_proc()
{
long x1 = 1; int x2 = 2;
short x3 = 3; char x4 = 4;
proc(x1, &x1, x2, &x2, x3, &x3, x4, &x4);
return (x1+x2)*(x3-x4);
}

int main()
{
  printf("%ld\n", call_proc());
  
}
