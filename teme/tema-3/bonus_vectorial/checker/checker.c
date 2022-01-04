#include <stdio.h>
#include <stdlib.h>

extern void vectorial_ops(int s, int A[], int B[], int C[], int n, int D[]);

void read_vect(int **v, int n)
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
}

int main(void)
{
	int *A, *B, *C, *D;
	int n, i, s;

	scanf("%d\n", &n);
	scanf("%d\n", &s);

	read_vect(&A, n);
	read_vect(&B, n);
	read_vect(&C, n);

	D = malloc(n * sizeof(*D));

	vectorial_ops(s, A, B, C, n, D);
	
	for (i = 0; i < n; i++)
		printf("%u ", D[i]);
	printf("\n");

	free(A);
	free(B);
	free(C);
	free(D);

	return 0;
}