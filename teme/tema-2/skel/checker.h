#ifndef CHECKER_H
#define CHECKER_H

#define ROTP_TESTS          10
#define AGES_TESTS          10
#define COLUMNAR_TESTS      10
#define CACHE_TESTS         10

#define ROTP_SCORE          1.0
#define AGES_SCORE          1.5
#define COLUMNAR_SCORE      2.5
#define CACHE_SCORE         4.0

#define CACHE_LINES  100
#define CACHE_LINE_SIZE 8

#define MAX_SCORE           100.0

struct my_struct{
    short day;
    short month;
    int year;
} __attribute__((packed));

void rotp(char *ciphertext, char *plaintext, char *key, int len);

void ages(int len, struct my_struct* present, struct my_struct* dates, int* all_ages);

void columnar_transposition(int key[], char *haystack, char *ciphertext);

void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);

#endif