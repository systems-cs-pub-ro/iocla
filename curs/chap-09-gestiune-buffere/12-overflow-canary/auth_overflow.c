// SPDX-License-Identifier: BSD-3-Clause
/*
 * Compile without stack protection (canary disabled):
 *   gcc -fno-pie -g -masm=intel -fno-stack-protector -o nocanary auth_overflow.c
 *
 * Compile with stack protection (canary enabled):
 *   gcc -fno-pie -g -masm=intel -fstack-protector    -o canary   auth_overflow.c
 *
 * Demo sequence:
 *
 * 1. BINARY PATCH of nocanary
 *    cp nocanary_orig nocanary.orig
 *    nm nocanary_orig | grep check_authentication   <- get function address
 *    Use a hex editor (e.g. biew, radare2, or hexedit) to locate the
 *    comparison/branch that checks auth_flag and patch it with NOPs (0x90)
 *    so it always returns 1.  The patched binary accepts any password.
 *
 * 2. OVERFLOW nocanary over auth_flag
 *    password_buffer[16] sits just below auth_flag on the stack.
 *    Passing a password of 17+ characters overflows into auth_flag,
 *    changing it from 0 to a non-zero value → access granted.
 *
 *    64-bit stack frame of check_authentication():
 *      [rbp - 20]   auth_flag (int, 4 B)
 *      [rbp - 36]   password_buffer[16]
 *      [rbp]        saved RBP (8 B)
 *      [rbp + 8]    return address (8 B)
 *
 *    Run with passwords of increasing length (17th char hits auth_flag):
 *      ./nocanary AAAAAAAAAAAAAAAA    (16 chars – no overflow)
 *      ./nocanary AAAAAAAAAAAAAAAAA   (17 chars – overflow auth_flag)
 *
 * 3. STACK CANARY comparison
 *    Compare canary.s with nocanary.s to see the canary instructions:
 *      diff nocanary.s canary.s
 *    Look for:
 *      mov rax, QWORD PTR fs:0x28   <- load canary from TLS
 *      mov QWORD PTR [rbp-0x8], rax <- store on stack
 *      xor eax, eax
 *      ...
 *      mov rax, QWORD PTR [rbp-0x8] <- reload from stack
 *      sub rax, QWORD PTR fs:0x28   <- compare with original
 *      je  .ok
 *      call __stack_chk_fail         <- abort if tampered
 *    Run canary with a 17-char password – it detects the overflow and aborts.
 *
 * 4. PIE (Position Independent Executable)
 *    Run pie several times and observe that .data and stack addresses change:
 *      for i in $(seq 5); do ./pie AAAA; done
 *    This is ASLR in action; PIE enables it for the binary's own sections.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char brillig[] = "brillig", outgrabe[] = "outgrabe";

int check_authentication(char *password)
{
	int auth_flag = 0;
	char password_buffer[16];

	printf(".data address = %p; stack address = %p\n",
	       (void *)brillig, (void *)password_buffer);

	strcpy(password_buffer, password);
	if (strcmp(password_buffer, brillig) == 0)
		auth_flag = 1;
	if (strcmp(password_buffer, outgrabe) == 0)
		auth_flag = 1;
	return auth_flag;
}

int main(int argc, char *argv[])
{
	if (argc < 2) {
		printf("Usage: %s <password>\n", argv[0]);
		exit(0);
	}
	if (check_authentication(argv[1])) {
		printf("\n-=-=-=-=-=-=-=-=-=-=-=-=-=-\n");
		printf(" Access Granted.\n");
		printf("-=-=-=-=-=-=-=-=-=-=-=-=-=-\n");
	} else {
		printf("\nAccess Denied.\n");
	}
}
