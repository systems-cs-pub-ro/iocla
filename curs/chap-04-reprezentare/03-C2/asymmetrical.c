#include <stdint.h>
#include <stdio.h>

int8_t absolute(int8_t x) {
  if (x >= 0) {
    return x;
  } else {
    return -x;
  }
}

/*
  Limbajul C nu verifică validitatea rezultatelor în domeniile de reprezentare
 */

int main() {
  int8_t values[5] = {INT8_MIN, INT8_MIN + 1, 0, INT8_MAX - 1, INT8_MAX};
  for (int i = 0; i < 5; i++) {
    int8_t x = values[i];
    printf("abs(%4d) = %4d\n", x, absolute(x));
  }
  return 0;
}
