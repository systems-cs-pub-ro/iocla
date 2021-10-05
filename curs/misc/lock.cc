#include <stdlib.h>
#include <stdio.h>
#include <thread>
/* g++ -std=c++11 -lpthread -m32  -masm=intel  ./lock.cc 
   objdump -M=i386,intel -d a.out  

   Demo: compare "inc" with "lock inc" 
   1. compile with 2^32 iterations of the inc; Show that load is 200%, 2 CPUs used
   2. compile with 10^6 iterations. Show counter < 2*10^6
   3. compile with "lock inc". Show counter = 2*10^6 

 */
#define NUM_THREADS 4

int counter = 0;

void asm_inc(){
  asm ("\
        mov ecx, 1000000                \n\
incagain:                               \n\
        inc dword ptr [counter]         \n\
//      lock inc dword ptr [counter]    \n	\
        dec ecx                         \n\
        jnz incagain                    \n\
");
}

int main () {
  std::thread t[NUM_THREADS];
  for (int i = 0; i < NUM_THREADS; ++i) {
    t[i] = std::thread(asm_inc);
  }
  for (int i = 0; i < NUM_THREADS; ++i) {
    t[i].join();
  }
  printf("Counter value: %i\n", counter);
  return 0;
}

