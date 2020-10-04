#include<stdio.h>
#include<sys/time.h>
#include<stdlib.h>

#define N 1000000

extern int computeLength(char* str);
extern int computeLength2(char* str);

void main()
{
    char a[N];
    FILE *f = fopen("file.txt", "rb");
    fread(a, N, 1, f);
    fclose(f);
    a[N] = 0;
    struct timeval t0, t1;
    gettimeofday(&t0, NULL);
    int len = computeLength(a);
    gettimeofday(&t1, NULL);
    long elapsed = (t1.tv_sec - t0.tv_sec)*1000000 + t1.tv_usec - t0.tv_usec;
    printf("len = %d\n", len);
    printf("Time = %ld\n", elapsed);

    struct timeval t3, t4;
    gettimeofday(&t3, NULL);
    int len2 = computeLength2(a);
    gettimeofday(&t4, NULL);
    long elapsed2 = (t4.tv_sec - t3.tv_sec)*1000000 + t4.tv_usec - t3.tv_usec;
    printf("len = %d\n", len2);
    printf("Time = %ld\n", elapsed2);
}
