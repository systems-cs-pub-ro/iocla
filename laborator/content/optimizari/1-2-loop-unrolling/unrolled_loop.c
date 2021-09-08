#include<stdio.h>
#include<sys/time.h>

#define N (100 * 1000 * 1000)

int list[N];
int sum, sum1, sum2, sum3, sum4;

int main()
{
    int i;
    long elapsed;
    struct timeval t0, t1;

    gettimeofday(&t0, NULL);
    /* Included some NOPs to aid identifying assembly code */
    __asm__ volatile("nop; nop; nop;");

    for (i = 0; i < N; i += 4)
    {
        sum1 += list[i];
        sum2 += list[i+1];
        sum3 += list[i+2];
        sum4 += list[i+3];
    }
    sum = sum1 + sum2 + sum3 + sum4;

    __asm__ volatile("nop; nop; nop;");
    gettimeofday(&t1, NULL);

    elapsed = (t1.tv_sec - t0.tv_sec)*1000000 + t1.tv_usec - t0.tv_usec;
    //printf("sum = %d\n", sum);
    printf("Time: %ld us\n", elapsed);

    return 0;
}
