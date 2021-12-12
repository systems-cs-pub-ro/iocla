#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_INPUT_STRING_LEN    1000
#define MAX_WORD_LEN            100

void get_words(char *s, char **words, int number_of_words);
void sort(char **words, int number_of_words, int size);

int main() {
    char *s = (char *)calloc(MAX_INPUT_STRING_LEN, sizeof(char));
    int number_of_words;
    scanf("%d\n", &number_of_words);
    char **words = (char **)calloc(number_of_words, sizeof(char *));
    for (int i = 0; i < number_of_words; i++) {
        words[i] = (char *)calloc(MAX_WORD_LEN, sizeof(char));
    }
    fgets(s, MAX_INPUT_STRING_LEN, stdin);
    get_words(s, words, number_of_words);
    sort(words, number_of_words, sizeof(char *));
    for (int i = 0; i < number_of_words; i++) {
        printf("%s\n", words[i]);
    }
    return 0;
}
