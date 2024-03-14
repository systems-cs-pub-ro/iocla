// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>
#include "pixel.h"

/*
 * TODO a
 * Functia primeste ca parametru o imagine si intoarce imaginea rasturnata.
 * Prin imagine rasturnata se intelege inversarea liniilor matricei pix_array
 * din structura lui Picture, astfel: Linia 1 devine linia n, linia 2 devine
 * linia n - 1, etc.
 */

void reversePic(Picture *pic){

	for (int i = 0; i < pic->height / 2; i++) {
        Pixel *temp = pic->pix_array[i];
        pic->pix_array[i] = pic->pix_array[pic->height - i - 1];
        pic->pix_array[pic->height - i - 1] = temp;
    }
}

/*
 * TODO b
 * Functia primeste ca parametru o imagine si intoarce noua imagine obtinuta
 * prin convertirea fiecarui pixel la valoarea sa grayscale.
 * Valoarea grayscale a unui pixel sa calculeaza dupa urmatoarea formula:
 * p.r = 0.3 * p.r;
 * p.g = 0.59 * p.g;
 * p.b = 0.11 * p.b;
 */

void colorToGray(Picture *pic){
	for ( int i = 0; i<pic->height; i++){
		for (int j = 0; j< pic->width; j++){
			pic->pix_array[i][j].R = 0.3*pic->pix_array[i][j].R;
			pic->pix_array[i][j].G = 0.3*pic->pix_array[i][j].G;
			pic->pix_array[i][j].B = 0.3*pic->pix_array[i][j].B;
		}
	}
}
/*
 * Structura unui pixel, cea a unei imagini, precum si generarea acestora
 * sunt definite in pixel.h. Programul primeste de la tastatura inaltimea
 * si latimea imaginii. De preferat, introduceti valori mici pentru
 * a fi usor de verificat ulterior.
 * Folositi functia printPicture pentru a printa componentele imaginii.
 * Dupa ce ati realizat un TODO, apelati functia corespunzatoare in main
 * urmata de printPicture pentru a vedea daca se obtine rezultatul dorit.
 */

int main(void)
{
	int height, width;

	scanf("%d%d", &height, &width);
	Pixel **pix_array = generatePixelArray(height, width);
	Picture *pic = generatePicture(height, width, pix_array);

	printPicture(pic);
	reversePic(pic);
	printf("\n");
	printPicture(pic);
	colorToGray(pic);
	printf("\n");
	printPicture(pic);
	freePicture(&pic);
	freePixelArray(&pix_array, height, width);

	return 0;
}
