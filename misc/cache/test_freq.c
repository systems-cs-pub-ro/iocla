#include <stdio.h>
#include <stdint.h>
#include <unistd.h>

/* gcc -m32   -g ./test_freq.c  */

uint64_t rdtsc(void) {
    uint64_t result;
    __asm__ __volatile__ ("rdtsc" : "=A" (result));
    return result;
}

int main(void) {
    uint64_t ts0, ts1;    
    ts0 = rdtsc();
    sleep(1);
    ts1 = rdtsc();    
    printf("clock frequency = %llu\n", ts1 - ts0);
    return 0;
}
