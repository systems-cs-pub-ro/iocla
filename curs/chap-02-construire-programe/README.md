# Linking

Linking (sau linkare / legare sau link editare / editarea de legături) este faza finală a procesului de compilare.
Linkingul agregă mai multe fișiere obiect (sau colecții de fișiere obiect: biblioteci) într-un fișier executabil.
Un fișier executabil conține datele și codul necesare pentru a porni o aplicație / un proces.
Pornirea unui proces dintr-un fișier executabil este numită **loading** (încărcare).
Fișierul executabil este încărcat (**loaded**) în memorie; codul și datele din fișierul executabil astfel încărcat în memorie sunt folosite pentru a porni un proces.

La compilare, linkare și încărcare se realizează diferite acțiuni specifice.
Numim aceste momente *compile time*, *link time* și *load time*.
Rularea efectivă a codului în cadrul unui proces este numită *runtime*.

Programul folosit pentru linking este numit **linker**.
Linkerul folosește ca date de intrare fișiere obiect și fișiere de tip bibliotecă; produce fișiere executabile sau biblioteci dinamice.
Nu vom insista pe cazul în care linkerul produce biblioteci dinamice, doar pe cazul în care produce fișiere executabile.
Pe scurt, linkerul folosește fișiere care conțin date și cod (mașină) și generează un alt fișier (executabil) care conține date și cod (mașină).
Acest fișier executabil este rezultatul agregării datelor și codului (mașină) din fișierele folosite.

## Formate de fișiere executabile

Fișierele executabile, fișierele obiect și fișierele de tip bibliotecă dinamică (de care vom discuta mai jos) au un anumit format specific platformei.
Acest format stabilește structura internă folosită de linker și de loader la linkare și încărcare.
De exemplu, formatul stabilește cum sunt descrise secțiunile (de cod, de date sau altele), de unde va începe execuția codului, care sunt simbolurile și adresele lor etc.

Compilatorul, linkerul și loaderul folosite pe o platformă dată cunosc formatul de executabil al platformei.
În Linux și în FreeBSD / NetBSD / OpenBSD, formatul folosit este ELF (*Executable and Linkable Format*), în Windows este PE (*Portable Executable*), în macOS / iOS este Mach-O (*Mach Object*).

Formatul de executabil este folosit și de utilitarele de analiză dinamică (precum un debugger) și de cele de analiză statică specifică platformei.
În acest capitol, vom folosi utilitare de analiză statică în Linux, care folosesc formatul ELF: `objdump`, `nm`, `readelf`.

## Acțiunile linkerului

Linkerul produce un fișier executabil care conține datele și codul agregate din mai multe fișiere obiect.
Pentru a produce fișierul executabil, linkerul realizează o serie de acțiuni, pe care le vom detalia mai jos:
1. rezolvarea simbolurilor (*symbol resolution*): localizarea simbolurilor nedefinite ale unui fișier obiect în alte fișiere obiect
1. unificarea secțiunilor: unificarea secțiunilor de același tip din diferite fișiere obiect într-o singură secțiune în fișierul executabil
1. stabilirea adreselor secțiunilor și simbolurilor (*address binding*): după unificare se pot stabili adresele efective ale simbolurilor în cadrul fișierului executabil
1. relocarea simbolurilor (*relocation*): odată stabilite adresele simbolurilor, trebuie actualizate, în executabil, instrucțiunile și datele care referă adresele acelor simboluri
1. stabilirea unui punct de intrare în program (*entry point*): adică adresa primei instrucțiuni ce va fi executată

În mod obișnuit, secvența de mai sus este secvența de acțiuni realizate de linker, ordonate cronologic.
Pentru o mai ușoară înțelegere, vom detalia aceste acțiuni într-o altă ordine.

### Stabilirea unui punct de intrare în program

**Entry pointul** unui program este adresa primei instrucțiuni executate din fișierul executabil.
Entry pointul are sens doar pentru fișiere executabile, nu și pentru fișiere obiect.

În directorul `01-one-file/` fișierul cod sursă C `one.c` a fost compilat în fișierul obiect `one.o`.
Ca suport pentru procesul de linkare, fișierul în limbaj de asamblare `start.s` a fost asamblat în fișierul obiecti `start.o`.
Cele două fișiere obiect, `one.o` și `start.o`, au fost legate în fișierul executabil `one`.
Prezența fișierului în limbaj de asamblare este necesară pentru procesul de linking; nu vom insista pe acesta acum.
În principiu, pentru simplitate, este vorba de compilarea și legarea unui **singur** fișier `one.c` în executabilul `one`.

**Important**: **Nu** folosiți comanda `make` pentru a obține fișierele obiect și fișierele executabile.
Fișierele sunt deja generate; dacă le regenerați, probabil vor avea un format diferit și va face mai dificilă urmărirea comenzilor de mai jos.

Observăm că fișierul obiect `one.o` nu are entry point, pe când fișierul executabil `one` are:

```
[..]/01-one-file$ readelf -h one.o
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              REL (Relocatable file)
  Machine:                           Intel 80386
  Version:                           0x1
  Entry point address:               0x0
  Start of program headers:          0 (bytes into file)
  Start of section headers:          1364 (bytes into file)
  Flags:                             0x0
  Size of this header:               52 (bytes)
  Size of program headers:           0 (bytes)
  Number of program headers:         0
  Size of section headers:           40 (bytes)
  Number of section headers:         20
  Section header string table index: 19

[..]/01-one-file$ readelf -h one
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           Intel 80386
  Version:                           0x1
  Entry point address:               0x8048130
  Start of program headers:          52 (bytes into file)
  Start of section headers:          5284 (bytes into file)
  Flags:                             0x0
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         5
  Size of section headers:           40 (bytes)
  Number of section headers:         15
  Section header string table index: 14
```

În cazul fișierului `one.o`, nu există o adresă pentru entry point (`0x0`).
În cazul fișierului executabil `one`, adresa entry pointului este stabilită (`0x8048124`).
Adresa entry pointului este adresa simbolului `_start`:
```
[..]/01-one-file$ nm one
0804a004 D __bss_start
0804a004 D _edata
0804a004 D _end
08048140 r __GNU_EH_FRAME_HDR
08048100 T increment
08048113 T main
00000001 a __NR_exit
0804a000 D num_items
08048130 T _start
```

Simbolul `_start` este definit în fișierul în limbaj de asamblare `start.s`.
Simbolul `_start`, adică entry pointul, adică adresa primei instrucțiuni executate, este echivalentul unei funcții care apelează funcția `main()`.
Deci `main()` nu este entry pointul unui program, nu este prima funcție executată.
O altă secvență de cod, numită tipic, la fel ca în acest caz, `_start`, este prima executată.
Și aceasta apelează `main()`.

Așadar, dându-se unul sau mai multe fișiere obiect, linkerul creează executabilul și stabilește entry pointul acestuia.
Entry pointul are sens doar pentru fișiere executabile, **NU** pentru fișiere obiect.

### Address binding

Linkerul atașează fiecărui simbol din fișierul executabil rezultat o adresă.
Aceste adrese vor fi folosite la încărcarea executabilului în memorie, la crearea procesului.
O astfel de adresă este adresa entry pointului, adresa primei instrucțiuni ce va fi executată.

Simbolurile din fișierele obiect nu au atribuite adrese.
Adresele vor fi atribuite fiecărui simbol la linkare.
Când investigăm un fișier obiect, "adresele" afișate sunt de fapt offseturile în cadrul secțiunilor.
Comanda de mai jos afișează simbolurile din fișierul obiect `one.o`:
```
[..]/01-one-file$ nm one.o
00000000 T increment
00000013 T main
00000000 D num_items
```
În secvența de mai sus ar părea că simbolul `increment` și simbolul `num_items` au acceași adresă.
De fapt, simbolul `increment` este un simbol în secțiunea de cod (`.text`) în vreme ce simbolul `num_items` este un simbol în secțiunea de date (`.data`).
"Adresele" afișate sunt offseturile în cadrul secțiunilor.
Adică simbolul `increment` este la offsetul `0` în cadrul secțiunii de cod (adică este la începutul secțiunii).
La fel, simbolul `num_items` este la offsetul `0` în cadrul secțiunii de date (adică, la fel, este la începutul secțiunii).
Un alt simbol, `main` este la offsetul `0x13` în cadrul secțiuni de cod.

