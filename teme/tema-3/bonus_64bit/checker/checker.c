#include <stdio.h>
#include <stdlib.h>

extern void intertwine(int *v1, int n1, int *v2, int n2, int *v);

int read_vect(int **v)
{
	int n, i;

	scanf("%d\n", &n);

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
	int *v1, *v2, *v;
	int n1, n2, n, i;

	n1 = read_vect(&v1);
	n2 = read_vect(&v2);

	n = n1 + n2;

	v = malloc(n * sizeof(*v));

	intertwine(v1, n1, v2, n2, v);
	
	for (i = 0; i < n; i++)
		printf("%d ", v[i]);
	printf("\n");

	free(v1);
	free(v2);
	free(v);

	return 0;
}
