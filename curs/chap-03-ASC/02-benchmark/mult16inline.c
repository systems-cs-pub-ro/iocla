/**************************************************************
 * mult16inline.c  (64-bit)                                   *
 * Inline-assembly implementation of the Chapter 1 multiply   *
 * algorithm, using 64-bit x86-64 registers and instructions. *
 * Must be compiled with -m64 (default on x86-64 systems).    *
 **************************************************************/

/* mult - multiply value1 by value2 using inline x86-64 assembly.
 *
 * The algorithm uses BSF (Bit Scan Forward) to find the position of
 * the lowest set bit in value2, shifts value1 left by that amount,
 * adds the result to product, then clears that bit with BTC and
 * repeats until value2 is zero.
 *
 * GCC Extended Asm constraints:
 *   "=r"(product)              - output: product in any general register
 *   "r"(value1), "r"(value2)   - inputs: both in general registers
 *   "0"(product)               - ties product's input to output operand 0
 *   clobbers: %ecx, %rdx, cc   - registers and flags modified by the asm
 *
 * Parameters:
 *   value1 - multiplicand (16-bit integer passed as int)
 *   value2 - multiplier   (16-bit integer passed as int)
 * Returns:
 *   long product of value1 * value2
 */
 long mult (int value1, int value2)
 {
     long  product=0;
     asm("repeat1: bsf   %2,%%ecx;  "  /* ECX = bit index of lowest set bit in value2 */
         "         jz     done;      "  /* if value2 == 0, no more bits → jump to done */
         "         movslq %1,%%rdx;  "  /* sign-extend value1 (32-bit) into RDX (64-bit) */
         "         shlq   %%cl,%%rdx;  "/* RDX = value1 << ECX  (shift left by bit index) */
         "         addq   %%rdx,%0;     "/* product += RDX                                */
         "         btcl   %%ecx,%2;  "  /* BTC: test bit ECX in value2 and complement it  */
         "         jmp    repeat1;   "  /* process the next set bit                       */
         "done:                      "  /* all bits processed, product is complete        */
        :"=r"(product)
        :"r"(value1), "r"(value2), "0"(product)
        :"%ecx","%rdx","cc");
     return(product);
 }