În dezasamblarea codului fișierului obiect `one.o` observăm adresele (adică, de fapt, offseturile) pentru simbolurile `increment` și `main`:
```
[..]/01-one-file$ objdump -d -M intel one.o

one.o:     file format elf32-i386


Disassembly of section .text:

0000000 <increment>:
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
   3:	a1 00 00 00 00       	mov    eax,ds:0x0
   8:	83 c0 01             	add    eax,0x1
   b:	a3 00 00 00 00       	mov    ds:0x0,eax
  10:	90                   	nop
  11:	5d                   	pop    ebp
  12:	c3                   	ret

00000013 <main>:
  13:	55                   	push   ebp
  14:	89 e5                	mov    ebp,esp
  16:	c7 05 00 00 00 00 05 	mov    DWORD PTR ds:0x0,0x5
  1d:	00 00 00
  20:	e8 fc ff ff ff       	call   21 <main+0xe>
  25:	b8 00 00 00 00       	mov    eax,0x0
  2a:	5d                   	pop    ebp
  2b:	c3                   	ret
```
Adresele / offseturile sunt cele așteptate: `0` pentru `increment` și `0x13` pentru `main`<a href="#ds" id="refds"><sup>1</sup></a>.

De cealaltă parte, în cadrul fișierului executabil, fiecare simbol are asociată o adresă.
Adresa este unică în cadrul fișierului executabil, nu mai este offset în cadrul unei secțiuni, și va fi folosită la load time pentru crearea procesului.
Comanda de mai jos afișează simbolurile din executabilul `one`, împreună cu adresele lor:
```
[..]/01-one-file$ nm one
0804a004 D __bss_start
0804a004 D _edata
0804a004 D _end
08048140 r __GNU_EH_FRAME_HDR
08048100 T increment
08048113 T main
00000001 a __NR_exit
0804a000 D num_items
08048130 T _start
```
Observăm că acum simbolurile `increment`, `num_items`, `main` au adrese efective, unice între ele.
În executabil apar și alte simboluri, introduse de linker pentru buna funcționare a programului.

Similar, la dezasamblarea codului executabilului `one`, observăm că simbolurile `increment` și `main` au adrese efective:
```
[..]/01-one-file$ objdump -d -M intel one

one:     file format elf32-i386


Disassembly of section .text:

08048100 <increment>:
 8048100:	55                   	push   ebp
 8048101:	89 e5                	mov    ebp,esp
 8048103:	a1 00 a0 04 08       	mov    eax,ds:0x804a000
 8048108:	83 c0 01             	add    eax,0x1
 804810b:	a3 00 a0 04 08       	mov    ds:0x804a000,eax
 8048110:	90                   	nop
 8048111:	5d                   	pop    ebp
 8048112:	c3                   	ret

08048113 <main>:
 8048113:	55                   	push   ebp
 8048114:	89 e5                	mov    ebp,esp
 8048116:	c7 05 00 a0 04 08 05 	mov    DWORD PTR ds:0x804a000,0x5
 804811d:	00 00 00
 8048120:	e8 db ff ff ff       	call   8048100 <increment>
 8048125:	b8 00 00 00 00       	mov    eax,0x0
 804812a:	5d                   	pop    ebp
 804812b:	c3                   	ret
 804812c:	66 90                	xchg   ax,ax
 804812e:	66 90                	xchg   ax,ax

08048130 <_start>:
 8048130:	e8 de ff ff ff       	call   8048113 <main>
 8048135:	89 c3                	mov    ebx,eax
 8048137:	b8 01 00 00 00       	mov    eax,0x1
 804813c:	cd 80                	int    0x80
```

În fapt, linkerul stabilește care este adresa de început a fiecărui secțiuni.
Iar apoi, pentru fiecare simbol se calculează adresa ca fiind suma dintre adresa secțiunii și deplasamentul (offsetul) simbolului în cadrul secțiunii:
```
symbol_address = section_address + offset_of_symbol_in_section
```

Folosim comanda de mai jos pentru a afla adresele secțiunilor din cadrul executabilului `one`:
```
[..]/01-one-file$ readelf -S one
There are 15 section headers, starting at offset 0x14a4:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .note.gnu.build-i NOTE            080480d4 0000d4 000024 00   A  0   0  4
  [ 2] .text             PROGBITS        08048100 000100 00003e 00  AX  0   0 16
  [ 3] .eh_frame_hdr     PROGBITS        08048140 000140 00001c 00   A  0   0  4
  [ 4] .eh_frame         PROGBITS        0804815c 00015c 000058 00   A  0   0  4
  [ 5] .data             PROGBITS        0804a000 001000 000004 00  WA  0   0  4
  [ 6] .comment          PROGBITS        00000000 001004 000029 01  MS  0   0  1
  [ 7] .debug_aranges    PROGBITS        00000000 00102d 000020 00      0   0  1
  [ 8] .debug_info       PROGBITS        00000000 00104d 00006b 00      0   0  1
  [ 9] .debug_abbrev     PROGBITS        00000000 0010b8 00006d 00      0   0  1
  [10] .debug_line       PROGBITS        00000000 001125 00003a 00      0   0  1
  [11] .debug_str        PROGBITS        00000000 00115f 0000c7 01  MS  0   0  1
  [12] .symtab           SYMTAB          00000000 001228 000180 10     13  17  4
  [13] .strtab           STRTAB          00000000 0013a8 00005f 00      0   0  1
  [14] .shstrtab         STRTAB          00000000 001407 00009b 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  p (processor specific)
```
Adresele sunt indicate în coloana `Addr`.
Observăm că secțiunea `.text` are adresa de început `0x08048100`, iar secțiunea `.data` are adresa de început `0x0804a000`.
Simbolul `increment` se găsește la adresa `0x08048100` adică la începutul secțiunii `.text`.
Simbolul `num_items` se găsește la adresa `0x0804a000` adică la începutul secțiunii `.data`.
Simbolul `main` se găsește la adresa `0x08048113` adică la offsetul `0x13` în secțiunea `.text`.

### Relocarea simbolurilor

În dezasamblarea fișierului obiect `one.o`, respectiv a executabilului `one`, observăm că instrucțiunile care folosesc variabila `num_items` sunt:
```
; one.o
   [...]
   3:	a1 00 00 00 00       	mov    eax,ds:0x0
   [...]
   b:	a3 00 00 00 00       	mov    ds:0x0,eax
   [...]
  16:	c7 05 00 00 00 00 05 	mov    DWORD PTR ds:0x0,0x5

; one
 [...]
 8048103:	a1 00 a0 04 08       	mov    eax,ds:0x804a000
 [...]
 804810b:	a3 00 a0 04 08       	mov    ds:0x804a000,eax
 [...]
 8048116:	c7 05 00 a0 04 08 05 	mov    DWORD PTR ds:0x804a000,0x5
```

În fișierul executabil, codul instrucțiunilor conține adresa efectivă a variabilei `num_items` (`0x0804a000`), scrisă în format little endian.
În fișierul obiect `one.o`, însă, nu apare adresa efectivă a variabilei `num_items`, ci apare `0x0`.
Explicația este că fișierul executabil, rezultat în urma procesului de linking, a fost obținut știindu-se adresele efective, în vreme ce, în cazul fișierului obiect, adresele nu sunt cunoscute.

Același lucru se întâmplă și în cazul instrucțiunii care referă simbolul `increment` din cadrul funcției `main`:
```
; one.o
  [...]
  20:	e8 fc ff ff ff       	call   21 <main+0xe>
  [...]

; one
 [...]
 8048120:	e8 db ff ff ff       	call   8048100 <increment>
 [...]
```

În fișierul executabil `one`, instrucțiunea `call` realizează saltul chiar la adresa (știută) a funcției `increment`.
În fișierul obiect `one.o`, instrucțiunea `call` ar realiza un salt cumva chiar în interiorul său, la adresa `0x21`, instrucțiunea aflându-se ea însăși la adresa `0x20`.

Modificarea instrucțiunilor sau a altor zone din viitorul executabil pentru a referi adresele efective ale simbolurilor folosite poartă numele de **relocare** (*relocation*).

Din acest motiv, fișierele obiect mai sunt numite **fișiere obiect relocabile** (*relocatable object file*).
Aceasta este explicația pentru care cuvântul *relocatable* apare în rezultatul rulării comenzilor `readelf` sau `file`:
```
[..]/01-one-file$ file one.o
one.o: ELF 32-bit LSB relocatable, Intel 80386, version 1 (SYSV), with debug_info, not stripped

[..]/01-one-file$ readelf -h one.o
ELF Header:
  [..]
  Type:                              REL (Relocatable file)
  [..]
```

Linkerul se ocupă de relocarea referințelor la simboluri.
Atunci când creează fișierul executabil, urmărește referințele la simboluri și le înlocuiește cu adresele efective ale simbolurilor.
Pentru a realiza relocarea, adică înlocuirea referințelor, linkerul trebuie să știe unde se găsesc aceste referințe.
Pentru aceasta, fișierele obiect relocabile conțin **tabele de relocare** (*relocation tables*)<a href="#ds" id="refds"><sup>2</sup></a>.

