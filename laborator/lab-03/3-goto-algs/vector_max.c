#include <stdio.h>

void main(void)
{
	int v[] = {4, 1, 2, -17, 15, 22, 6, 2};
	int max;
	int i;

	/* TODO: Implement finding the maximum value in the vector */
	max = v[0];
	i = 1;
 again: 
	if(v[i] > max){
	  max = v[i];
	}
	i = i + 1;
	if(i < 7)
	  goto again;  

	
	for(i=0; i < 8; i++){
	  printf("%d ", v[i]); 
	}
	printf("max = %d \n", max); 
}
