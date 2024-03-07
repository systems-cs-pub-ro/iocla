#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int my_strlen(const char *str)
{
	/* TODO */

	/**
	 * The cast to (void) is used to avoid a compiler warning. Remove the line
	 * below to find out what the warning is.
	 *
	 * Remove this cast when implementing the function.
	 */
	(void) str;

	// size
	int size = strlen(str);
	size --;
	printf("length = %d\n",size);

	return -1;
}

void equality_check(const char *str)
{
	/* TODO */
	(void) str;
		// adresa 
	int i;
	int size = strlen(str);
	size --;
	for (i = 0; i < size; i++)
	{
		int putere = Pow(2,i);
		if (!(*(str+i) ^ *(str + (i + putere)%size)))
		{
			printf("Address of %c: %p\n",*(str+i),str+i);
			printf("Address of %c: %p\n",*(str + (i + putere)%size),(str + (i + putere)%size));
			printf("\n");
		}
	}

}

int Pow(int baza, int putere)
{
	int p = 1;
	if (putere == 0)
	{
		return 1;
	}
	
	while (putere)
	{
		p*=baza;
		putere--;
	}
	return p;
}

int main(void)
{
	/* TODO: Test functions */

	char str[20];
	fgets(str,20,stdin);
	my_strlen(str);
	equality_check(str);

	
	return 0;
}