Folosim `readelf` pentru a obține tabelele de relocare ale fișierului obiect relocabil `one.o`:
```
[..]/01-one-file$ readelf -r one.o

Relocation section '.rel.text' at offset 0x400 contains 4 entries:
 Offset     Info    Type            Sym.Value  Sym. Name
00000004  00000d01 R_386_32          00000000   num_items
0000000c  00000d01 R_386_32          00000000   num_items
00000018  00000d01 R_386_32          00000000   num_items
00000021  00000e02 R_386_PC32        00000000   increment
[...]
```
Am selectat mai sus doar partea de interes pentru noi, adică secțiunea `.rel.text`.
Celelalte informații sunt legate de debugging sau nu sunt relevante.

Observăm în tabela de relocare 4 intrări: 3 referă simbolul `num_items`, iar una la simbolul `increment`.
Relevantă este coloana `offset` unde este indicată referința la simbol, referință ce trebuie înlocuită de linker.
Prin parcurgerea secțiunii de relocare `.rel.text`, linkerul ia următoarele decizii:
* la offsetul `0x04` față de începutul secțiunii `.text` trebuie să înlocuiască referința cu adresa simbolului `num_items`
* la offsetul `0x0c` față de începutul secțiunii `.text` trebuie să înlocuiască referința cu adresa simbolului `num_items`
* la offsetul `0x18` față de începutul secțiunii `.text` trebuie să înlocuiască referința cu adresa simbolului `num_items`
* la offsetul `0x21` față de începutul secțiunii `.text` trebuie să înlocuiască referința cu adresa simbolului `increment`

În dezasamblarea fișierului obiect `one.o`, observăm că exact acelea sunt offseturile unde se găsesc referințele la simboluri:
```
; one.o
   [...]
   3:	a1 00 00 00 00       	mov    eax,ds:0x0
   [...]
   b:	a3 00 00 00 00       	mov    ds:0x0,eax
   [...]
  16:	c7 05 00 00 00 00 05 	mov    DWORD PTR ds:0x0,0x5
   [...]
  20:	e8 fc ff ff ff       	call   21 <main+0xe>
   [...]
```
La offseturile `0x04`, `0x0c`, `0x18` se găsesc referințe la simbolul `num_items`.
Necunoscându-se adresa simbolului `num_items` referințele sunt acum marcate cu `0x00000000`.

Similar, la offsetul `0x21` se găsește referința la simbolul `increment`.
La fel, necunoscându-se adresa simbolului `increment`, referința este marcată cu un placeholder.

După ce stabilește adresele, linkerul va parcurge secțiunea de relocare `.rel.text` și va face înlocuirea referințelor cu adresele efective ale simbolurilor.
Acest lucru se observă în fișierul executabil:
```
; one
 [...]
 8048103:	a1 00 a0 04 08       	mov    eax,ds:0x804a000
 [...]
 804810b:	a3 00 a0 04 08       	mov    ds:0x804a000,eax
 [...]
 8048116:	c7 05 00 a0 04 08 05 	mov    DWORD PTR ds:0x804a000,0x5
 [...]
 8048120:	e8 db ff ff ff       	call   8048100 <increment>
 [...]
```
În locurile în care în fișierul obiect existau referințe de tip placeholder, fișierul executabil conține adresele efective ale simbolurilor.

Fișierul executabil `one` are toate referințele relocate așa că nu are o tabelă / secțiune de relocare:
```
[..]/01-one-file$ readelf -r one

There are no relocations in this file.
```

Etapa de relocare presupune, în general, și stabilirea adreselor simbolurilor (*address binding*).
Aici am folosit o definiție mai relaxată, considerând relocarea ca fiind doar înlocuirea referințelor de simboluri folosind tabelele de relocare.

### Rezolvarea simbolurilor

Un fișier obiect, obținut în urma compilării unui fișier cod sursă, conține simboluri definite și nedefinite (*undefined*).
Simbolurile nedefinite sunt simboluri **declarate** și **folosite** în fișierul cod sursă inițial.
După cum le spune și numele, nu sunt, însă, definite, adică nu se aloca memorie pentru ele (și deci, în viitor, adrese).

În limbajul C, declarăm funcții prin precizarea antetului lor, fără definirea unui corp de funcție:
```
/* Declare function f. */
int f(void);

/* Use function f. */
a = f();
```

Declarăm variabile, fără a le defini, prefixându-le cu `extern`:
```
/* Declare variable num_items. */
extern unsigned int num_items;

/* Use variable num_items. */
num_items = 10;
printf("num_items: %u\n", num_items);
```

Definirea unui simbol poate avea loc în alt modul.
Adică un alt modul poate defini o funcție (o funcție care să aibă corp) și o variabilă, rezultând în alocarea de memorie pentru aceste simboluri: cod pentru funcție și date pentru variabilă.
Este rolul linkerului de a parcurge fișierele obiect și de a extrage simbolurile nedefinite.
Pentru fiecare referință de simbol nedefinit, linkerul va căuta fișierul obiect unde simbolul este definit.
Apoi va realiza conexiunea între cele două.
Adică locul unde era referit simbolul nedefinit va fi acum completat cu adresa corectă.

### Unificarea secțiunilor

Fișierul executabil rezultat în urma linkării conține o secțiune `.text`, o secțiune `.data` (date inițializate), o secțiune `.bss` (date neinițializate) etc.
Toate secțiunile de același tip din cadrul fișierelor obiect linkate sunt unificate într-o singură secțiune în cadrul fișierului executabil rezultat.
Ordinea în care secțiunile sunt agregate din diferitele fișiere obiect linkate este la latitudinea linkerului; uzual este chiar ordinea folosită în comanda de linkare.

Urmărim secțiunea `.text` în fișierele obiect `one.o` și `start.o` și în fișierul executabil `one`:
```
[..]/01-one-file$ objdump -j .text -h one.o

one.o:     file format elf32-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         0000002c  00000000  00000000  00000034  2**0
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
[..]/01-one-file$ objdump -j .text -h start.o

start.o:     file format elf32-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         0000000e  00000000  00000000  00000130  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
[..]/01-one-file$ objdump -j .text -h one

one:     file format elf32-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  1 .text         0000003e  08048100  08048100  00000100  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
```
Observăm că dimensiunea secțiunii `.text` este `0x2c` pentru `one.o`, `0x0e` pentru `start.o` și `0x3e` pentru `one`.
În mod normal, dimensiunea secțiunii pentru executabil este suma dimensiunilor secțiunilor pentru fișierele obiect linkate.
În cazul de fața, dimensiunea este mai mare (`0x3e` > `0x2c` + `0x0e`), cel mai probabil din rațiuni de aliniere<a href="#align" id="refalign"><sup>3</sup></a>.
Alinierea se realizează la `16` octeți, lucru indicat de valoarea `2**4` din coloana `Algn`.

Urmărim codul dezasamblat pentru secțiunea `.text` a fiecăruia dintre cele trei fișiere:
```
[..]/01-one-file$ objdump -d -M intel one.o

one.o:     file format elf32-i386


Disassembly of section .text:

00000000 <increment>:
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
   3:	a1 00 00 00 00       	mov    eax,ds:0x0
   8:	83 c0 01             	add    eax,0x1
   b:	a3 00 00 00 00       	mov    ds:0x0,eax
  10:	90                   	nop
  11:	5d                   	pop    ebp
  12:	c3                   	ret

00000013 <main>:
  13:	55                   	push   ebp
  14:	89 e5                	mov    ebp,esp
  16:	c7 05 00 00 00 00 05 	mov    DWORD PTR ds:0x0,0x5
  1d:	00 00 00
  20:	e8 fc ff ff ff       	call   21 <main+0xe>
  25:	b8 00 00 00 00       	mov    eax,0x0
  2a:	5d                   	pop    ebp
  2b:	c3                   	ret

[..]/01-one-file$ objdump -d -M intel start.o

start.o:     file format elf32-i386


Disassembly of section .text:

00000000 <_start>:
   0:	e8 fc ff ff ff       	call   1 <_start+0x1>
   5:	89 c3                	mov    ebx,eax
   7:	b8 01 00 00 00       	mov    eax,0x1
   c:	cd 80                	int    0x80

[..]/01-one-file$ objdump -d -M intel one

one:     file format elf32-i386


Disassembly of section .text:

08048100 <increment>:
 8048100:	55                   	push   ebp
 8048101:	89 e5                	mov    ebp,esp
 8048103:	a1 00 a0 04 08       	mov    eax,ds:0x804a000
 8048108:	83 c0 01             	add    eax,0x1
 804810b:	a3 00 a0 04 08       	mov    ds:0x804a000,eax
 8048110:	90                   	nop
 8048111:	5d                   	pop    ebp
 8048112:	c3                   	ret

08048113 <main>:
 8048113:	55                   	push   ebp
 8048114:	89 e5                	mov    ebp,esp
 8048116:	c7 05 00 a0 04 08 05 	mov    DWORD PTR ds:0x804a000,0x5
 804811d:	00 00 00
 8048120:	e8 db ff ff ff       	call   8048100 <increment>
 8048125:	b8 00 00 00 00       	mov    eax,0x0
 804812a:	5d                   	pop    ebp
 804812b:	c3                   	ret
 804812c:	66 90                	xchg   ax,ax
 804812e:	66 90                	xchg   ax,ax

08048130 <_start>:
 8048130:	e8 de ff ff ff       	call   8048113 <main>
 8048135:	89 c3                	mov    ebx,eax
 8048137:	b8 01 00 00 00       	mov    eax,0x1
 804813c:	cd 80                	int    0x80
```

