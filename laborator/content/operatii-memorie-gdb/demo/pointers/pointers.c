#include <stdio.h>

int main() {
    
    int a = 0;
    int *p;
    void *pv;

    p = &a;
    pv = &a;

    printf("Before p = %p\n",p);
    printf("Before &p = %p\n",&p);
    p++;  
    printf("After p = %p\n",p);
    printf("After &p = %p\n",&p);
    p++;

    printf("Before pv = %p\n",pv);
    pv++; 
    printf("After pv = %p\n",pv);
    
    printf("sizeof(void) = %d\n", sizeof(void));
    return 0;
}
