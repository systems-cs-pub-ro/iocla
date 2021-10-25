#include <stdio.h>

int i = -1; 
unsigned int u = 1; 

int main()  {
    printf("The world %s sense.\n", (i < u)?  "makes" : "does not make");
}
