double array_fsum(double* value, int size)
{
     double sum;
     asm("          fldz;                   "  /* sum = 0 */
         "add_loop: jecxz   done;           "
         "          decl    %%ecx;          "
         "          faddl   (%%ebx,%%ecx,8);"
         "          jmp     add_loop;       "
         "done:                             "
          :"=t"(sum)                  /* output */
          :"b"(value),"c"(size)       /* inputs */
          :"cc");                     /* clobber list */
     return(sum);
}
