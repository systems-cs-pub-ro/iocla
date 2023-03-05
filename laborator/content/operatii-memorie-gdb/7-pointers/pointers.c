#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <stdlib.h>

#define SIGN(X) (((X) > 0) - ((X) < 0))

int my_strcmp(const char *s1, const char *s2);
void *my_memcpy(void *dest, const void *src, size_t n);
char *my_strcpy(char *dest, const char *src);

int main() {
	char s1[] = "Abracadabra";
	char s2[] = "Abracababra";
	char src[] = "Learn IOCLA, you must!";

	char* dest_strcpy = malloc(sizeof(src));
	char* dest_memcpy = malloc(sizeof(src));

	(void) s1;
	(void) s2;

	/*
	Decomentati pe rand cate un assert pe masura ce implementati o functie.
	Daca functia voastra este implementata corect atunci asertia se va realiza
	cu succes. In caz contrar, programul va crapa.
	*/
	// assert(SIGN(my_strcmp(s1, s2)) == SIGN(strcmp(s1, s2)));
	// assert(strcpy(dest_strcpy, src) && !strcmp(src, dest_strcpy));
	// assert(my_memcpy(dest_memcpy, src, sizeof(src)) && !memcmp(src, dest_memcpy, sizeof(src)));

	free(dest_strcpy);
	free(dest_memcpy);
	return 0;
}
