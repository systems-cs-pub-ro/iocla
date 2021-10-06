#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "mtime.h"

#define SEC_TO_USEC(s)		((s) * 1000 * 1000)
#define NSEC_TO_USEC(s)		((s) / 1000)

void get_time(TIMETYPE *time_ptr)
{
	if (clock_gettime(CLOCK_REALTIME, time_ptr) < 0) {
		perror("clock_gettime");
		exit(EXIT_FAILURE);
	}
}

unsigned long us_time(TIMETYPE *time_ptr)
{
	return SEC_TO_USEC(time_ptr->tv_sec) + NSEC_TO_USEC(time_ptr->tv_nsec);
}

unsigned long us_time_diff(TIMETYPE *tstart, TIMETYPE *tend)
{
	return us_time(tend) - us_time(tstart);
}
