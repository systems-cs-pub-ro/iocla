// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *delete_first(char *s, char *pattern){
	
	// la aceasta adresa incepe pattern in s prima data
	char *s1 = strstr(s,pattern);
	
	// coopiez restul de sir s fara patttern
	char *s2;
	s2 = strdup(s1 + strlen(pattern));

	// copiez 
	strcpy(s1,s2);
	return s;
}

int main(void)
{
	/*
	 * TODO: Este corectă declarația variabilei s în contextul în care o să apelăm
	 * funcția delete_first asupra sa? De ce? Modificați dacă este cazul.
	 */

	/*
	 * RASPUNS:
	*/
	char *s = "Ana are mere";
	char *pattern = "re";

	(void) s;
	(void) pattern;

	// Decomentați linia după ce ați implementat funcția delete_first.
	//printf("%s\n", delete_first(s, pattern));

	return 0;
}
