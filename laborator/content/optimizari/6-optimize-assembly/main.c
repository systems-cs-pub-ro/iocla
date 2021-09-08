#include<stdio.h>
#include<sys/time.h>

extern int runAssemblyCode(int* a, int N);

#define N (100 * 1000 * 1000)
int a[N];

void main()
{
    int i;
    int result;
    long elapsed;
    struct timeval t0, t1;

    for (i = 0; i < N; i++)
        a[i] = 1;

    gettimeofday(&t0, NULL);
    result = runAssemblyCode(a, N);
    gettimeofday(&t1, NULL);

    elapsed = (t1.tv_sec - t0.tv_sec)*1000000 + t1.tv_usec - t0.tv_usec;
    printf("Time: %ld us\n", elapsed);
    printf("result: %d\n", result);
}
