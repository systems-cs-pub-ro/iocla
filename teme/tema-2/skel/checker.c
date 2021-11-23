#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "checker.h"

double score;
int len_cheie;
int len_haystack;

void prepare_files(char *file_prefix, char infile_name[20], char outfile_name[20], char reffile_name[20], int i, int task4)
{
    int len = strlen(file_prefix);

    if (!task4)
        memset(infile_name, 0, 20);

    memset(outfile_name, 0, 20);
    memset(reffile_name, 0, 20);

    file_prefix[len - 1] = '0' + i;

    if (!task4)
    {
        strncpy(infile_name, "input/", 6);
        strncat(infile_name, file_prefix, len);
        strncat(infile_name, "_in\0", 4);
    }

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

void test_rotp()
{
    FILE *infile, *outfile, *reffile;
    char file_prefix[6] = "rotpx",
         infile_name[25],
         outfile_name[25],
         reffile_name[25],
         *plaintext, *key, *ciphertext, *reftext;
    int len;

    for (int i = 0; i < ROTP_TESTS; i++)
    {
        prepare_files(file_prefix, infile_name, outfile_name, reffile_name, i, 0);

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

        rotp(ciphertext, plaintext, key, len);

        fwrite(ciphertext, sizeof(char), len, outfile);

        fread(reftext, sizeof(char), len, reffile);

        if (memcmp(ciphertext, reftext, len) == 0)
        {
            score += ROTP_SCORE;
            printf("ROTP test %d\t\t\t\t\tPASSED    %.1f / %.1f  \n", i, ROTP_SCORE, ROTP_SCORE);
        }
        else
        {
            printf("ROTP test %d\t\t\t\t\tFAILED    0 / %.1f  \n", i, ROTP_SCORE);
        }

        close_files(infile, outfile, reffile);

        free(plaintext);
        free(ciphertext);
        free(key);
        free(reftext);
    }
}

void test_ages()
{
    FILE *infile, *outfile, *reffile;
    char file_prefix[6] = "agesx",
         infile_name[20],
         outfile_name[20],
         reffile_name[20];
    int len;
    struct my_struct present;
    for (int i = 0; i < AGES_TESTS; i++)
    {
        prepare_files(file_prefix, infile_name, outfile_name, reffile_name, i, 0);

        infile = fopen(infile_name, "r");
        outfile = fopen(outfile_name, "w+");
        reffile = fopen(reffile_name, "r");

        struct my_struct *dates = malloc(30 * sizeof(struct my_struct));

        int *all_ages = malloc(30 * sizeof(int));
        int *ref_ages = malloc(30 * sizeof(int));

        fscanf(infile, "%d", &len);
        fscanf(infile, "%hd%hd%d", &present.day, &present.month, &present.year);
        for (int j = 0; j < len; j++)
        {
            fscanf(infile, "%hd%hd%d", &dates[j].day, &dates[j].month, &dates[j].year);
            fscanf(reffile, "%d", &ref_ages[j]);
        }

        ages(len, &present, dates, all_ages);

        int verif = 0;
        for (int j = 0; j < len; j++)
        {
            fprintf(outfile, "%d\n", all_ages[j]);
            if (all_ages[j] != ref_ages[j])
                verif++;
        }

        if (!verif)
        {
            score += AGES_SCORE;
            printf("AGES test %d\t\t\t\t\tPASSED    %.1f / %.1f  \n", i, AGES_SCORE, AGES_SCORE);
        }
        else
        {
            printf("AGES test %d\t\t\t\t\tFAILED    0 / %.1f  \n", i, AGES_SCORE);
        }

        close_files(infile, outfile, reffile);

        free(dates);
        free(all_ages);
        free(ref_ages);
    }
}

void test_column()
{
    FILE *infile, *outfile, *reffile;
    char file_prefix[6] = "colux",
         infile_name[25],
         outfile_name[25],
         reffile_name[25],
         *plaintext, *key, *ciphertext, *reftext;
    int len_plain, len_key;

    for (int i = 0; i < COLUMNAR_TESTS; i++)
    {
        prepare_files(file_prefix, infile_name, outfile_name, reffile_name, i, 0);

        infile = fopen(infile_name, "r");
        outfile = fopen(outfile_name, "w+");
        reffile = fopen(reffile_name, "r");

        fscanf(infile, "%d %d\n", &len_plain, &len_key);

        plaintext = calloc(len_plain + 1, sizeof(*plaintext));
        key = calloc(len_key + 1, sizeof(*key));
        ciphertext = calloc(len_plain, sizeof(*ciphertext));
        reftext = calloc(len_plain, sizeof(*reftext));

        fread(plaintext, sizeof(char), len_plain, infile);
        fgetc(infile);
        fgetc(infile);
        fread(key, sizeof(char), len_key, infile);
        fgetc(infile);
        fgetc(infile);

        int *cheie_fin = malloc(len_key * sizeof(int));
        for (int i = 0; i < len_key; i++)
        {
            int minim = 0;
            for (int j = 0; j < len_key; j++)
            {
                if (key[j] < key[minim])
                {
                    minim = j;
                }
            }
            cheie_fin[i] = minim;
            key[minim] = '}';
        }
        len_haystack = len_plain;
        len_cheie = len_key;
        columnar_transposition(cheie_fin, plaintext, ciphertext);

        fwrite(ciphertext, sizeof(char), len_plain, outfile);

        fread(reftext, sizeof(char), len_plain, reffile);

        if (memcmp(ciphertext, reftext, len_plain) == 0)
        {
            score += COLUMNAR_SCORE;
            printf("COLUMNAR test %d\t\t\t\t\tPASSED    %.1f / %.1f  \n", i, COLUMNAR_SCORE, COLUMNAR_SCORE);
        }
        else
        {
            printf("COLUMNAR test %d\t\t\t\t\tFAILED    0 / %.1f  \n", i, COLUMNAR_SCORE);
        }

        close_files(infile, outfile, reffile);

        free(plaintext);
        free(ciphertext);
        free(key);
        free(reftext);
    }
}

void test_cache()
{
    FILE *infile, *outfile, *reffile;
    char file_prefix[7] = "cachex",
         infile_name[20],
         outfile_name[20],
         reffile_name[20];
    unsigned long i = 0, j = 0;
    char reg;
    unsigned long memory0_start = 0, memory1_start = 0;
    char memory0[16 * 16 + 8];
    char memory1[48 * 48 + 8];

    // Make sure the first valid address is always ending in 000 (divisible with 8).
    for (i = 0; i < 8; i++)
    {
        if (((unsigned long)&(memory0[i])) % 8 == 0) {
            memory0_start = i;
        }
        if (((unsigned long)&(memory1[i])) % 8 == 0)
        {
            memory1_start = i;
        }

    }

    // Read the memory content.
    infile = fopen("input/cacheA_in", "r");
    for (j = memory0_start; j < 16 * 16 + memory0_start; j++)
    {
        fscanf(infile, "%hhu", &(memory0[j]));
    }
    fclose(infile);
    infile = fopen("input/cacheB_in", "r");
    for (j = memory1_start; j < 48 * 48 + memory1_start; j++)
    {
        fscanf(infile, "%hhu", &(memory1[j]));
    }
    fclose(infile);

    // Initialize empty tags vector and create empty cache
    char **tags = malloc(CACHE_LINES * sizeof(char *));
    for (i = 0; i < CACHE_LINES; i++)
        tags[i] = 0;

    // Initialize empty cache
    char cache[CACHE_LINES][CACHE_LINE_SIZE];
    for (i = 0; i < CACHE_LINES; i++)
    {
        for (j = 0; j < CACHE_LINE_SIZE; j++)
        {
            cache[i][j] = 0;
        }
    }

    // Build the address we want to get data from. CHANGE x and y to move trough memory.
    int x[10] = {0, 2, 2, 0, 14, 47, 22, 10, 10, 47};
    int y[10] = {1, 4, 4, 1, 14, 3, 25, 0, 0, 47};
    int to_replace[10] = {7, 7, 17, 12, 13, 14, 2, 15, 10, 11};

    /*
     Testing. We are interested in checking the value brought in the register.
     Also, we need to check that the tag was modified and a line was brought
     from memory to cache in case of a CACHE MISS.
     */
    int pass;
    char *address;
    for (i = 0; i < 10; i++)
    {
        prepare_files(file_prefix, infile_name, outfile_name, reffile_name, i, 1);

        outfile = fopen(outfile_name, "w+");
        reffile = fopen(reffile_name, "r");

        int verif = 0;
        int check;
        pass = 0;
        if (i < 5)
            address = (char *)(memory0 + memory0_start + 16 * x[i] + y[i]);
        else
            address = (char *)(memory1 + memory1_start + 48 * x[i] + y[i]);
        load(&reg, tags, cache, address, to_replace[i]);

        fprintf(outfile, "%hhu\n", reg);
        fscanf(reffile, "%u", &check);
        if (check != reg)
            verif = 1;
        for (j = 0; j < CACHE_LINE_SIZE; j++)
        {
            fprintf(outfile, "%hhu", cache[to_replace[i]][j]);
            fscanf(reffile, "%u", &check);
            if (check != cache[to_replace[i]][j])
                verif = 1;
            if (j < CACHE_LINE_SIZE - 1)
                fprintf(outfile, " ");
        }
        fprintf(outfile, "\n");
        fclose(outfile);
        fclose(reffile);

        if (!verif)
        {
            score += CACHE_SCORE;
            printf("CACHE test %ld\t\t\t\t\tPASSED    %.1f / %.1f  \n", i, CACHE_SCORE, CACHE_SCORE);
        }
        else
        {
            printf("CACHE test %ld\t\t\t\t\tFAILED    0 / %.1f  \n", i, CACHE_SCORE);
        }
    }

}

int main(int argc, char *argv[])
{
    printf("--------------------------------------------------------------------\n");
    printf("----------------------- TEMA 2 - IOCLA - 2021 ----------------------\n");
    printf("--------------------- 22 NOV 2021 - 12 DEC 2021 --------------------\n");
    printf("--------------------------------------------------------------------\n");
    printf("--------------- Introducere in limbajul de asamblare ---------------\n");
    printf("--------------- Rolul registrelor. Moduri de adresare --------------\n");
    printf("-------------------- Structuri. Vectori. Siruri --------------------\n");
    printf("--------------------------------------------------------------------\n");

    if (argc == 1 || !strncmp(argv[1], "1", 1))
    {
        test_rotp();
        printf("--------------------------------------------------------------------\n");
    }

    if (argc == 1 || !strncmp(argv[1], "2", 1))
    {
        test_ages();
        printf("--------------------------------------------------------------------\n");
    }

    if (argc == 1 || !strncmp(argv[1], "3", 1))
    {
        test_column();
        printf("--------------------------------------------------------------------\n");
    }

    if (argc == 1 || !strncmp(argv[1], "4", 1))
    {
        test_cache();
        printf("--------------------------------------------------------------------\n");
    }

    if (access("README", F_OK) != -1)
    {
        score += 10;
        printf("README\t\t\t\t\tI SEE A README :)) 10 / 10 \n");
    }
    else
    {
        printf("README\t\t\t\t\tNO README? WHY? :(( 0 / 10 \n");
    }
    printf("--------------------------------------------------------------------\n");

    if (score != MAX_SCORE)
        printf("YOUR SCORE:  %.1f / %.1f  :(( Try harder! Sleep is for the weak!\n", score, MAX_SCORE);
    else
        printf("YOUR SCORE:  %.1f / %.1f  :)) Well done! Sweet dreams! \n", score, MAX_SCORE);

    printf("--------------------------------------------------------------------\n");

    return 0;
}
