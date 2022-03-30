#include <stdio.h>

int main(void)
{
	int v[] =  {1, 2, 15, 51, 53, 66, 202, 7000};
	int dest = v[2]; /* 15 */
	int start = 0;
	int end = sizeof(v) / sizeof(int) - 1;
	int mid;
	int pos = -1;

again:
	
if(start > end)
	goto out;
mid = start + (end - start) / 2;

if(v[mid] == dest) {
	pos = mid;
	goto out;
}

if(v[mid] < dest) {
	start = mid + 1;
	goto again;
}else if(dest < v[mid]) {
end = mid - 1;
goto again; }

out: 
	printf("%d", pos);
}
