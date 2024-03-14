// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *delete_first(char *s, char *pattern){
	
	char *copy = strdup(s);
	// la aceasta adresa incepe pattern in s prima data
	char *s1 = strstr(copy,pattern);
	// coopiez restul de sir s fara patttern
	char *s2;
	s2 = s1 + strlen(pattern);
	// copiez 
	strcpy(s1,s2);
	return copy;
}

int main(void)
{
	/*
	 * TODO: Este corectă declarația variabilei s în contextul în care o să apelăm
	 * funcția delete_first asupra sa? De ce? Modificați dacă este cazul.
	 */

	/*
	 * RASPUNS: Nu se poate modifica direct stirngul s din main deoarece este constant
	 * pentru a-l modifica este nevoie sa creez o copie.
	*/
	char *s = "Ana are mere";
	char *pattern = "re";

	(void) s;
	(void) pattern;
	// Decomentați linia după ce ați implementat funcția delete_first.
	printf("%s\n", delete_first(s, pattern));

	return 0;
}
