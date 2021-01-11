#include <stdlib.h>
#include <stdio.h>
#include <sys/time.h>

#define N 10000000
#define MSTIME(t1, t2) ((double)((t2).tv_usec - (t1).tv_usec) / 1000000 + (double)((t2).tv_sec - (t1).tv_sec))
#define eps 0.00001

void f_vector_op(float *A, float *B, float *C, float *D, int n);
void i_vector_op(int *A, int *B, int *C, int n);

void f_vector_op_avx(float *A, float *B, float *C, float *D, int n);
void i_vector_op_avx(int *A, int *B, int *C, int n);

int main(void)
{
    float *A_f, *B_f, *C_f, *D_f, *D_f_avx, t_neopt, t_opt;
    int *A_i, *B_i, *C_i, *C_i_avx;
    struct timeval t1, t2;

    printf("Initializing the float vectors\n");
    A_f = malloc(N * sizeof(*A_f));
    B_f = malloc(N * sizeof(*B_f));
    C_f = malloc(N * sizeof(*C_f));
    D_f = calloc(N, sizeof(*D_f));
    D_f_avx = calloc(N, sizeof(*D_f_avx));

    for (int i = 0; i < N; i++)
    {
        A_f[i] = i % 1000 * 0.5;
        B_f[i] = i % 1000 * 1.9;
        C_f[i] = i % 1000 * 2.713;
    }

    printf("Doing the math and measuring runtime for n = %d\n", N);

    gettimeofday(&t1, NULL);
    f_vector_op(A_f, B_f, C_f, D_f, N);
    gettimeofday(&t2, NULL);
    t_neopt = MSTIME(t1, t2);
    printf("Runtime for non-AVX code: %fs\n", t_neopt);

    gettimeofday(&t1, NULL);
    f_vector_op_avx(A_f, B_f, C_f, D_f_avx, N);
    gettimeofday(&t2, NULL);
    t_opt = MSTIME(t1, t2);
    printf("Runtime for AVX code: %fs\n", t_opt);

    printf("Speed-up (t_neopt/ t_opt): %f\n", t_neopt / t_opt);

    for (int i = 0; i < N; i++)
        if (D_f[i] + eps < D_f_avx[i] && D_f_avx[i] < D_f[i] - eps)
        {
            printf("AVX function incorrect or not implemented\n");
            break;
        }

    printf("Freeing float vectors\n\n");
    free(A_f);
    free(B_f);
    free(C_f);
    free(D_f);
    free(D_f_avx);

    printf("Initializing the int vectors\n");
    A_i = malloc(N * sizeof(*A_i));
    B_i = malloc(N * sizeof(*B_i));
    C_i = calloc(N, sizeof(*C_i));
    C_i_avx = calloc(N, sizeof(*C_i_avx));

    for (int i = 0; i < N; i++)
    {
        A_i[i] = i % 1000;
        B_i[i] = i % 1000 * 2;
    }

    printf("Doing the math and measuring runtime for n = %d\n", N);
    gettimeofday(&t1, NULL);
    i_vector_op(A_i, B_i, C_i, N);
    gettimeofday(&t2, NULL);
    t_neopt = MSTIME(t1, t2);
    printf("Runtime for non-AVX code: %fs\n", t_neopt);

    gettimeofday(&t1, NULL);
    i_vector_op_avx(A_i, B_i, C_i_avx, N);
    gettimeofday(&t2, NULL);
    t_opt = MSTIME(t1, t2);
    printf("Runtime for AVX code: %fs\n", t_opt);

    printf("Speed-up (t_neopt/ t_opt): %f\n", t_neopt / t_opt);

    for (int i = 0; i < N; i++)
        if (C_i_avx[i] != C_i[i])
        {
            printf("AVX function incorrect or not implemented\n");
            break;
        }
    printf("Freeing int vectors\n");
    free(A_i);
    free(B_i);
    free(C_i);
    free(C_i_avx);

    return 0;
}