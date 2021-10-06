#ifndef MTIME_H_
#define MTIME_H_	1

#include <time.h>

typedef struct timespec TIMETYPE;

void get_time(TIMETYPE *time_ptr);
unsigned long us_time(TIMETYPE *time_ptr);
unsigned long us_time_diff(TIMETYPE *tstart, TIMETYPE *tend);

#endif
