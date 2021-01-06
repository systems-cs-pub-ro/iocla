#include <stdio.h>
#include <time.h>

#define N 1000000

static int sum_func(int a, int b)
{
    return a + b;
}

static void init(int* a)
{
    for (int i = 0; i < N; i++)
    {
        a[i] = 1;
    }
}

int main()
{
    int a[N], sum = 0;
    init(a);

    clock_t start, stop;
    start = clock();
    for (int i = 0; i < N; i += 1)
    {
        sum = sum_func(sum, a[i]);
    }
    stop = clock();
    printf("Time: %f\n", (double)(stop-start)/CLOCKS_PER_SEC);
    //printf("sum = %d\n", sum_func(sum, sum));
    return 0;
}
