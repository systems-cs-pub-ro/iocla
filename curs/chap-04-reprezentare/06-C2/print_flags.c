#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
/* gcc -O2 -g -m32 -masm=intel ./inline.c  */
/*   - only global variables can be referenced in assembly part  
     - take care not to change registers 
     - no jump to C labels
 */
uint32_t flagmask[] = {
  0x0001, // carry 
  0x0004, // parity
  0x0010, // auxiliary
  0x0040, // zero
  0x0080, // sign
  0x0800  // overflow
};
char flagletters[] = "CPAZSO"; // same order as above
uint32_t a;
uint32_t b;
uint8_t result; 
uint32_t eflags, i;
char op; 

int main(int nargs, char**args)
{
  int c = 2;

  if(nargs <= 3 || 
     sscanf(args[1], "%x", &a) != 1 ||
     (args[2][0] != '+' && args[2][0] != '-') ||
     sscanf(args[3], "%x", &b) != 1){ 
    printf("Syntax: %s 0xM +/- 0xN\n", args[0]);
    exit(1);
  }
op = args[2][0];
//printf("exec %d %c %d\n", a, op, b); 

  asm (  "\
        pusha					\n\
	mov al, [a]				\n\
	mov ah, [b]				\n\
        mov bl, [op]                            \n\
        cmp bl ,'-'                             \n\
        je minus                                \n\
	    add al, ah				\n\
        jmp saveresult                          \n\
minus:                                          \n\
        sub al, ah                              \n\
saveresult:                                     \n\
        pushf                                   \n\
        pop [eflags]                            \n\
        mov [result], al                        \n\
	popa                                    \n\
");
  printf("hex:      0x%02x %c 0x%02x = 0x%02x\n",  (uint8_t)a, op, (uint8_t)b, result);
  printf("unsign:   %4u %c %4u = %u\n",  (uint8_t)a, op, (uint8_t)b,  (uint8_t)result);
  printf("signed:   %4d %c %4d = %d\n",  (int8_t) a, op, (int8_t) b,  (int8_t)result);
  printf("flags:                = "); 
  
  for(i = 0; i < sizeof(flagletters); i++)
    if(eflags & flagmask[i])
      printf("%c ", flagletters[i]);
  
  printf("\n");
  return 0;
}
