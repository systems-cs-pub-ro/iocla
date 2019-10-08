#include<stdio.h>
#include<sys/time.h>

extern int runAssemblyCode(int* a, int N);

#define N 1000000

void main()
{
    int a[N];
    int i;
    for (i = 0; i < N; i++)
        a[i] = 1;
    struct timeval t0, t1;
    gettimeofday(&t0, NULL);
    int result = runAssemblyCode(a, N);
    gettimeofday(&t1, NULL);
    long elapsed = (t1.tv_sec - t0.tv_sec)*1000000 + t1.tv_usec - t0.tv_usec;
    printf("Time: %ld\n", elapsed);
    printf("result: %d\n", result);
}