Observăm ca linkerul adaugă, în secțiunea `.text` a fișierului executabil, niște instrucțiuni suplimentare (`xchg ax, ax`, la adresele `0x804812c` și `0x804812e`) care nu au nici un efect în cadrul programului (sunt după instrucțiunea `ret`).
Aceste instrucțiuni au rolul de aliniere, observăm că adresa funcției `_start` din fișierul executabil (`0x8048130`) este aliniată la `16` octeți.

Aceeași unificare are loc și pe celelalte secțiuni de același tip din cadrul fișierelor obiect.
Linkerul poate decide plasarea unor spații libere nefolosite, pentru aliniere, similar secțiunilor inițiale din cadrul fișierelor obiect.

### Stabilirea adreselor

După unificare în fișierul executabil, fiecărei secțiuni i se atribuie o adresă.
De exemplu, secțiunea `.text` a fișierului executabil `out` are adresa `0x8048100`, în vreme ce secțiunea `.data` are adresa `0x804a000`:
```
[..]/01-one-file$ readelf -S one
There are 15 section headers, starting at offset 0x14a4:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [...]
  [ 2] .text             PROGBITS        08048100 000100 00003e 00  AX  0   0 16
  [...]
  [ 5] .data             PROGBITS        0804a000 001000 000004 00  WA  0   0  4
```
Pornind de la adresele de start ale acestor secțiuni (unificate) se stabilesc adresele simbolurilor în cadrul executabilului (*address binding*).
Acum se stabilește că adresa funcției `main` este `0x8048113`, adresa funcției `_start` este `0x8048130`, adresa variabilei `num_items` este `0x804a000` etc.
Aceste adrese sunt apoi folosite în faza de relocare și la completarea entry pointului în headerul fișierului executabil.

#### Stripping

Asocierea dintre simboluri și adrese se găsește în secțiuni / tabele dedicate în fișierelor obiect sau executabile.
După relocare și completarea entry pointului într-un fișier executabil, asocierea dintre un nume de simbol și o adresă nu mai este necesară.
Fișierul executabil are toate informațiile necesare pentru a putea fi încărcat (*loaded*) într-un proces, chiar și în lipsa numelor de simboluri.

Renunțarea la simbolurile unui executabil se numește *stripping*.
Poate fi realizată ca parte a procesului de linking, sau poate fi realizată ulterior.
Realizăm o variantă stripped a executabilului `one`, numită `one_stripped`:
```
[..]/01-one-file$ cp one one_stripped

[..]/01-one-file$ strip one_stripped

[..]/01-one-file$ nm one
0804a004 D __bss_start
0804a004 D _edata
0804a004 D _end
08048140 r __GNU_EH_FRAME_HDR
08048100 T increment
08048113 T main
00000001 a __NR_exit
0804a000 D num_items
08048130 T _start

[..]/01-one-file$ nm one_stripped
nm: one_stripped: no symbols

[..]/01-one-file$ ls -l one one_stripped
-rwxr-xr-x 1 razvan razvan 5884 Jan 17 10:36 one
-rwxr-xr-x 1 razvan razvan 4536 Jan 17 12:49 one_stripped
```
Observăm că fișierul `one_stripped` nu mai are simboluri.
De asemenea, observăm că dimensiunea sa este mai redusă (de la `5884` de octeți, dimensiunea fișierului a scăzut la `4536` de octeți).

Scăderea dimensiunii este cauzată de eliminarea unor secțiuni din executabil.
Dacă investigăm secțiunile celor două executabile, observăm că secțiunile de debug și secțiunile `.strtab` și `.symtab` (care rețin informații despre simboluri), au fost eliminate din executabilul `one_stripped`.
```
[..]/01-one-file$ readelf -S one
There are 15 section headers, starting at offset 0x14a4:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .note.gnu.build-i NOTE            080480d4 0000d4 000024 00   A  0   0  4
  [ 2] .text             PROGBITS        08048100 000100 00003e 00  AX  0   0 16
  [ 3] .eh_frame_hdr     PROGBITS        08048140 000140 00001c 00   A  0   0  4
  [ 4] .eh_frame         PROGBITS        0804815c 00015c 000058 00   A  0   0  4
  [ 5] .data             PROGBITS        0804a000 001000 000004 00  WA  0   0  4
  [ 6] .comment          PROGBITS        00000000 001004 000029 01  MS  0   0  1
  [ 7] .debug_aranges    PROGBITS        00000000 00102d 000020 00      0   0  1
  [ 8] .debug_info       PROGBITS        00000000 00104d 00006b 00      0   0  1
  [ 9] .debug_abbrev     PROGBITS        00000000 0010b8 00006d 00      0   0  1
  [10] .debug_line       PROGBITS        00000000 001125 00003a 00      0   0  1
  [11] .debug_str        PROGBITS        00000000 00115f 0000c7 01  MS  0   0  1
  [12] .symtab           SYMTAB          00000000 001228 000180 10     13  17  4
  [13] .strtab           STRTAB          00000000 0013a8 00005f 00      0   0  1
  [14] .shstrtab         STRTAB          00000000 001407 00009b 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  p (processor specific)

[..]/01-one-file$ readelf -S one_stripped
There are 8 section headers, starting at offset 0x1078:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .note.gnu.build-i NOTE            080480d4 0000d4 000024 00   A  0   0  4
  [ 2] .text             PROGBITS        08048100 000100 00003e 00  AX  0   0 16
  [ 3] .eh_frame_hdr     PROGBITS        08048140 000140 00001c 00   A  0   0  4
  [ 4] .eh_frame         PROGBITS        0804815c 00015c 000058 00   A  0   0  4
  [ 5] .data             PROGBITS        0804a000 001000 000004 00  WA  0   0  4
  [ 6] .comment          PROGBITS        00000000 001004 000029 01  MS  0   0  1
  [ 7] .shstrtab         STRTAB          00000000 00102d 00004b 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  p (processor specific)
```

În general, executabilele care sunt instalate pe un sistem sunt stripped, cum este cazul executabilului `/bin/ls`:
```
[..]/01-one-file$ nm /bin/ls
nm: /bin/ls: no symbols
```
Aceasta se întâmplă pentru că nu este nevoie de simboluri pentru rularea executabilului.
În plus, absența simbolurilor aduce și un beneficiu de securitate, fiind mai dificil pentru un potențial atacator să folosească tehnici de inginerie inversă (*reverse engineering*) pentru a analiza fișierul executabil.

În mod implicit, în faza de dezvoltare, simbolurile sunt prezente în executabil, pentru a fi mai ușor procesul de depanare și investigare.
Pe lângă simboluri folosite în procesul de linking, faza de dezvoltare adaugă, de obicei și simboluri de debug, care aduc un plus de suport în faza de depanare.

Procesul de stripping nu are sens să fie aplicat fișierelor obiect.
Dacă un fișier obiect este stripped, atunci va eșua etapa de rezolvare a simbolurilor din procesul de linking, pentru că simbolurile sunt căutate după numele lor.

## Linkare de fișiere multiple

În exemplul din directorul `01-one-file/` am linkat de fapt, un singur fișier: `one.c`.
Fișierul `start.asm` este folosit ca fișier de suport.

Observăm cum se întâmplă acțiunile linkerului în directorul `02-two-files/`.
Acesta conține două fișiere cod sursă C (`two.c` și `inc.c`) care sunt, de fapt, o împărțire a fișierului `one.c` din directorul `01-one-file/`:
* `two.c` conține funcția `main()` și variabila `num_items`
* `inc.c` conține funcția `increment()`
* `two.c` conține referință la funcția `increment()`: funcția este folosită și declarată (prin antet), dar nu este definită
* `inc.c` conține referință la variabila `num_items`: variabila este folosită și declarată (prin folosirea cuvântului cheie `extern`), dar nu este definită
Fișierul `start.asm` este fișierul de suport.

