#include <stdio.h>

int add(int a, int b) {
    return a + b;
}

int substract(int a, int b) {
    return a - b;
}

int substract2(int a, int b) {
    return a - b;
}
int operation(int x, int y, int (*func) (int, int)) {
    return func(x, y);
}

int main() {
    int (*minus)(int, int) = substract;
    printf("%d\n", minus(10,5));

    printf("%d\n", operation(10, 5, minus));

    if(minus == substract) {
        printf("Equal\n");
    } else {
        printf("Not equal\n");
    }

    return 0;
}
