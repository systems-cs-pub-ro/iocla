#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void beaufort(int len_plain, char *plain, int len_key, char *key, char tabula_recta[26][26], char *enc);

void readInput(char *filename, int *len_plain, int *len_key, char *plain, char *key, char tabula_recta[26][26]) {
    int i, j;

    FILE *f = fopen(filename, "r");
    /* read the plain text */
    fscanf(f, "%d %d", len_plain, len_key);
    fscanf(f, "%s", plain);
    /* read the key */
    fscanf(f, "%s", key);
    fclose(f);

    /* read the tabula recta */
    f = fopen("input/tabula_recta", "r");
    for (i = 0; i < 26; i++) {
        for (j = 0; j < 26; j++) {
            fscanf(f, "%c", &(tabula_recta[i][j]));
            fgetc(f);
        }
    }
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
    int len_plain, len_key; 
    float score = 0;
    char key[10001];
    char plain[10001];
    char tabula_recta[26][26];
    char enc_string[10001];
    char ref_string[10001];
    char input_file[30], output_file[30], ref_file[30];

    printf("--------------TASK 3--------------\n");
    for (i = 0; i < 10; i++) {
        sprintf(input_file, "input/beaufort-%d.in", i);
        readInput(input_file, &len_plain, &len_key, plain, key, tabula_recta);

        memset(ref_string, 0, 10001);
        sprintf(ref_file, "ref/beaufort-%d.ref", i);
        readRef(ref_file, ref_string);

        memset(enc_string, 0, 10001);
        beaufort(len_plain, plain, len_key, key, tabula_recta, enc_string);

        sprintf(output_file, "output/beaufort-%d.out", i);
        printOutput(output_file, enc_string);

        if (strcmp(enc_string, ref_string)) {
            printf("TEST %d..................FAILED: 0.00p\n", i);
        } else {
            score += 2.5;
            printf("TEST %d..................PASSED: 2.50p\n", i);
        }
    }
    printf("TASK 3 SCORE: %.2f\n\n", score);

    return 0;
}