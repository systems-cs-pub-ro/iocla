#include <stdio.h>
#include <stdlib.h>

void print_binary(int number, int nr_bits)
{
	/* TODO */
	(void) number;
	(void) nr_bits;
	
	int *bitString = (int*)malloc(sizeof(int)*nr_bits);
	if (bitString ==NULL){
		printf("ERR");
		return;
	}

	int i = 0;
	for (i=0;i<nr_bits;i++)
	{
		bitString[i] = number & 1;
		number>>=1;
	}

	printf("0b");
	for (i = 0; i < nr_bits; i++)
	{
		printf("%d",bitString[nr_bits-1-i]);
	}
	printf("\n");
}

void check_parity(int *numbers, int n)
{
	/* TODO */
	(void) numbers;
	(void) n;

	int i;
	for (i = 0; i < n; i++)
	{
		if ((*(numbers+i)) & 1) // caz impar
		{
			printf("0x%08x\n",*(numbers+i));
		} else
		{
			print_binary(*(numbers+i),8);
		}	
	}
}

int main(void)
{
	/* TODO: Test functions */
	int v[] = {214, 71, 84, 134, 86};
	check_parity(v,5);
	return 0;
}

