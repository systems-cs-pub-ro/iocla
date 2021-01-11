#include <stdlib.h>
#include <stdio.h>
#include <sys/time.h>

#define N_f 8000
#define N_i 10000000
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
    int ok = 1;

    printf("Initializing the float vectors\n");
    A_f = malloc(N_f * sizeof(*A_f));
    B_f = malloc(N_f * sizeof(*B_f));
    C_f = malloc(N_f * sizeof(*C_f));
    D_f = calloc(N_f, sizeof(*D_f));
    D_f_avx = calloc(N_f, sizeof(*D_f_avx));

    for (int i = 0; i < N_f; i++)
    {
        A_f[i] = i % 1000 * 0.5;
        B_f[i] = i % 1000 * 1.9;
        C_f[i] = i % 1000 * 2.713;
    }

    printf("Doing the math and measuring runtime for n = %d, %d times\n", N_f, N_i / N_f);

    gettimeofday(&t1, NULL);
    for (int i = 0; i < N_i / N_f; i++)
        f_vector_op(A_f, B_f, C_f, D_f, N_f);
    gettimeofday(&t2, NULL);
    t_neopt = MSTIME(t1, t2);
    printf("Runtime for non-AVX code: %fs\n", t_neopt);

    gettimeofday(&t1, NULL);
    for (int i = 0; i < N_i / N_f; i++)
        f_vector_op_avx(A_f, B_f, C_f, D_f_avx, N_f);
    gettimeofday(&t2, NULL);
    t_opt = MSTIME(t1, t2);
    printf("Runtime for AVX code: %fs\n", t_opt);

    for (int i = 0; i < N_f; i++) {
        if (D_f[i] - eps > D_f_avx[i] || D_f_avx[i] > D_f[i] + eps)
        {
            printf("AVX function incorrect or not implemented\n");
            ok = 0;
            break;
        }
    }

    if (ok)
        printf("Speed-up for C (t_neopt/ t_opt): %f\n", t_neopt / t_opt);

    printf("Freeing float vectors\n\n");
    free(A_f);
    free(B_f);
    free(C_f);
    free(D_f);
    free(D_f_avx);

    ok = 1;

    printf("Initializing the int vectors\n");
    A_i = malloc(N_i * sizeof(*A_i));
    B_i = malloc(N_i * sizeof(*B_i));
    C_i = calloc(N_i, sizeof(*C_i));
    C_i_avx = calloc(N_i, sizeof(*C_i_avx));

    for (int i = 0; i < N_i; i++)
    {
        A_i[i] = i % 1000;
        B_i[i] = i % 1000 * 2;
    }

    printf("Doing the math and measuring runtime for n = %d\n", N_i);
    gettimeofday(&t1, NULL);
    i_vector_op(A_i, B_i, C_i, N_i);
    gettimeofday(&t2, NULL);
    t_neopt = MSTIME(t1, t2);
    printf("Runtime for non-AVX code: %fs\n", t_neopt);

    gettimeofday(&t1, NULL);
    i_vector_op_avx(A_i, B_i, C_i_avx, N_i);
    gettimeofday(&t2, NULL);
    t_opt = MSTIME(t1, t2);
    printf("Runtime for AVX code: %fs\n", t_opt);

    for (int i = 0; i < N_i; i++)
        if (C_i_avx[i] != C_i[i])
        {
            printf("AVX function incorrect or not implemented\n");
            ok = 0;
            break;
        }

    if (ok)
        printf("Speed-up for ASM (t_neopt/ t_opt): %f\n", t_neopt / t_opt);

    printf("Freeing int vectors\n");
    free(A_i);
    free(B_i);
    free(C_i);
    free(C_i_avx);

    return 0;
}