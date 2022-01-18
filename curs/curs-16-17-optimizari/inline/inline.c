#include<stdio.h>
#include<time.h>

#define N 1000000

void main()
{
    int list[N], sum = 0;
    int i;
    clock_t start, stop;

    start = clock();
    for (i = 0; i < N; i++)
        sum += list[i];
    stop = clock();

    printf("Time: %f\n", (double)(stop-start)/CLOCKS_PER_SEC);
}
