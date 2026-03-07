/*************************************************************
 * mult16c.c                                                 *
 * Pure-C implementation of the Chapter 1 multiply algorithm.*
 * Multiplies two 16-bit integers using bit-shifting and     *
 * conditional accumulation (no hardware MUL instruction).   *
 *************************************************************/

/* mult - multiply value1 by value2 using the shift-and-add algorithm.
 *
 * The algorithm inspects each bit of value2 from LSB to MSB.
 * For every set bit at position i, it adds (value1 << i) to product.
 * This is equivalent to long multiplication in base 2.
 *
 * Parameters:
 *   value1 - multiplicand (16-bit integer)
 *   value2 - multiplier  (16-bit integer)
 * Returns:
 *   long product of value1 * value2
 */
 long mult(int value1, int value2)
 {
     long  product=0;   /* accumulator for the result              */
     int   i;           /* loop counter, iterates over 16 bits     */

     for (i=0; i < 16; i++)          /* process each of the 16 bits */
     {
         if (value2 & 1)             /* if the current LSB of value2 is set… */
             product += value1;      /* …add the current shifted value1       */
         value1 <<= 1;               /* shift value1 left  (multiply by 2)    */
         value2 >>= 1;               /* shift value2 right (move to next bit) */
     }
     return(product);   /* return the accumulated result */
 }

