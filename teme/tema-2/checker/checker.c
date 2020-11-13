#include "checker.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int score;

void prepare_files(char *file_prefix, char infile_name[20], char outfile_name[20], char reffile_name[20], int i)
{
    int len = strlen(file_prefix);

    memset(infile_name, 0, 20);
    memset(outfile_name, 0, 20);
    memset(reffile_name, 0, 20);
    
    file_prefix[len - 1] = '0' + i;

    strncpy(infile_name, "input/", 6);
    strncat(infile_name, file_prefix, len);
    strncat(infile_name, "_in\0", 4);

    strncpy(outfile_name, "output/", 7);
    strncat(outfile_name, file_prefix, len);
    strncat(outfile_name, "_out\0", 5);

    strncpy(reffile_name, "ref/", 4);
    strncat(reffile_name, file_prefix, len);
    strncat(reffile_name, "_ref\0", 5);
}

void close_files(FILE *infile, FILE *outfile, FILE *reffile)
{
    fclose(infile);
    fclose(outfile);
    fclose(reffile);
}

void test_otp()
{
    FILE *infile, *outfile, *reffile;
    char file_prefix[5] = "otpx",
         infile_name[20], 
         outfile_name[20],
         reffile_name[20],
         *plaintext, *key, *ciphertext, *reftext;
    int len;

    for (int i = 0; i < OTP_TESTS; i++) {
        prepare_files(file_prefix, infile_name, outfile_name, reffile_name, i);

        infile = fopen(infile_name, "r");
        outfile = fopen(outfile_name, "w+");
        reffile = fopen(reffile_name, "r");

        fscanf(infile, "%d\n", &len);

        plaintext = calloc(len, sizeof(*plaintext));
        key = calloc(len, sizeof(*key));
        ciphertext = calloc(len, sizeof(*ciphertext));
        reftext = calloc(len, sizeof(*reftext));

        fread(plaintext, sizeof(char), len, infile);
        fgetc(infile);
        fread(key, sizeof(char), len, infile);
        fgetc(infile);

        otp(ciphertext, plaintext, key, len);

        fwrite(ciphertext, sizeof(char), len, outfile);

        fread(reftext, sizeof(char), len, reffile);

        if (memcmp(ciphertext, reftext, len) == 0) {
            score += OTP_SCORE;
            printf("OTP test %d\t\t\t\t\t\tPASSED [%d/%d]\n", i, OTP_SCORE, OTP_SCORE);
        } else {
            printf("OTP test %d\t\t\t\t\t\tFAILED [0/%d]\n", i, OTP_SCORE);
        }

        close_files(infile, outfile, reffile);

        free(plaintext);
        free(ciphertext);
        free(key);
        free(reftext);
    }
}

void test_caesar()
{
    FILE *infile, *outfile, *reffile;
    char file_prefix[10] = "caesarx",
         infile_name[30], 
         outfile_name[30],
         reffile_name[30],
         *plaintext, *ciphertext, *reftext;
    int len, key;

    for (int i = 0; i < CAESAR_TESTS; i++) {
        prepare_files(file_prefix, infile_name, outfile_name, reffile_name, i);

        infile = fopen(infile_name, "r");
        outfile = fopen(outfile_name, "w+");
        reffile = fopen(reffile_name, "r");

        fscanf(infile, "%d\n", &len);

        plaintext = calloc(len, sizeof(*plaintext));
        ciphertext = calloc(len, sizeof(*ciphertext));
        reftext = calloc(len, sizeof(*reftext));

        fread(plaintext, sizeof(char), len, infile);
        fgetc(infile);
        fscanf(infile, "%d\n", &key);
        fgetc(infile);

        caesar(ciphertext, plaintext, key, len);

        fwrite(ciphertext, sizeof(char), len, outfile);

        fread(reftext, sizeof(char), len, reffile);

        if (memcmp(ciphertext, reftext, len) == 0) {
            score += CAESAR_SCORE;
            printf("CAESAR test %d\t\t\t\t\t\tPASSED [%d/%d]\n", i, CAESAR_SCORE, CAESAR_SCORE);
        } else {
            printf("CAESAR test %d\t\t\t\t\t\tFAILED [0/%d]\n", i, CAESAR_SCORE);
        }

        close_files(infile, outfile, reffile);

        free(plaintext);
        free(ciphertext);
        free(reftext);
    }
}

void test_vigenere()
{
    FILE *infile, *outfile, *reffile;
    char file_prefix[10] = "vigenerex",
         infile_name[30], 
         outfile_name[30],
         reffile_name[30],
         *plaintext, *ciphertext, *reftext, *key;
    int plain_len, key_len;

    for (int i = 0; i < VIGENERE_TESTS; i++) {
        prepare_files(file_prefix, infile_name, outfile_name, reffile_name, i);

        infile = fopen(infile_name, "r");
        outfile = fopen(outfile_name, "w+");
        reffile = fopen(reffile_name, "r");

        fscanf(infile, "%d %d\n", &plain_len, &key_len);

        plaintext = calloc(plain_len, sizeof(*plaintext));
        ciphertext = calloc(plain_len, sizeof(*ciphertext));
        reftext = calloc(plain_len, sizeof(*reftext));
        key = calloc(key_len, sizeof(*key));

        fread(plaintext, sizeof(char), plain_len, infile);
        fgetc(infile);
        fread(key, sizeof(char), key_len, infile);
        fgetc(infile);

        vigenere(ciphertext, plaintext, plain_len, key, key_len);

        fwrite(ciphertext, sizeof(char), plain_len, outfile);

        fread(reftext, sizeof(char), plain_len, reffile);

        if (memcmp(ciphertext, reftext, plain_len) == 0) {
            score += VIGENERE_SCORE;
            printf("VIGENERE test %d\t\t\t\t\t\tPASSED [%d/%d]\n", i, VIGENERE_SCORE, VIGENERE_SCORE);
        } else {
            printf("VIGENERE test %d\t\t\t\t\t\tFAILED [0/%d]\n", i, VIGENERE_SCORE);
        }

        close_files(infile, outfile, reffile);

        free(plaintext);
        free(ciphertext);
        free(reftext);
        free(key);
    }
}

