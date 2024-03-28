// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>

int main(void) {
  int v[] = {1, 2, 15, 51, 53, 66, 202, 7000};
  int dest = v[2]; /* 15 */
  int start = 0;
  int end = sizeof(v) / sizeof(int) - 1;
  int mid;
/* TODO: Implement binary search */
start:
  mid = (start + end) / 2;
  if (dest == v[mid]) goto finish;
  if (dest > v[mid]) {
    start = mid + 1;
  }
  if (dest < v[mid]) {
    end = mid - 1;
  }
  goto start;

finish:
  printf("%d\n", mid);
  (void)dest;
  (void)start;
  (void)end;
}
