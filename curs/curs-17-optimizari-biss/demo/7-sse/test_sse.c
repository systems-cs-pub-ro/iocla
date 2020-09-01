#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

uint64_t rdtsc(void) {
    uint64_t result;
    __asm__ __volatile__ ("rdtsc" : "=A" (result));
    return result;
}

void sum_array_sse(uint32_t *a, uint32_t *b, uint32_t *c, int n);
void sum_array_plain(uint32_t *a, uint32_t *b, uint32_t *c, int n);
void sum_array_c(uint32_t *a, uint32_t *b, uint32_t *c, int n){
  int i;
  for(i = 0; i < n; i++)
    c[i] = a[i] + b[i];  
}

void print_array(uint32_t*v, int n)
{    int i;
  for(i = 0; i < n; i++)
    printf("%d ", v[i]);
  printf("\n"); 
}
uint32_t *v1, *v2, *r;
uint64_t SIZE = 1<<12, // hop to fit all in cache 
  TIMES = 1<<17;       // add two arrays of SIZE bytes TIMES times
//uint32_t v1[] = { 1, 2, 3, 4, 5, 6, 7, 8 }; 
//uint32_t v2[] = { 10, 20, 30, 40, 50, 60, 70, 80 };
//uint32_t r[] = { 1, 2, 3, 4, 5, 6, 7, 8 }; 
  


int main()
{
  uint64_t ts0, ts1, ts2, i;

  #if 1
  SIZE = SIZE & 0xFFFFFFF0; // SSE operates on 128bit dqwords 
  v1 = (uint32_t*) malloc(SIZE);
  v2 = (uint32_t*) malloc(SIZE);
  r = (uint32_t*) malloc(SIZE);
  if(!v1 || !v2 || !r){
    printf("could not allocate 3 x %llu bytes of RAM\n", (SIZE)); 
    exit(-1);
  }
  #else 

    SIZE=8;
    print_array(v1, SIZE);
    print_array(v2, SIZE);
    memset(r, 0, sizeof(r)); 
    sum_array_c(v1, v2, r, SIZE); 
    print_array(r, SIZE);
    memset(r, 0, sizeof(r)); 
    sum_array_plain(v1, v2, r, SIZE); 
    print_array(r, SIZE);
    memset(r, 0, sizeof(r)); 
    sum_array_sse(v1, v2, r, SIZE); 
    print_array(r, SIZE);
    exit(0);
    
#endif
    
  printf("Add arrays of %llu bytes\n", SIZE*TIMES*sizeof(*v1));
  ts0 = rdtsc();
  for(i = 0; i < TIMES; i++)
    sum_array_sse(v1, v2, r, SIZE);
  ts1 = rdtsc() - ts0;
  printf("  SSE: clocks spent = %15llu\n", ts1);

  ts0 = rdtsc();
  for(i = 0; i < TIMES; i++)
    sum_array_plain(v1, v2, r, SIZE);
  ts2 = rdtsc() - ts0;
  printf("PLAIN: clocks spent = %15llu, (%llux slower)\n", ts2, ts2/ts1);

  ts0 = rdtsc();
  for(i = 0; i < TIMES; i++)
    sum_array_c(v1, v2, r, SIZE);
  ts2 = rdtsc() - ts0;
  printf("    C: clocks spent = %15llu, (%llux slower)\n", ts2, ts2/ts1);

  
  return 0;
}
