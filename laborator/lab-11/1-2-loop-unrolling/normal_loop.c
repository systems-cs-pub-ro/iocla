#include<stdio.h>
#include<sys/time.h>

#define N (100 * 1000 * 1000)
//#define N 10

int list[N], sum;

int main()
{
    int i;
    long elapsed;
    struct timeval t0, t1;

    gettimeofday(&t0, NULL);
    /* Included some NOPs to aid identifying assembly code */
    __asm__ volatile("nop; nop; nop;");

    for (i = 0; i < N; i++)
        sum += list[i];

    __asm__ volatile("nop; nop; nop;");
    gettimeofday(&t1, NULL);

    elapsed = (t1.tv_sec - t0.tv_sec)*1000000 + t1.tv_usec - t0.tv_usec;
    //printf("sum = %d\n", sum);
    printf("Time: %ld us\n", elapsed);

    return 0;
}