Toate fișierele sunt compilate, respectiv, în fișierele obiect `two.o`, `inc.o` și `start.o`, care sunt linkate în fișierul executabil `two`.

Pentru început urmărim simbolurile din fiecare fișier de interes:
```
[..]/02-two-files$ nm two.o
         U increment
00000000 T main
00000000 D num_items

[..]/02-two-files$ nm inc.o
00000000 T increment
         U num_items

[..]/02-two-files$ nm two
0804a004 D __bss_start
0804a004 D _edata
0804a004 D _end
08048160 r __GNU_EH_FRAME_HDR
0804812e T increment
08048100 T main
00000001 a __NR_exit
0804a000 D num_items
08048150 T _start
```
Observăm că simbolul `increment` este nedefinit în fișierul obiect `two.o`, iar simbolul `num_items` este nedefinit în fișierul `inc.o`.
Simbolurile definite în fiecare modul obiect (`main` și `num_items` în `two.o`, respectiv `increment` în `inc.o`) au adresa `0` pentru că sunt la începutul secțiunii corespunzătoare (`.text` sau `.data`).
Fișierul executabil `two` are toate simbolurile definite și adresele stabilite, în urma etapelor procesului de linking: rezolvarea simbolurilor, unificarea secțiunilor, stabilirea adreselor, relocarea simbolurilor.

Urmărim tabelele de relocare pentru cele două fișiere obiect:
```
[..]/02-two-files$ readelf -r two.o

Relocation section '.rel.text' at offset 0x1a8 contains 2 entries:
 Offset     Info    Type            Sym.Value  Sym. Name
00000013  00000801 R_386_32          00000000   num_items
0000001c  00000a02 R_386_PC32        00000000   increment

Relocation section '.rel.eh_frame' at offset 0x1b8 contains 1 entry:
 Offset     Info    Type            Sym.Value  Sym. Name
00000020  00000202 R_386_PC32        00000000   .text

[..]/02-two-files$ readelf -r inc.o

Relocation section '.rel.text' at offset 0x168 contains 2 entries:
 Offset     Info    Type            Sym.Value  Sym. Name
00000004  00000901 R_386_32          00000000   num_items
0000000c  00000901 R_386_32          00000000   num_items

Relocation section '.rel.eh_frame' at offset 0x178 contains 1 entry:
 Offset     Info    Type            Sym.Value  Sym. Name
00000020  00000202 R_386_PC32        00000000   .text
```
Observăm că `two.o` are o relocare pentru simbolul `num_items` și una pentru simbolul `increment`.
În vreme ce `inc.o` are două relocări pentru simbolul `num_items`.

Investigăm relocările în codul în limbaj de asamblare:
```
[..]/02-two-files$ objdump -d -M intel two.o

two.o:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
   0:	8d 4c 24 04          	lea    ecx,[esp+0x4]
   4:	83 e4 f0             	and    esp,0xfffffff0
   7:	ff 71 fc             	push   DWORD PTR [ecx-0x4]
   a:	55                   	push   ebp
   b:	89 e5                	mov    ebp,esp
   d:	51                   	push   ecx
   e:	83 ec 04             	sub    esp,0x4
  11:	c7 05 00 00 00 00 05 	mov    DWORD PTR ds:0x0,0x5
  18:	00 00 00
  1b:	e8 fc ff ff ff       	call   1c <main+0x1c>
  20:	b8 00 00 00 00       	mov    eax,0x0
  25:	83 c4 04             	add    esp,0x4
  28:	59                   	pop    ecx
  29:	5d                   	pop    ebp
  2a:	8d 61 fc             	lea    esp,[ecx-0x4]
  2d:	c3                   	ret

[..]/02-two-files$ objdump -d -M intel inc.o

inc.o:     file format elf32-i386


Disassembly of section .text:

00000000 <increment>:
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
   3:	a1 00 00 00 00       	mov    eax,ds:0x0
   8:	83 c0 01             	add    eax,0x1
   b:	a3 00 00 00 00       	mov    ds:0x0,eax
  10:	90                   	nop
  11:	5d                   	pop    ebp
  12:	c3                   	ret
```
Vedem că, într-adevăr, conform tabelelor de relocare avem următoarele relocări:
* în fișierul `two.o`, la offsetul `0x13` în secțiunea `.text` este valoarea `0x00000000` unde se va reloca simbolul `num_items`
* în fișierul `two.o`, la offsetul `0x1c` în secțiunea `.text` este un placeholder unde se va reloca simbolul `increment`
* în fișierul `inc.o`, la offsetul `0x04` și la offsetul `0xc` în secțiunea `.text` se găsește valoarea `0x00000000` unde se va reloca simbolul `num_items`

Pentru verificarea relocării, urmărim codul în limbaj de asamblare al executabilului `two`:
```
[..]/02-two-files$ objdump -d -M intel two

two:     file format elf32-i386


Disassembly of section .text:

08048100 <main>:
 8048100:	8d 4c 24 04          	lea    ecx,[esp+0x4]
 8048104:	83 e4 f0             	and    esp,0xfffffff0
 8048107:	ff 71 fc             	push   DWORD PTR [ecx-0x4]
 804810a:	55                   	push   ebp
 804810b:	89 e5                	mov    ebp,esp
 804810d:	51                   	push   ecx
 804810e:	83 ec 04             	sub    esp,0x4
 8048111:	c7 05 00 a0 04 08 05 	mov    DWORD PTR ds:0x804a000,0x5
 8048118:	00 00 00
 804811b:	e8 0e 00 00 00       	call   804812e <increment>
 8048120:	b8 00 00 00 00       	mov    eax,0x0
 8048125:	83 c4 04             	add    esp,0x4
 8048128:	59                   	pop    ecx
 8048129:	5d                   	pop    ebp
 804812a:	8d 61 fc             	lea    esp,[ecx-0x4]
 804812d:	c3                   	ret

0804812e <increment>:
 804812e:	55                   	push   ebp
 804812f:	89 e5                	mov    ebp,esp
 8048131:	a1 00 a0 04 08       	mov    eax,ds:0x804a000
 8048136:	83 c0 01             	add    eax,0x1
 8048139:	a3 00 a0 04 08       	mov    ds:0x804a000,eax
 804813e:	90                   	nop
 804813f:	5d                   	pop    ebp
 8048140:	c3                   	ret
 8048141:	66 90                	xchg   ax,ax
 8048143:	66 90                	xchg   ax,ax
 8048145:	66 90                	xchg   ax,ax
 8048147:	66 90                	xchg   ax,ax
 8048149:	66 90                	xchg   ax,ax
 804814b:	66 90                	xchg   ax,ax
 804814d:	66 90                	xchg   ax,ax
 804814f:	90                   	nop

08048150 <_start>:
 8048150:	e8 ab ff ff ff       	call   8048100 <main>
 8048155:	89 c3                	mov    ebx,eax
 8048157:	b8 01 00 00 00       	mov    eax,0x1
 804815c:	cd 80                	int    0x80
```
Observăm că acum, în locurile de tip placeholder în fișierele obiect, apar adresele efective ale simbolurilor `increment` și `num_items`: `0x804812e`, respectiv `0x804a000`.
Mai observăm și că, de la adresa `0x8048141` până la adresa `0x8048150` au fost puse intrucțiuni care nu au efect (`xchg ax, ax`, `nop`) din rațiuni de aliniere;
adresa simbolului `_start` este `0x8048150`, aliniată la 16 octeți.

Totodată, adresa simbolului `_start` (`0x8048150`) este adresa entry pointului programului:
```
[..]/02-two-files$ readelf -h two
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           Intel 80386
  Version:                           0x1
  Entry point address:               0x8048150
  Start of program headers:          52 (bytes into file)
  Start of section headers:          4656 (bytes into file)
  Flags:                             0x0
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         5
  Size of section headers:           40 (bytes)
  Number of section headers:         10
  Section header string table index: 9
```

## Relocări

Până acum relocările pe care le-am observat au fost prezente *în* secțiunea `.text` a unui fișier obiect.
Într-un loc din secțiunea `.text` a unui fișier obiect putem reloca un simbol din altă secțiune a aceluiași fișier obiect (de exemplu secțiunea `.data`) sau putem reloca un simbol din orice secțiune a altui fișier obiect (`.text`, `.data` etc.)

