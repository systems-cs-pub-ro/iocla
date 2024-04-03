#include <stdio.h>
#include <stdlib.h>

int main()
{
    int i;
    unsigned int seed =1712157212;
    srandom(seed);
    printf("%d\n", random() + 1337);
    return 0;
}
