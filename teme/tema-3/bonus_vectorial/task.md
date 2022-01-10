# Task Bonus - Instructiuni Vectoriale - SSE, AVX

Biju intra intr-una din camerele din spatele lui Steve. Gaseste un plic pe care scrie "optimizeaza".

## Momentul de Teorie

Sistemele de calcul pot fi de 4 tipuri, în functie de câte instrucţiuni se execută în acelaşi timp şi câte date se prelucrează în acelasi timp: SISD, SIMD, MISD, MIMD.

- SISD (single instruction, single data) este tipul folosit până acum de voi: o singură instrucţiune se execută în acelaşi timp şi se lucrează pe o singură dată în acelaşi timp.
- MIMD (multiple instructions, multiple data): subiectul mai multor materii din anii următori (APD, SO, ASC, APP). În acest tip de arhitectură, se pot executa mai multe instrucţiuni simultan, care pot opera pe mai multe date simultan, folosind thread-uri (fire de execuţie).
- SIMD (single instruction, multiple data): aceeaşi instrucţiune este executată pe mai multe date simultan. Acest tip este subiectul unei bucati importante din cursul de ASC.
- MISD (multiple instructions, single data): tip foarte rar întâlnit.

Procesoarele moderne sunt de tip MIMD, întrucât au mai multe nuclee, care la rândul lor pot avea unul sau mai multe thread-uri. Totuşi, aceste procesoare moderne au implementate şi instrucţiuni tip SIMD, care sunt scopul acestui task bonus.

Instructiunile SIMD, numite si instructiuni vectoriale, sunt [MMX](https://en.wikipedia.org/wiki/MMX_(instruction_set)), [SSE](https://en.wikipedia.org/wiki/Streaming_SIMD_Extensions) şi [AVX](https://en.wikipedia.org/wiki/Advanced_Vector_Extensions). MMX este prima variantă de set de instrucţiuni de tip SIMD implementată pe procesoarele Intel, începând cu Intel Pentium P5. SSE (Streaming SIMD Extensions) si AVX (Advanced Vector Extension) sunt variante îmbunătăţite ale instrucţiunilor MMX. Toate seturile de instrucţiuni sunt folosite pentru operaţii pe vectori, de unde si denumirea de instructiuni vectoriale.

Să presupunem că vrem să adunăm 2 vectori a câte 8 elemente fiecare, de tip int. Până acum, s-ar fi folosit o bucla for şi s-ar fi adunat element cu element. Instructiunile SIMD ne permit să efectuăm toate cele 8 adunări, simultan, folosind doar o instructiune de AVX2, numita VPADDD, sau 2 instructiuni de SSE2/AVX. Diferenta principala dintre seturile de instructiuni MMX, SSE si AVX este numarul de biti care pot fi prelucrati in acelasi timp, AVX512 fiind cel mai puternic set de instructiuni, in acest sens, putand prelucra 512 biti in acelasi timp.

Pentru a putea realiza aceste operatii pe vectori, instructiunile SIMD folosesc niste registre speciale: mm in cazul MMX, xmm in cazul SSE si AVX, ymm in cazul AVX2 si zmm in cazul AVX512. 

## Cerinta

Vi se cere sa implementati o functie in assembly pe 64 de biti, `vectorial_ops`, care va primi un scalar, **s**, 3 vectori, **A**, **B** si **C**, si dimensiune vectorilor, **n**, si va realiza operatia `D = s * A + B .* C`, unde `.*` este inmultirea element cu element a 2 vectori (`[1, 2, 3] .* [4, 5, 6] = [1 * 4, 2 * 5, 3 * 6] = [4, 10, 18]`).

Functia are urmatorul antet:

`void vectorial_ops(int s, int A[], int B[], int C[], int n, int D[])`

## Observatii

- Puteti folosi oricare set de instructiuni SIMD pentru realizarea acestui task, in functie de ce aveti disponibil pe masina locala. Pentru a afla ce capabilitati are procesorul vostru, folositi comanda `cat /proc/cpuinfo`.

- Se garanteaza ca **n** este multiplu de 16.

- Se garanteaza ca rezultatul oricarei inmultiri incape intr-un int (32 de biti).

- Daca folositi AVX pentru rezolvarea temei, veti primi 0 puncte pe VMchecker, pentru ca masina pe care ruleaza checker-ul nu are suport pentru AVX.
Mentionati in comentarii sau in README faptul ca ati folosit AVX, sa stim ca e nevoie de verificare manuala.

## Punctare

Acest task valoreaza 15 puncte, dintre care 3 se acorda pentru coding-style si descrierea implementarii.

## Resurse utile

https://docs.oracle.com/cd/E36784_01/html/E36859/gntae.html

https://www.felixcloutier.com/x86/

https://www.intel.com/content/www/us/en/support/articles/000005779/processors.html