Relocările se pot face și în alte secțiuni.
În directorul `03-reloc/` avem un exemplu de relocare în secțiunea `.data`.
Directorul are un conținut similar directorului `02-two-files/`, doar că acum nu se mai apelează funcția `increment()`, ci se folosește pointerul de funcție `operator`, definit astfel în fișierul `inc.`:
```
static void increment(void);
void (*operator)(void) = increment;
```
Pointerul de funcție `operator` este o variabilă globală ce se va găsi în secțiunea `.data` și va fi inițializată la adresa funcției `increment()`.
Întrucât nu știm adresa efectivă a funcției `increment()`, ne așteptăm să existe o relocare.

Investigăm tabela de relocare a fișierul obiect `inc.o`:

```
[..]/03-reloc$ readelf -r inc.o

Relocation section '.rel.text' at offset 0x184 contains 2 entries:
 Offset     Info    Type            Sym.Value  Sym. Name
00000004  00000a01 R_386_32          00000000   num_items
0000000c  00000a01 R_386_32          00000000   num_items

Relocation section '.rel.data' at offset 0x194 contains 1 entry:
 Offset     Info    Type            Sym.Value  Sym. Name
00000000  00000201 R_386_32          00000000   .text

[...]
```
Observăm că avem o relocare în zona de date (`.rel.data`).
Relocarea se găsește la offsetul `0` în secțiunea `.data` (coloana `Offset`) și referă adresa `0` din secțiunea `.text`.
Ambele valori (offset și adresă - coloanele `Offset` și `Sym.Value`) sunt `0` pentru că acestea sunt offseturile curente (din fișierul obiect `inc.o`) ale simbolurilor, respectiv, `operator` și `increment` în secțiunea `.data` și `.text`:
```
[..]/03-reloc$ nm inc.o
00000000 t increment
         U num_items
00000000 D operator
```
Adică se precizează că valoarea variabilei `operator` va fi completată, la relocare, cu adresa simbolului `increment`.
Dacă offseturile simbolurilor `operator` și `increment` ar fi fost altele (diferite de `0`) ar fi apărut corespunzător și în tabela de relocare.
Observăm acest lucru și inspectând conținutul zonei `.data` din fișierului obiect `inc.o`:
```
[..]/03-reloc$ readelf -x .data inc.o

Hex dump of section '.data':
 NOTE: This section has relocations against it, but these have NOT been applied to this dump.
  0x00000000 00000000                            ....
```
La adresa `0x00000000` din secțiunea `.data` (prima coloană), corespunzătoarea simbolului `operator`, se află valoarea `00000000` (a doua coloană), adică adresa / offsetul simbolului `increment`.
Observăm și precizarea că secțiunea dispune de relocări care nu au fost încă aplicate.

În urma relocării de la linkare, conținutul variabilei `operator` va fi completat cu adresa stabilită pentru funcția `increment`.
Dacă analizăm simbolurile fișierului executabil `two` observăm că adresele simbolurilor `operator`, respectiv `increment`, sunt `0x0804a004` și `0x08048130`:
```
[..]/03-reloc$ nm two
0804a008 D __bss_start
0804a008 D _edata
0804a008 D _end
08048160 r __GNU_EH_FRAME_HDR
08048130 t increment
08048100 T main
00000001 a __NR_exit
0804a000 D num_items
0804a004 D operator
08048150 T _start
```

Analizând conținutul secțiunii `.data`, observăm că la adresa `0x0804a004`, corespunzătoare simbolului `operator`, se găsește valoarea `0x08048130` (format little-endian), corespunzătoare simbolului `increment`:
```
[..]/03-reloc$ readelf -x .data two

Hex dump of section '.data':
  0x0804a000 0a000000 30810408                   ....0...
```
Ca o confirmare, vedem că la adresa `0x0804a000`, corespunzătoare simbolului `num_items`, se găsește valoarea `0xa` (`10` în zecimal), adică valoarea cu care a fost inițializată variabila, așa cum reiese din fișierul cod sursă `two.c`.

## Biblioteci

În general linkăm fișiere obiect într-un fișier executabil.
Dacă folosim frecvent fișiere obiect, mai ales în cazul în care acestea expun un API, are sens să creăm colecții cu aceste fișiere obiect pentru a fi refolosite.
Aceste colecții sunt numite **biblioteci**.

O bibliotecă agregă mai multe fișiere obiect.
Legarea unui biblioteci este echivalentă cu legarea fișierelor obiect conținute.
Avantajele folosirii bibliotecilor sunt:
* Nu mai recompilăm de fiecare dată fișierele cod sursă în fișiere obiect.
* Există un singur fișier care poate fi distribuit ușor.

În directorul `04-lib/`, avem fișierele cod sursă și fișierul `Makefile`, pe care le folosim ca să obținem două fișiere executabile: `main` și `main_lib`.
La rularea comenzii `make` vom obține cele două fișiere executabile:
```
[..]/04-lib$ ls
inc.c  inc.h  main.c  Makefile  start.asm

[..]/04-lib$ make
cc -fno-PIC -m32   -c -o main.o main.c
nasm -f elf32 -o start.o start.asm
cc -fno-PIC -m32   -c -o inc.o inc.c
cc -nostdinc -nostdlib -no-pie -m32  main.o start.o inc.o   -o main
ar rc libinc.a inc.o
cc -nostdinc -nostdlib -no-pie -m32 -L. -o main_lib main.o start.o -linc

[..]/04-lib$ ls
inc.c  inc.h  inc.o  libinc.a  main  main.c  main_lib  main.o  Makefile  start.asm  start.o
```
Executabilul `main` este obținut din legarea fișierelor obiect `main.o`, `inc.o` și `start.o`, în vreme ce executabilul `main_lib` este obținut din legarea fișierelor obiect `main.o`, `start.o` și a fișierului bibliotecă `libinc.a`.
Fișierul bibliotecă `libinc.a` este obținută la rândul său din fișierul obiect `inc.o`.
În general, o bibliotecă conține mai multe fișiere obiect; aici conține un singur fișier obiect (`inc.o`), ca exemplu didactic.

Fișierele `main` și `main_lib` sunt identice, acest lucru datorându-se și faptului că ordine fișierelor obiect este aceeași în comenzile de linkare:
```
[...]/04-lib$ ls -l main main_lib
-rwxr-xr-x 1 razvan razvan 1588 Jan 17 16:34 main
-rwxr-xr-x 1 razvan razvan 1588 Jan 17 16:34 main_lib

[..]/04-lib$ diff -s main main_lib
Files main and main_lib are identical
```

Atunci când legăm biblioteci, trebuie să precizăm directorul în care linkerul localizează bibliotecile (*library location*).
Realizăm acest lucru prin intermediul opțiunii `-L.`, opțiune cu care am indicat linkerului să localizeze fișierul bibliotecă `libinc.a` în directorul curent (`.` - *dot*).

Numele unui fișier bibliotecă începe cu prefixul `lib` urmat de numele bibliotecii.
Comanda de linkare va conține opțiunea `-l` urmată de numele bibliotecii.
În cazul nostru, biblioteca se cheamă `inc`, deci numele fișierului bibliotecă este `libinc.a`, iar argumentul folosit este `-linc`.

## Linkare statică

În exemplele de până acum, am creat executabile care au fost compuse strict din codul scris în fișierele cod sursă (și în fișierul de suport `start.asm`).
Acest mod de dezvoltare poate fi numit un mod de dezvoltare *freestanding*, pentru că nu include componente considerate standard, precum biblioteca standard C.
În mod obișnuit, când dezvoltăm aplicații, acestea vor include biblioteca standard C.

Biblioteca standard C este o colecție de funcționalități de bază pentru dezvoltarea aplicațiilor: lucrul cu fișiere, lucrul cu șiruri, gestiunea memoriei, comunicare inter-proces, gestiunea timpului.
În exemplele de până acum, pentru a ține lucrurile simple, am folosit la linkare argumentele `-nostdlib -nostdinc` ca să nu ne legăm la biblioteca standard și nu includem headerele standard.
În absența argumentelor `-nostdlib -nostdinc`, linkerul va lega implicit biblioteca standard C;
nu este nevoie să precizăm noi acest lucru.

În directorul `05-static/` avem un conținut similar directorului `04-lib/`.
Diferența este că acum, în fișierul cod sursă `inc.c` există funcția `print()` care apelează funcția `printf()` din biblioteca standard C.
Iar linkarea se face cu biblioteca standard C, în absența argumentelor `-nostdlib -nostdinc` din comanda de linkare.
Linkarea cu biblioteca standard C duce la includerea suportului necesare pentru inițializarea programului, de aceea nu mai este nevoie de fișierul de suport `start.asm`.

