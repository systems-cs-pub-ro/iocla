// SPDX-License-Identifier: BSD-3-Clause
/*
 * 09-rop-basics — Introduction to 64-bit Return-Oriented Programming
 *
 * This demo shows WHY the 32-bit "put args after ret-addr" trick does NOT
 * work in 64-bit, and HOW to replace it with a minimal ROP chain.
 *
 * Vulnerability: rop_target() reads up to 256 bytes into a 64-byte buffer.
 *
 * Goals (progressively harder):
 *
 *   1. Redirect execution to win_noarg()          – no arguments needed
 *   2. Redirect execution to win_onearg(0xCAFE)   – one arg via RDI
 *   3. Redirect execution to win_twoarg(0xCAFE,   – two args via RDI + RSI
 *                                       0xBABE)
 *
 * For goals 2 and 3 you need ROP gadgets to load registers:
 *   pop rdi ; ret   – load first argument
 *   pop rsi ; ret   – load second argument
 *
 * Find them with:
 *   ROPgadget --binary rop_target | grep "pop rdi"
 *   ROPgadget --binary rop_target | grep "pop rsi"
 *   objdump -d -Mintel rop_target | grep -B1 "ret$" | grep "pop"
 *
 * Stack layout after overflowing rop_target():
 *
 *   [rbp - 64]   buf[64]           <- overflow starts here
 *   [rbp]        saved RBP (8 B)
 *   [rbp + 8]    return address    <- overwrite this
 *
 *   Goal 1:  ... | win_noarg_addr
 *   Goal 2:  ... | pop_rdi_ret | 0xCAFE | win_onearg_addr
 *   Goal 3:  ... | pop_rdi_ret | 0xCAFE | pop_rsi_ret | 0xBABE | win_twoarg_addr
 *
 * offset_to_ret = 64 (buffer) + 8 (saved RBP) = 72 bytes
 * (verify with: objdump -d -Mintel rop_target | grep -A30 "<rop_target>:")
 */

#include <stdio.h>
#include <stdlib.h>

void win_noarg(void)
{
	printf("[+] %s reached — nice redirect!", __func__);
	exit(EXIT_SUCCESS);
}

void win_onearg(unsigned long a)
{
	if (a == 0xCAFE) {
		printf("[+] %s(0xCAFE) reached — RDI was set correctly!", __func__);
		exit(EXIT_SUCCESS);
	}
	printf("[-] %s: got a=0x%lx, expected 0xCAFE\n", __func__, a);
	exit(EXIT_FAILURE);
}

void win_twoarg(unsigned long a, unsigned long b)
{
	if (a == 0xCAFE && b == 0xBABE) {
		printf("[+] %s(0xCAFE, 0xBABE) reached — RDI and RSI were set!", __func__);
		exit(EXIT_SUCCESS);
	}
	printf("[-] %s: got a=0x%lx b=0x%lx, expected 0xCAFE/0xBABE\n", __func__, a, b);
	exit(EXIT_FAILURE);
}

static void rop_target(void)
{
	char buf[64];

	printf("Input: ");
	fflush(stdout);
	fgets(buf, 256, stdin);   /* deliberate overflow */
}

int main(void)
{
	puts("=== 09-rop-basics: 64-bit ROP introduction ===");
	puts("Symbols (run: nm rop_target | grep win)");
	rop_target();
	return 0;
}
