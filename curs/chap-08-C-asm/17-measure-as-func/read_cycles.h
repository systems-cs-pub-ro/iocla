/* SPDX-License-Identifier: BSD-3-Clause */

#ifndef READ_CYCLES_H
#define READ_CYCLES_H

#include <stdint.h>

/* Declaration of the assembly read_cycles() function.
 * Returns the current CPU cycle count via the rdtsc instruction.
 */
uint64_t read_cycles(void);

#endif /* READ_CYCLES_H */