Similar exemplului din directorul `04-lib/`, folosim comanda `make` pentru a obține două executabile (`main` și `main_lib`):
```
[..]/05-static$ ls
inc.c  inc.h  main.c  Makefile

[..]/05-static$ make
cc -fno-PIC -m32   -c -o main.o main.c
cc -fno-PIC -m32   -c -o inc.o inc.c
cc -static -no-pie -m32  main.o inc.o   -o main
ar rc libinc.a inc.o
cc -static -no-pie -m32 -L. -o main_lib main.o -linc

[..]/05-static$ ls
inc.c  inc.h  inc.o  libinc.a  main  main.c  main_lib  main.o  Makefile

[..]/05-static$ ls -l main main_lib
-rwxr-xr-x 1 razvan razvan 661856 Jan 17 16:54 main
-rwxr-xr-x 1 razvan razvan 661856 Jan 17 16:54 main_lib

[..]/05-static$ diff -s main main_lib
Files main and main_lib are identical

[..]/05-static$ ./main
num_items: 1

[..]/05-static$ ./main_lib
num_items: 1
```
Fișierele `main` și `main_lib` sunt identice și, deci, au același comportament.

Observăm că cele două fișiere au o dimensiune foarte mare, în jur de 600 KB.
Pănâ acum fișierele avea o dimensiune de circa 5KB.
Aceasta se datorează legării cu biblioteca standard C.
Biblioteca standard C oferă mult conținut de suport care este inclus în executabil în urma legării.
Numărul de simboluri prezente acum în executabil este mare:
```
[..]/05-static$ nm main | wc -l
2001
```
Sunt prezente peste `2000` de simboluri, unde până acum numărul era în jur de `10`.

Fișierul bibliotecii standard C este destul de mare (aproape `4 MB`), de unde și dimensiunea mare a fișierului executabil rezultat:
```
[..]/05-static$ ls -lh /usr/libx32/libc.a
-rw-r--r-- 1 root root 3.9M Dec  7 18:38 /usr/libx32/libc.a
```
Chiar dacă în cazul nostru am folosit doar funcția `printf()`, dimensiunea informațiilor incluse în executabilul final, provenind din biblioteca standard C, este sesizabilă.

Astfel, atunci când folosim biblioteca standard C, avem avantajul suportului oferit pentru mai multe operații și asigurarea portabilității pe mai multe platforme (sisteme de operare, arhitecturi de procesor).
Dar avem dezavantajul că biblioteca duce la includerea unui conținut ridicat de suport, mărind dimensiunea executabilului final.

În exemplul de aici, legarea cu biblioteca standard C este legare statică (*static linking*).
Am folosit argumentul `-static` la linkare pentru aceasta.
În linkarea statică, componentele bibliotecii folosite de fișierele obiect linkate (sau de alte fișiere bibliotecă) sunt copiate în fișierul executabil final.
Nu este vorba doar de componentele direct apelate ci de cele care sunt apelate indirect din cadrul bibliotecii.
Întregul lanț de componente dependente (date și cod) sunt adăugate în executabilul final.

În exemplul nostru, atât biblioteca standard C cât și biblioteca `libinc.a` sunt linkate static în executabilul final `main_lib`.
Biblioteca standard C este linkată static (fără biblioteca `libinc.a`) în executabilul final `main`.

În general, în Linux, fișierele bibliotecă ce vor fi linkate static au extensia `.a`.
Aceste biblioteci sunt numite și biblioteci statice.

Avantajul linkării statice este că fișierul executabil rezultat poate rula pe orice configurație de sistem (dar pe aceeași platformă), indiferent ce versiuni de biblioteci sunt sau nu sunt pe acel sistem.
Dezavantajul este desigur, dimensiunea mare a executabilelor.
De asemenea, dacă pe un sistem rulează 10 procese încărcate din executabile statice, foarte probabil acele procese vor avea individual componente comune din biblioteca standard C (sau alte biblioteci), componente care ar fi putut fi partajate.

De aceea, în zilele noastre, majoritatea executabilelor sunt generate folosind linkare dinamică.

## Linkare dinamică

Linkarea dinamică înseamnă că în executabil nu sunt incluse componentele folosite din bibliotecă.
Acestea vor fi incluse mai târziu, la încărcare (*load time*) sau chiar la rulare (*runtime*).
În urma linkării dinamice, executabilul reține referințe la bibliotecile folosite și la simbolurile folosite din cadrul acestora.
Aceste referințe sunt similare unor simboluri nedefinite.
Rezolvarea acestor simboluri are loc mai târziu, prin folosirea unui loader / linker dinamic.

Așadar, în cazul linkării dinamice, aspecte precum rezolvarea simbolurilor sau stabilirea adreselor nu sunt efectuate pentru simbolurile bibliotecilor.

În directorul `06-dynamic/` avem un conținut similar directorului `05-static/`.
Diferența este că acum, folosim linkare dinamică în loc de linkare statică pentru biblioteca standard C.
Pentru aceasta, am renunțat la argumentul `-static` folosit la linkare.

Pentru acest exemplu, obținem un singur executabil `main`, din legarea statică cu biblioteca `libinc.a` și legarea dinamică cu biblioteca standard C.
Similar exemplului din directorul `05-static/`, folosim comanda `make` pentru a obține executabilul `main`:
```
[..]/06-dynamic$ ls
inc.c  inc.h  main.c  Makefile

[..]/06-dynamic$ make
cc -fno-PIC -m32   -c -o main.o main.c
cc -fno-PIC -m32   -c -o inc.o inc.c
ar rc libinc.a inc.o
cc -no-pie -m32 -L. -o main main.o -linc

[..]/06-dynamic$ ls
inc.c  inc.h  inc.o  libinc.a  main  main.c  main.o  Makefile

[..]/06-dynamic$ ls -l main
-rwxr-xr-x 1 razvan razvan 7272 Jan 17 17:42 main

[..]/06-dynamic$ ./main
num_items: 1

[..]/06-dynamic$ file main
main: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux.so.2, for GNU/Linux 3.2.0, BuildID[sha1]=8d99d4600dc70919266f4063da1eaf8ff9ce96e1, not stripped

[..]/06-dynamic$ file ../05-static/main
../05-static/main: ELF 32-bit LSB executable, Intel 80386, version 1 (GNU/Linux), statically linked, for GNU/Linux 3.2.0, BuildID[sha1]=60adf8390374c898998c0b713a8b1ea0c255af38, not stripped
```
Fișierul executabil `main` obținut prin linkare dinamică are un comportament identic fișierului executabil `main` obținut prin linkare statică.
Observăm că dimensiunea sa este mult mai redusă: ocupă `7 KB` comparativ cu `600 KB` cât avea varianta sa statică.
De asemenea, folosind utilitarul `file`, aflăm că este executabil obținut prin linkare dinamică (*dynamically linked*), în vreme cel obținut în exemplul anterior este executabil obținut prin linkare statică (*statically linked*).

Investigăm simbolurile executabilului:
```
[..]/06-dynamic$ nm main
[...]
0804848c T increment
0804847c T init
[...]
         U __libc_start_main@@GLIBC_2.0
08048446 T main
0804a020 b num_items
080484a9 T print
         U printf@@GLIBC_2.0
0804849f T read
[...]
08048330 T _start
[...]
```
Simbolurile obținute din modulul obiect `main.o` și din biblioteca statică `libinc.o` sunt rezolvate și au adrese stabilite.
Observăm că folosirea bibliotecii standard C a dus la existența simboblului `_start`, care este entry pointul programului.
Dar, simbolurile din biblioteca standard C, (`printf`, `__libc_start_main`) sunt marcate ca nedefinite (`U`).
Aceste simboluri nu sunt prezente în executabil: rezolvarea, stabilirea adreselor și relocarea lor se va realiza mai târziu, la încărcare (load time).

La încărcare, o altă componentă software a sistemului, loaderul / linkerul dinamic, se va ocupa de:
* localizarea în sistemul de fișiere a fișierelor bibliotecă dinamice care sunt folosite de fișierul executabil încărcat
* încărcarea în memorie a acelor biblioteci dinamice, lucru care duce și la stabilirea adreselor simbolurilor din bibliotecă
* parcurgerea simbolurilor nedefinite din cadrul fișierului executabil, localizarea lor în biblioteca înacarcată dinamic și relocarea lor în executabilul încărcat în memorie

Putem investiga bibliotecile dinamice folosite de un executabil prin intermediul utilitarului `ldd`:
```
[..]/06-dynamic$ ldd main
	linux-gate.so.1 (0xf7f97000)
	libc.so.6 => /lib/i386-linux-gnu/libc.so.6 (0xf7d8a000)
	/lib/ld-linux.so.2 (0xf7f98000)
```
În rezultatul de mai sus, observăm că executabilul folosește biblioteca standard C, localizată la calea `/lib/i386-linux-gnu/libc.so.6`.
`/lib/ld-linux.so.2` este loaderul / linkerul dinamic.
`linux-gate.so.1` e o componentă specifică Linux pe care nu vom insista.

