#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "fibonacci.h"
#include "mtime.h"

static void usage(const char *argv0)
{
	fprintf(stderr, "Usage: %s <num>\n", argv0);
}

int arr_bss[100]; 
int arr_data[]={100, 200, 300}; 

int main(int argc, char **argv)
{
	char *endp;
	long num;
	unsigned int fibo;
	TIMETYPE tstart, tend;

	if (argc != 2) {
		usage(argv[0]);
		return -1;
	}

	num = strtol(argv[1], &endp, 10);
	if (*endp != '\0') {
		fprintf(stderr, "Argument is not an integer.\n");
		return -1;
	}
	if (num < 0) {
		fprintf(stderr, "Argument is not a positive integer.\n");
		return -1;
	}

	get_time(&tstart);
	fibo = fibonacci(num);
	get_time(&tend);
	printf("fibonacci(%ld): %u, duration: %lu us\n", num, fibo, us_time_diff(&tstart, &tend));

	get_time(&tstart);
	fibo = fibonacci_iter(num);
	get_time(&tend);
	printf("fibonacci_iter(%ld): %u, duration: %lu us\n", num, fibo, us_time_diff(&tstart, &tend));

	return 0;
}
