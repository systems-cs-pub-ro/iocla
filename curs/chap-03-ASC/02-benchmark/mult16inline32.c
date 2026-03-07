/**************************************************************
 * mult16inline32.c  (32-bit)                                 *
 * Inline-assembly implementation of the Chapter 1 multiply   *
 * algorithm, using 32-bit x86 registers and instructions.    *
 * Must be compiled with -m32.                                *
 * The logic is identical to mult16inline.c but restricted to *
 * 32-bit operands (movl/shll/addl, %edx instead of %rdx).   *
 **************************************************************/

/* mult - multiply value1 by value2 using inline x86 (32-bit) assembly.
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
 *   clobbers: %ecx, %edx, cc   - registers and flags modified by the asm
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
         "         movl   %1,%%edx;  "  /* copy value1 into EDX (32-bit move)           */
         "         shll   %%cl,%%edx;  "/* EDX = value1 << ECX  (shift left by bit index) */
         "         addl   %%edx,%0;     "/* product += EDX                               */
         "         btcl   %%ecx,%2;  "  /* BTC: test bit ECX in value2 and complement it */
         "         jmp    repeat1;   "  /* process the next set bit                      */
         "done:                      "  /* all bits processed, product is complete       */
        :"=r"(product)
        :"r"(value1), "r"(value2), "0"(product)
        :"%ecx","%edx","cc");
     return(product);
 }
