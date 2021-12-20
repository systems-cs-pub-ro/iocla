# Task Bonus - Assembly 64bit

Biju intra intr-una din camerele din spatele lui Steve. Gaseste un plic pe care scrie "accepta diferitul".

Task-ul implementarea unei functii care aduna 2 vectori de dimensiune `n`, apoi scade din vectorul rezultat 3 numere, definite prin `#define` (`*_VALUE`), in `positions.h`, de pe pozitiile indicate tot in `positions.h` (`*_POSITION`), in assembly pe 32 de biti, folosind sintaxa AT&T. Pozitiile trebuie scalate cu dimensiunea vectorului, ele fiind definite pentru un vector de dimensiune 10.

Sintaxa AT&T este a 2-a sintaxa in care poate fi scris cod de asamblare pentru arhitectura x86. Aceasta sintaxa este singura inteleasa de asamblurul GNU, GAS si este singura folosita in nucleul Linux. Ca o conventie, fisierele care folosesc sintaxa AT&T au extensia `.S`, in timp ce fisierele cu sintaxa Intel folosesc extensia `.asm`. De asemenea, fisierele cu sintaxa AT&T pot folosi directivele de preprocesare ale GCC, precum `#define` si `#include`.

Diferentele intre AT&T si Intel sunt importante, mai ales la modul in care se foloseste adresarea si la ordinea argumentelor instructiunilor de assembly. Pentru detalii, consultati documentul din sectiunea `Resurse utile` a acestui document.

## Exemplu
- n : 5
- v1: 1 2 3 4 5
- v2: 10 9 8 7 6

### Rezultat dupa adunare:
11 11 11 11 11

### Numerele din `positions.h`:
- valoare: 10, pozitie: 2, pozitie scalata pentru n = 5: 1
- valoare: 127, pozitie: 4, pozitie scalata pentru n = 5: 2
- valoare: 21, pozitie: 7, pozitie scalata pentru n = 5: 3

### Vectorul final:
11 1 -116 -10 11

## Resurse utile
- https://imada.sdu.dk/~kslarsen/dm546/Material/IntelnATT.htm

## Punctare

Acest task valoreaza 10 puncte, dintre care un punct e pentru descrierea implementarii si coding style.