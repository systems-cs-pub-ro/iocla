#include<stdio.h>
#include<sys/time.h>

#define N 10000000
//#define N 10

 int list[N], sum;

int main()
{

    int i;
    struct timeval t0, t1;
    gettimeofday(&t0, NULL);
    for (i = 0; i < N; i++)
        sum += list[i];
    gettimeofday(&t1, NULL);
    long elapsed = (t1.tv_sec - t0.tv_sec)*1000000 + t1.tv_usec - t0.tv_usec;
    printf("Time: %ld us\n", elapsed);
    return 0; 
}
