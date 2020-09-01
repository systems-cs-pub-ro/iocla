#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

static unsigned long long rdtscp(void)
{
  unsigned int hi, lo;
  __asm__ __volatile__("rdtscp" : "=a"(lo), "=d"(hi));
  return (unsigned long long)lo | ((unsigned long long)hi << 32);
}

/*
  all size values are powers of 2
  MEMSIZE 33 implies (1L << 33) = 8Gi of size 8 bytes => 64GiB 
  PROCSIZE 29 implies 512Mi 

  xor_cache.png and xor_cache.pdf - sample outputs
  xor_cache.plot - gnuplot script to generate graphs 
 */
#define MEMSIZE  30
#define PROCSIZE  29


unsigned long long *a, stride, before, after, rez; 
unsigned long long i, rndx, rnda, rndc;
unsigned long long proc;


void main()
{
 
  a = malloc((1LL << MEMSIZE) * sizeof(unsigned long long));
  if(a == NULL){
    printf("Could not allocate %lld (0x%llx) bytes\n",
	   (1LL << MEMSIZE) * sizeof(unsigned long long),
	   (1LL << MEMSIZE) * sizeof(unsigned long long));
    exit(1);
  }
   
  stride = 9; // 2^9 * 8 bytes = 4K  
  while(stride <= MEMSIZE-1){
    
    rez = 0xAAAAAAAAAAAAAAAA;
    proc = 0;
    before = rdtscp(); 
    while(proc < (1LL << PROCSIZE)){
      for(i = 0; i < (1LL << MEMSIZE); i = i + (1LL << stride)){
	rez ^= a[i];
      }
      proc += (1LL << (MEMSIZE - stride)); 
    }
    
    after = rdtscp();
    printf("stride= %lld cycles= %lld\n", (stride+3), (after - before));
    fflush(stdout); 
    stride = stride + 1; 
  }

}
