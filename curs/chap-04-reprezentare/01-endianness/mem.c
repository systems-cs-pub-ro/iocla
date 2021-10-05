#include <stdio.h>

void print_ptr(char*what, char*p, int n)
{
   printf("== %s ==\n", what); 
   for(int i=0; i < n; i++){ 
       printf("%x: %hx\n", (unsigned int)p+i, p[i] & 0xff); 
   }
}
int main(void)
{
    unsigned int a = 4127;
    int b = -27714;
    unsigned int c = 0x12345678;
    char d[] = {'I', 'O', 'C', 'L', 'A'};
    
    print_ptr("a", (char*)&a, sizeof(unsigned int)); 
    print_ptr("b", (char*)&b, sizeof(int)); 
    print_ptr("c", (char*)&c, sizeof(unsigned int)); 
    print_ptr("d", (char*)&d, sizeof(d)); 


    return 0;
}
