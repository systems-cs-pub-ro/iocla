#include <stdio.h>
#include <stdlib.h>

extern void add_vect(int *v1, int *v2, int n, int *v);

int read_vect(int **v, int n)
{
	int i;

	*v = malloc(n * sizeof(**v));
	if (!(*v)) {
		fprintf(stderr, "Internal error! Exiting");
		exit(1);
	}

	for (i = 0; i < n; i++) {
		scanf("%d", &(*v)[i]);
	}

	return n;
}

int main(void)
{
	int n, i;
	int *v1, *v2, *v;

	scanf("%d\n", &n);
	read_vect(&v1, n);
	read_vect(&v2, n);

	v = malloc(n * sizeof(*v));

	add_vect(v1, v2, n, v);
	
	for (i = 0; i < n; i++)
		printf("%d ", v[i]);
	printf("\n");

	free(v1);
	free(v2);
	free(v);
}