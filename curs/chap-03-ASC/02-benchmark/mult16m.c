/*****************************************************
 * mult16m.c                                         *
 * Benchmark harness: calls mult() in a tight loop   *
 * and reports the total wall-clock time.             *
 * Links against either mult16c.o (pure C) or        *
 * mult16inline{32,64}.o (inline ASM) depending on   *
 * which Makefile target is being built.              *
 *****************************************************/
#include <stdio.h>   /* printf, scanf          */
#include <time.h>    /* clock_t, clock()       */
#include <stdlib.h>  /* exit()                 */

int main(void)
{
        clock_t start, finish;        /* timestamps from the CPU clock       */
        int value1=1000, value2=4096; /* fixed inputs used for every call    */
        int i, j, n;                  /* loop indices and repeat-count input */

        extern long mult(int, int);   /* defined in the linked object file   */

        printf ("Please input repeat count: ");
        if( 1 != scanf("%d", &n))     /* read outer loop count from stdin    */
	  exit(1);

        start = clock();              /* record start time                   */
        for (j=0; j<n; j++)           /* outer loop: user-supplied count     */
            for (i=0; i<1000000; i++) /* inner loop: 1 million calls per rep */
                mult(value1, value2);
        finish = clock();             /* record end time                     */

        /* print elapsed time; CLOCKS_PER_SEC converts ticks to seconds */
        printf("Multiplication took %f seconds to finish.\n",
        	((double)(finish-start))/ CLOCKS_PER_SEC);

        return 0;
}

