#include <stdio.h>
#include <string.h>

extern int cmmmc(int a, int b);
extern int par(int size, char* str);

int main(int argc, char *argv[]) {

    int a, b;
    char str[1000];

    if (strncmp(argv[1], "0", 1) == 0) {
    	scanf("%d", &a);
    	scanf("%d", &b);
    	printf("%d\n", cmmmc(a, b));
    } else if (strncmp(argv[1], "1", 1) == 0) {
	scanf("%s", str);
    	printf("%d\n", par(strlen(str), str));
    }
    
    return 0;
}
