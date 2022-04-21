#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void simple(int n, char* plain, char* enc_string, int step);

void readInput(char *filename, int *len, int *step, char* plain) {
    int i, j;

    FILE *f = fopen(filename, "r");

    /* read the plain text */
    fscanf(f, "%d %d", len, step);
    fscanf(f, "%s", plain);
    fclose(f);
}

void readRef(char *filename, char *ref_string) {
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
    int len, step; 
    float score = 0;

    char plain[10001];
    char enc_string[10001];
    char ref_string[10001];
    char input_file[30], output_file[30], ref_file[30];

    printf("--------------TASK 1--------------\n");
    for (i = 0; i < 10; i++) {
        sprintf(input_file, "input/simple-%d.in", i);
        readInput(input_file, &len, &step, plain);

        memset(ref_string, 0, 10001);
        sprintf(ref_file, "ref/simple-%d.ref", i);
        readRef(ref_file, ref_string);

        memset(enc_string, 0, 10001);
        simple(len, plain, enc_string, step);

        sprintf(output_file, "output/simple-%d.out", i);
        printOutput(output_file, enc_string);

        if (strcmp(enc_string, ref_string)) {
            printf("TEST %d..................FAILED: 0.00p\n", i);
        } else {
            score += 1;
            printf("TEST %d..................PASSED: 1.00p\n", i);
        }
    }
    printf("TASK 1 SCORE: %.2f\n\n", score);

    return 0;
}