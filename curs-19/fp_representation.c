/*
 Se compilează în 3 variante: -m32, -O2 -m32, -m64
 */

#include <stdio.h>
int main (void)
{
  float x, y, z;
  double b, c, d; 
  x = 0.1; 
  printf ("x = %.30f 10x %s 1.0\n", x, (10.0*x == 1.0)?"==":"!=");
  b = 0.1L; 
  printf ("b = %.30f 10b %s 1.0\n", b, (10.0L*b == 1.0L)?"==":"!=");
  c = b; 
  printf ("c = %.30f 10c %s 1.0\n", c, (10.0*c == 1.0)?"==":"!=");
  b = 0.1; 
  c = 0.7;
  d = 0.2; 
  printf ("    %.30f !=  %.30f asociativ?\n", (b + c) + d, b + (c + d) );
  d = b + c + 0.2; 
  b = 0.2 + c + b; 
  printf ("    %.30f !=  %.30f comutativ?\n", b , d);
  x = 100000.2; 
  printf ("x = %.25f 0.2 != %.25f\n", x, (x - 100000.0));
  x = 10.0;
  y = 3.0;
  z = x/y; 
  z = z - x/3.0;
  printf ("z = %.25f z = %.25f\n", z, x/y - x/3.0 );
  x = 1<<24; 
  printf ("x = %.25f x+1 = %.25f\n", x, x+1 );
  return 0;
}
