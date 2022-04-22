#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void spiral(int N, char *plain, int *key, char *enc_string);

void readInput(char *filename, int *N, char *plain, int *key) {
    int i, j;
    FILE *f = fopen(filename, "r");

    /* read the plain text */
    fscanf(f, "%d", N);
    fscanf(f, "%s", plain);

    /* read the key matrix */
    plain[*N * *N] = '\0';
    for (i = 0; i < *N; i++) {
        for (j = 0; j < *N; j++) {
            fscanf(f, "%d", &(key[i * *N + j]));
        }
    }

    fclose(f);
}

void readRef(char *filename, char *ref_string) {
    int i, j;
    FILE *f = fopen(filename, "r");

    /* read the encrypted text */
    fscanf(f, "%s", ref_string);

    fclose(f);
}

void printOutput(char *filename, char *string) {
    FILE *f = fopen(filename, "w");

    fprintf(f, "%s", string);

    fclose(f);
}

int main(int argc, char **argv) {
    int i = 0;
    int N;
    float score = 0;
    char plain[10001];
    char enc_string[10001];
    char ref_string[10001];
    char input_file[30], output_file[30], ref_file[30];
    int key[1000];

    printf("--------------TASK 4--------------\n");
    for (i = 0; i <= 9; i++) {
        sprintf(input_file, "input/spiral-%d.in", i);
 
        sprintf(ref_file, "ref/spiral-%d.ref", i);
        readRef(ref_file, ref_string);

        memset(enc_string, 0, 10001);

        readInput(input_file, &N, plain, key);

        spiral(N, plain, key, enc_string);

        sprintf(output_file, "output/spiral-%d.out", i);
        printOutput(output_file, enc_string);

        if (strcmp(enc_string, ref_string)) {
            printf("TEST %d..................FAILED: 0.00p\n", i);
        } else {
            score += 3;
            printf("TEST %d..................PASSED: 3.00p\n", i);
        }
    }
   printf("TASK 4 SCORE: %.2f\n\n", score);


    return 0;
}