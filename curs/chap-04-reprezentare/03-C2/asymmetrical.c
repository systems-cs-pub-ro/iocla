#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

int32_t absolute(int32_t x) {
  if (x >= 0) {
    return x;
  } else {
    return -x;
  }
}


/*
  Limbajul C nu verifică validitatea rezultatelor în domeniile de reprezentare; 
  Nici funcția de bibliotecă abs() din stdlib.h
 */

int main() {
  int32_t x = INT32_MIN; 
  printf("0x%08x = %4d\nabsolute(x) = %4d\nabs(x) = %4d\n", x, x, absolute(x), abs(x));
  return 0;
}
