// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

/*
 * Afisati adresele elementelor din vectorul "v" impreuna cu valorile
 * de la acestea.
 * Parcurgeti adresele, pe rand, din octet in octet,
 * din 2 in 2 octeti si apoi din 4 in 4.
 */

int main(void) {
  int v[] = {0xCAFEBABE, 0xDEADBEEF, 0x0B00B135, 0xBAADF00D, 0xDEADC0DE};

  (void)v;
  int i;
  int *pointerInt = (int *)(v);
  short *pointerShort = (short *)(v);
  char *pointerChar = (char *)(v);
  for (i = 0; i < 5; i++) {
    printf("%p: %d\n", &pointerInt[i], pointerInt[i]);
  }
  printf("De aici incepe din 2 in 2\n");
  for (i = 0; i < 10; i++) {
    printf("%p\n", &pointerShort[i]);
  }
  printf("De aici incepe din octet in octet\n");
  for (i = 0; i < 20; i++) {
    printf("%p\n", &pointerChar[i]);
  }

  return 0;
}
