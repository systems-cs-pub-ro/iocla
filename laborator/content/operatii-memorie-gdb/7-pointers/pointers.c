#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <stdlib.h>

#define SIGN(X) (((X) > 0) - ((X) < 0))

int test_strcpy(const char *src, size_t size);
int test_memcpy(const char *src, size_t size);


int my_strcmp(const char *s1, const char *s2);
void *my_memcpy(void *dest, const void *src, size_t n);
char *my_strcpy(char *dest, const char *src);

int main() {
    char s1[] = "Abracadabra";
    char s2[] = "Abracababra";
    char src[] = "Learn IOCLA, you must!";

    (void) s1;
    (void) s2;

    /*
    Decomentati pe rand cate un assert pe masura ce implementati o functie.
    Daca functia voastra este implementata corect atunci asertia se va realiza
    cu succes. In caz contrar, programul va crapa.
    */
    // assert(SIGN(my_strcmp(s1, s2)) == SIGN(strcmp(s1, s2)));
    // assert(test_strcpy(src, sizeof(src)));
    // assert(test_memcpy(src, sizeof(src)));

    return 0;
}


/* USED FOR TESTING! DO NOT MODIFY! */

int test_strcpy(const char *src, size_t size) {
    char *dest1 = malloc(size);
    char *dest2 = malloc(size);

    strcpy(dest1, src);
    my_strcpy(dest2, src);

    if (strcmp(dest1, dest2)) {
        free(dest1);
        free(dest2);
        return 0;
    }

    free(dest1);
    free(dest2);

    return 1;
}

int test_memcpy(const char *src, size_t size) {
    char *dest1 = malloc(size);
    char *dest2 = malloc(size);

    memcpy(dest1, src, size);
    my_memcpy(dest2, src, size);

    for (size_t i = 0; i < size; ++i) {
        if (*dest1 != *dest2) {
            free(dest1);
            free(dest2);
            return 0;
        }
    }

    free(dest1);
    free(dest2);

    return 1;
}
