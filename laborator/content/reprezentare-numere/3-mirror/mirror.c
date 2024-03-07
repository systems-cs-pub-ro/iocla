#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void mirror(char *s)
{
	/* TODO */
	(void) s;

	char *copy;
	copy=strdup(s);

	int size = strlen(s);
	int i;
	for (i = 0; i < size; i++)
	{
		*(copy+i) = *(s+size-1-i);		
	}

	strcpy(s,copy);
	free(copy);
	printf("%s\n",s);
	
}

int main(void)
{
	/* TODO: Test function */
	char s[20];
	scanf("%s",s);

	mirror(s);
	return 0;
}

