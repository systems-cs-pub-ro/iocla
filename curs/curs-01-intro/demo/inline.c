#include <stdio.h>
/* gcc -O2 -g -m32 -masm=intel ./inline.c  */
/*   - only global variables can be referenced in assembly part  
     - take care not to change registers 
     - no jump to C labels
 */
int a = 10;
int b = -20;
int result;
int main()
{
  int c = 2; 
  asm (  "\
        pusha					\n\
	mov eax, [a]				\n\
	mov ebx, [b]				\n\
	imul eax, ebx				\n\
	cmp eax, ebx				\n\
	jg nochange				\n\
	neg eax				        \n\
nochange:					\n\
	mov [result], eax			\n\
	popa                                    \n\
");
  printf("the answer is %d\n", result);

  return 0;
}