void test_bin_to_hex()
{
    FILE *infile, *outfile, *reffile;
    char file_prefix[10] = "bintohexx",
         infile_name[30], 
         outfile_name[30],
         reffile_name[30],
         *plaintext, *ciphertext, *reftext;
    int len;

    for (int i = 0; i < BIN_TO_HEX_TESTS; i++) {
        prepare_files(file_prefix, infile_name, outfile_name, reffile_name, i);

        infile = fopen(infile_name, "r");
        outfile = fopen(outfile_name, "w+");
        reffile = fopen(reffile_name, "r");

        fscanf(infile, "%d\n", &len);

        plaintext = calloc(len, sizeof(*plaintext));
        ciphertext = calloc(len, sizeof(*ciphertext));
        reftext = calloc(len, sizeof(*reftext));

        fread(plaintext, sizeof(char), len, infile);
        fgetc(infile);

        bin_to_hex(ciphertext, plaintext, len);

        fwrite(ciphertext, sizeof(char), len, outfile);

        fread(reftext, sizeof(char), len, reffile);

        if (memcmp(ciphertext, reftext, len) == 0) {
            score += BIN_TO_HEX_SCORE;
            printf("BIN_TO_HEX test %d\t\t\t\t\tPASSED [%d/%d]\n", i, BIN_TO_HEX_SCORE, BIN_TO_HEX_SCORE);
        } else {
            printf("BIN_TO_HEX test %d\t\t\t\t\tFAILED [0/%d]\n", i, BIN_TO_HEX_SCORE);
        }

        close_files(infile, outfile, reffile);

        free(plaintext);
        free(ciphertext);
        free(reftext);
    }
}

void test_my_strstr()
{
    FILE *infile, *outfile, *reffile;
    char file_prefix[10] = "strstrx",
         infile_name[30], 
         outfile_name[30],
         reffile_name[30],
         *plaintext, *substr;
    int len, substr_len;
    int *substr_index;
    int *reftext;

    for (int i = 0; i < STRSTR_TESTS; i++) {
        prepare_files(file_prefix, infile_name, outfile_name, reffile_name, i);

        infile = fopen(infile_name, "r");
        outfile = fopen(outfile_name, "w+");
        reffile = fopen(reffile_name, "r");

        fscanf(infile, "%d %d\n", &len, &substr_len);

        plaintext = calloc(len, sizeof(*plaintext));
        substr = calloc(substr_len, sizeof(*substr));
        substr_index = calloc(1, sizeof(*substr_index));
        reftext = calloc(1, sizeof(*reftext));

        fread(plaintext, sizeof(char), len, infile);
        fgetc(infile);
        fread(substr, sizeof(char), substr_len, infile);
        fgetc(infile);

        my_strstr(substr_index, plaintext, substr, len, substr_len);

        fprintf(outfile, "%d\n", *substr_index);

        fscanf(reffile, "%d", reftext);

        if (*substr_index == *reftext) {
            score += STRSTR_SCORE;
            printf("STRSTR test %d\t\t\t\t\t\tPASSED [%d/%d]\n", i, STRSTR_SCORE, STRSTR_SCORE);
        } else {
            printf("STRSTR test %d\t\t\t\t\t\tFAILED [0/%d]\n", i, STRSTR_SCORE);
        }

        close_files(infile, outfile, reffile);

        free(plaintext);
        free(substr_index);
        free(reftext);
        free(substr);
    }
}

int main(int argc, char *argv[])
{
    printf("--------------------------------------------------------------------\n");
    printf("----------------------- TEMA 2 - IOCLA - 2020 ----------------------\n");
    printf("--------------------------------------------------------------------\n");

    if (argc == 1 || !strncmp(argv[1], "1", 1)) {
        test_otp();
        printf("--------------------------------------------------------------------\n");
    }

    if (argc == 1 || !strncmp(argv[1], "2", 1)) {
        test_caesar();
        printf("--------------------------------------------------------------------\n");
    }

    if (argc == 1 || !strncmp(argv[1], "3", 1)) {
        test_vigenere();
        printf("--------------------------------------------------------------------\n");
    }

    if (argc == 1 || !strncmp(argv[1], "4", 1)) {
        test_my_strstr();
        printf("--------------------------------------------------------------------\n");
    }

    if (argc == 1 || !strncmp(argv[1], "5", 1)) {
        test_bin_to_hex();
        printf("--------------------------------------------------------------------\n");
    }

    if (access("README", F_OK) != -1) {
        score += 10;
        printf("README\t\t\t\t\t\t      EXISTS [10/10]\n");
    } else {
        printf("README\t\t\t\t\t\t    NOT FOUND [0/10]\n");
    }
    printf("--------------------------------------------------------------------\n");

    printf("SCORE: [%d/%d]\n", score, MAX_SCORE);

    return 0;
}
