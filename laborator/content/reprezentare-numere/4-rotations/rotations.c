#include <stdio.h>

void rotate_left(unsigned int *number, int bits)
{
	/* TODO */
	unsigned int inumber = *number;
	unsigned int rezult = (inumber << bits) | (inumber >> (32-bits));
	*number = rezult;
	printf("%u",rezult);
}

void rotate_right(unsigned int *number, int bits)
{
	/* TODO */
	unsigned int inumber = *number;
	unsigned int rezult = (inumber >> bits) | (inumber << (sizeof(int)-bits));
	*number = rezult;
	printf("%u",rezult);
}

int main(void)
{
	/* TODO: Test functions */
	unsigned int number, numberOfBits;
	printf("Numar si nr de biti:\t");
	scanf("%u%u",&number,&numberOfBits);
	
	rotate_left(&number,numberOfBits);
	rotate_right(&number,numberOfBits);
	//printf("Shiftare la stanga:\t%u\n",number);

	//rotate_right(&number,numberOfBits);
	//printf("Shiftare la dreapta:\t%u\n",number);
	return 0;
}

