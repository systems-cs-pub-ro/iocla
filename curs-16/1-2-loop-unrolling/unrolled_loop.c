#include<stdio.h>
#include<sys/time.h>

#define N 10000000

int list[N];
int sum = 0.0, sum1 = 0.0, sum2 = 0.0, sum3 = 0.0, sum4 = 0.0;

int main()
{


    int i;
    struct timeval t0, t1;
    gettimeofday(&t0, NULL);
    for (i = 0; i < N; i += 4)
    {
        sum1 += list[i];
        sum2 += list[i+1];
        sum3 += list[i+2];
        sum4 += list[i+3];
    }
    sum = sum1 + sum2 + sum3 + sum4;
    gettimeofday(&t1, NULL);
    long elapsed = (t1.tv_sec - t0.tv_sec)*1000000 + t1.tv_usec - t0.tv_usec;
    printf("Time: %ld us\n", elapsed);
    return 0; 
}
