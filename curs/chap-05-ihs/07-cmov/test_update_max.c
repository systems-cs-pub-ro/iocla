#include        <stdio.h>

extern int update_max_jmp (int);
extern int update_max_cmov (int);

signed int max = -1000;
int v[] = {-20, 1, 15, 4, 10, 6, 21};

int main(void)
{
	for(int i = 0; i < 7; i++){
	  if(update_max_cmov(v[i]))
	    printf("new max = %d\n", max);
	}
        return 0;
}
