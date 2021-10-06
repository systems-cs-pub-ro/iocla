#include <stdio.h>

int main(void)
{
  long a = 10;
  char c = 'a';
  char message[128];
  int key[256];

  printf("a (value): %ld, a (address): %p, a (size): %zu\n", a, &a, sizeof(a));
  printf("c (value): %hhd, a (address): %p, a (size): %zu\n", c, &c, sizeof(c));
  printf("message (address): %p, message (address): %p, message (size): %zu\n",
	 message, &message, sizeof(message));
  printf("key (address): %p, key (size): %zu\n", key, sizeof(key));

  return 0;
}
