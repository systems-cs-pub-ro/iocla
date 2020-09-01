#include <stdio.h>

int main(void)
{
  /* 
     compiler allocates these variables on the stack 
     in the declared order: 4 bytes for length, 4 bytes 
     for type, 9 bytes for buf...
  */
	unsigned int length = 22;
	unsigned int type = 11;
	unsigned char buf[9];
	size_t i;

	for (i = 0; i < 9; i++)
		buf[i] = i;

	printf("buf[9]: %u, buf[13]: %u\n", buf[9], buf[13]);
	printf("type: %u, length: %u\n", type, length);

	buf[10] = 55; buf[13] = 66;
	printf("type: %u, length: %u\n", type, length);

	printf("length: %p, type: %p , buf: %p, i: %p\n", &length, &type, &buf, &i);
		
	return 0;
}