Pe lângă dimensiunea redusă a executabilelor, marele avantaj al folosirii linkării dinamice, este că se pot partaja secțiunile de cod (nu de date) ale bibliotecilor dinamice.
Când un executabil dinamic este încărcat, se identifică bibliotecile dinamice de care acesta depinde.
Dacă o bibliotecă dinamică deja există în memorie, se face referire direct la zona existentă, partajând astfel biblioteca dinamică.
Acest lucru conduce la o reducere semnificativă a memoriei ocupate de aplicațiile sistemului.
10 aplicații care folosesc, probabil toate, biblioteca standard C, vor partaja codul bibliotecii.

Din acest motiv, bibliotecile dinamice mai sunt numite și obiecte partajate (*shared objects*).
De aici este, în Linux, extensia `.so` a fișierelor de tip bibliotecă partajată.

## Biblioteci cu linkare dinamică

Numele corect al unei biblioteci dinamice este bibliotecă cu linkare dinamică (*dynamically linked library*) sau bibliotecă partajată.
În Windows, bibliotecile dinamice sunt numite *dynamic-link libraries* de unde și extensia `.dll`.

Din punctul de vedere al comenzii folosite, nu diferă linkarea unei biblioteci dinamice sau a unei biblioci statice.
Diferă executabilul obținut, care va avea nedefinite simbolurile folosite din bibliotecile dinamice.
De asemenea, loaderul / linkerul dinamic trebuie să fie informat de locul bibliotecii dinamice.

În directorul `07-dynlib/` avem un conținut similar directorului `06-dynamic/`.
Diferența este că acum, folosim linkare dinamică în loc de linkare statică și pentru a include funcționalitatea `inc.c`, nu doar pentru biblioteca standard C.
Pentru aceasta, construim fișierul bibliotecă partajată `libinc.so`, în locul fișierului bibliotecă statică `libibc.a`.

Similar exemplului din directorul `06-dynamic/`, folosim comanda `make` pentru a obține executabilul `main`:
```
[..]/07-dynlib$ ls
inc.c  inc.h  main.c  Makefile

[..]/07-dynlib$ make
cc -fno-PIC -m32   -c -o main.o main.c
cc -fno-PIC -m32   -c -o inc.o inc.c
cc -m32 -shared -o libinc.so inc.o
cc -no-pie -m32 -L. -o main main.o -linc

[..]/07-dynlib$ ls
inc.c  inc.h  inc.o  libinc.so  main  main.c  main.o  Makefile

[..]/07-dynlib$ ls -l main
-rwxr-xr-x 1 razvan razvan 7200 Jan 17 18:11 main

[..]/07-dynlib$ nm main
[...]
         U increment
         U init
080483ac T _init
[...]
         U __libc_start_main@@GLIBC_2.0
08048556 T main
         U print
         U read
[...]
08048440 T _start
```
Executabilul obținut are dimensiunea în jur de `7 KB` puțin mai mică decât a executabilului din exemplul anterior.
Diferența cea mai mare este că, acum, simbolurile din biblioteca `libinc.so` (`increment`, `init`, `print`, `read`) sunt nerezolvate.

Dacă încercăm lansarea în execuție a executabilului, observăm că primim o eroare:
```
[..]/07-dynlib$ ./main 
./main: error while loading shared libraries: libinc.so: cannot open shared object file: No such file or directory
```
Eroarea spune că nu poate localiza biblioteca `libinc.so` la încărcare (*loading*).
Este deci, o eroare de loader.

O eroare similară obținem dacă folosim utilitarul `ldd`:
```
[..]/07-dynlib$ ldd ./main
	linux-gate.so.1 (0xf7f9f000)
	libinc.so => not found
	libc.so.6 => /lib/i386-linux-gnu/libc.so.6 (0xf7d92000)
	/lib/ld-linux.so.2 (0xf7fa0000)
```
La fel, biblioteca `libinc.so` nu este găsită.

Motivul este că nu am precizat loaderului unde să caute biblioteca partajată.
Loaderul are definită calea unde să caute biblioteca standard C (`/lib/i386-linux-gnu/libc.so.6`), dar nu deține informații despre `libinc.so`.

Ca să precizăm loaderului calea către bibliotecă, o cale simplă, de test, este folosirea variabilei de mediu `LD_LIBRARY_PATH`, pe care o inițializăm la directorul curent (`.` - *dot*).
Odată folosită variabila de mediu `LD_LIBRARY_PATH`, lansarea în execuție a executabilului va funcționa, la fel și folosirea `ldd`:
```
[..]/07-dynlib$ LD_LIBRARY_PATH=. ldd ./main
	linux-gate.so.1 (0xf7eda000)
	libinc.so => ./libinc.so (0xf7ed2000)
	libc.so.6 => /lib/i386-linux-gnu/libc.so.6 (0xf7cca000)
	/lib/ld-linux.so.2 (0xf7edb000)

[..]/07-dynlib$ LD_LIBRARY_PATH=. ./main
num_items: 1
```

Variabila de mediu `LD_LIBRARY_PATH` pentru loader este echivalentul opțiunii `-L` în comanda de linkare: precizează directoarele în care să fie căutate biblioteci pentru a fi încărcate, respectiv linkate.
Folosirea variabilei de mediu `LD_LIBRARY_PATH` este recomandată pentru teste.
Pentru o folosire robustă, există alte mijloace de precizare a căilor de căutare a bibliotecilor partajate, documentate în [pagina de manual a loaderului / linkerului dinamic](https://man7.org/linux/man-pages/man8/ld.so.8.html#DESCRIPTION).

## Sumar

Linking (sau linkare / legare sau link editare / editarea de legături) este faza finală a procesului de compilare.
Programul folosit pentru linking este numit **linker**.
Linkerul folosește ca date de intrare fișiere obiect și fișiere de tip bibliotecă; produce fișiere executabile sau biblioteci dinamice.

Pentru a produce fișierul executabil, linkerul realizează o serie de acțiuni: rezolvarea simbolurilor, unificarea secțiunilor, stabilirea adreselor, relocarea simbolurilor, stabilirea entry pointului.
După aceste faze, fișierul executabil are toate informațiile pentru a fi încărcat în memorie și folosit în cadrul unui proces.

În sistemele de operare moderne, se folosește linkare dinamică.
În cazul linkării dinamice, modulele obiect rezultate în urma compilării aplicației sunt linkate la biblioteci partajate.
Părțile din aceste biblioteci partajate nu sunt incluse în executabil, vor fi incluse la încărcare.
Bibliotecile partajate, după cum le spune numele, pot fi partajate în memorie între procese diferite.

O altă variantă este folosirea bibliotecilor statice, în care toate părțile folosite sunt incluse în executabile.
Acest lucru rezultă în executabile care nu depind de configurația sistemului, dar care ocupă mai mult spațiu și care nu vor putea partaja informații în memorie după încărcare.

## Referințe

https://people.cs.pitt.edu/~xianeizhang/notes/Linking.html

https://docs.oracle.com/cd/E19683-01/817-3677/chapter2-88783/index.html

https://stac47.github.io/c/relocation/elf/tutorial/2018/03/01/understanding-relocation-elf.html

<a id="ds" href="#refds"><sup>1</sup></a>Construcții de forma `ds:0x0` înseamnă offsetul `0x0` în cadrul segmentului de date (indicat de registrul `ds` - *data segment*).
Sistemele de operare moderne folosesc un spațiu de adresă unic liniar pentru fiecare proces (*flat address space*), în care segmentul de date (`ds`), segmentul de cod (`cs`) și cel de stivă (`ss`) au aceeași valoare și referă aceeași zonă de memorie.
De aceea, vom interpreta construcții de forma `ds:0x0` ca însemnând adresa `0x0`.
Construcția `ds:0x804a000`, de exemplu, înseamnă `0x804a000`.

<a id="align" href="#refalign"><sup>2</sup></a>Și executabilele (dinamice) pot conține tabele de relocare (folosite de secțiunile GOT - *Global Offset Table* și PLT - *Procedure Linkage Table*).
Aceste tabele de relocare sunt folosite la încărcare (*loading*) pentru rezolvarea unor simboluri disponibile doar la load time.

<a id="align" href="#refalign"><sup>3</sup></a>Alinierea codului (și a datelor în general) este utilă pentru creșterea vitezei accesului la date.
Procesorul citește datele/codul în cuvinte de procesor.
Dacă acestea nu sunt aliniate la cuvântul procesorului, vor rezulta în întârzieri de citire.
Tipic, în cod, țintele unor instrucțiuni de salt (`jmp`, `call`) sunt aliniate, cum este cazul adresleor de funcții.
Detalii [aici](https://stackoverflow.com/a/4909633/4804196).
