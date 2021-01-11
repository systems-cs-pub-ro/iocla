/* I included the AVX header for you */
#include <immintrin.h>
#include <math.h>

void f_vector_op(float *A, float *B, float *C, float *D, int n)
{
    float sum = 0;

    /* A * B; result stored in sum */
    for (int i = 0; i < n; i++)
        sum += A[i] * B[i];

    /* Computing D */
    for (int i = 0; i < n; i++)
        D[i] = sqrt(C[i]) + sum;
}

void f_vector_op_avx(float *A, float *B, float *C, float *D, int n)
{
    /* TODO: optimise the code above, using AVX */
}