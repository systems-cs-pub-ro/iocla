// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *delete_first(char *s, char *pattern){
	int j = 0;
	char *res = malloc(strlen(s)+1);
	strcpy(res,s);
	for (int i = 0; i <= strlen(s) - 2; i++){
		if (*(s+i) == *(pattern) && *(s+i+1) == *(pattern+1) ){
			for (j = i; j < strlen(s)-2; j++) *(res+j) = *(res+j+2);
		
	
			res[j]='\0';
			break;
		}
	}
	return res;
}

int main(void)
{
	/*
	 * TODO: Este corectă declarația variabilei s în contextul în care o să apelăm
	 * funcția delete_first asupra sa? De ce? Modificați dacă este cazul.
	 */
	char *s = "Ana are mere";
	char *pattern = "re";
	//printf("%d\n",strlen(pattern));

	(void) s;
	(void) pattern;

	// Decomentați linia după ce ați implementat funcția delete_first.
	printf("%s\n", delete_first(s, pattern));

	return 0;
}
