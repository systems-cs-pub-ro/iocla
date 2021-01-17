# Linking

Linking (sau linkare / legare sau link editare / editarea de legături) este faza finală a procesului de compilare.
Linkingul agregă mai multe fișiere obiect (sau colecții de fișiere obiect: biblioteci) într-un fișier executabil.
Un fișier executabil conține datele și codul necesare pentru a porni o aplicație / un proces.
Pornirea unui proces dintr-un fișier executabil este numită **loading** (încărcare).
Fișierul executabil este încărcat (**loaded**) în memorie; codul și datele din fișierul executabil astfel încărcat în memorie sunt folosite pentru a porni un proces.
Spunem că fișierul executabil este **imaginea procesului**.

La compilare, linkare și încărcare se realizează diferite acțiuni specifice.
Numim aceste momente *compile-time*, *link-time* și *load-time*.
Rularea efectivă a codului în cadrul unui proces este numită *run-time*.

Programul folosit pentru linking este numit **linker**.
Linkerul folosește ca intrare fișiere obiect și fișiere de tip bibliotecă; produce fișiere executabile sau biblioteci dinamice.
Nu vom insista pe cazul în care linkerul produce biblioteci dinamice, doar pe cazul în care produce fișiere executabile.
Pe scurt, linkerul folosește fișiere care conțin date și cod (mașină) și generează un alt fișier (executabil) care conține date și cod (mașină).
Acest fișier executabil este rezultatul agregării datelor și codului (mașină) din fișierele folosite.

## Formate de fișiere executabile

TODO

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

## Stabilirea unui punct de intrare în program

**Entry pointul** unui program este adresa primei instrucțiuni executate din fișierul executabil.
Entry pointul are sens doar pentru fișiere executabile, nu și pentru fișiere obiect.

În directorul `01-one-file/` vom compila un fișier cod sursă C `one.c` în fișierul obiect `one.o`.
Ca suport pentru procesul de linkare, vom asambla fișierul în limbaj de asamblare `start.s` în fișierul obiecti `start.o`.
Apoi vom lega cele două fișiere obiect `one.o` și `start.o` în fișierul executabil `one`.
Prezența fișierului în limbaj de asamblare este necesară pentru procesul de linking; nu vom insista pe acesta acum.
În principiu, pentru simplitate, este vorba de compilarea și legarea unui **singur** fișier `one.c`.

După rularea comenzii `make` vom obține fișierele obiect `one.o`, `start.o` și fișierul executabil `one`.

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

## Address binding

Linkerul atașează fiecărui simbol din fișierul executabil rezultat o adresă.
Aceste adrese vor fi folosite la încărcarea executabilului în memorie, la crearea procesului.
O astfel de adresă este adresa entry pointului, adresa primei instrucțiuni ce va fi executată.

Simbolurile din fișierele obiect nu au atribuite adrese.
Adresele vor atribuite fiecărui simbol la linkare.
Când investigăm un fișier obiect, "adresele" afișate sunt de fapt offseturile în cadrul secțiunilor.
Comanda de mai jos afișează simbolurile din fișierul obiect `one.o`:
```
[..]/01-one-file$ nm one.o
00000000 T increment
00000013 T main
00000000 D num_items
```
În secvența de mai sus ar apărea că simbolul `increment` și simbolul `num_items` au acceași adresă.
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
```
Adresele / offseturile sunt cele așteptate: `0` pentru `increment` și `0x13` pentru `main`.

De cealaltă parte, în cadrul fișierului executabil, fiecare simbol are asociată o adresă.
Adresa este unică în cadrul fișierului executabil, nu mai este offset în cadrul unei secțiuni, și va fi folosită la load-time pentru crearea procesului.
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
Observăm că secțiunea `.text` are adresa de început `0x080480f8`, iar secțiunea `.data` are adresa de început `0x0804a000`.
Simbolul `increment` se găsește la adresa `0x080480f8` adică la începutul secțiunii `.text`.
Simbolul `num_items` se găsește la adresa `0x0804a000` adică la începutul secțiunii `.data`.
Simbolul `main` se găsește la adresa `0x0804810b` adică la offsetul `0x13` în secțiunea `.text`.

## Relocarea simbolurilor

În dezasamblarea fișierului obiect `one.o`, respectiv a executabilului `one`, observăm că instrucțiunile care referă variabila `num_items` sunt:
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

În fișierul executabil codul instrucțiunilor conține adresa efectivă a variabilei `num_items` (`0x0804a000`), scrisă în format little endian.
În fișierul obiect `one.o`, însă, nu apare adresa efectivă a variabilei `num_items`, ci apare `0x00000000`.
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
Pentru aceasta, fișierele obiect relocabile conțin **tabele de relocare** (*relocation tables*).

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
La fel, necunoscându-se adresa simbolului `num_items`, referința este marcată cu un placeholder.

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

## Rezolvarea simbolurilor

Un fișier obiect, obținut în urma compilării unui fișier cod sursă, conține simbobluri definite și nedefinite (*undefined*).
Simbolurile nedefinite sunt simboluri **declarate** și **folosite** în fișierul cod sursă inițial.
După cum le spune și numele, nu sunt, însă, definite, adică nu se aloca memorie pentru ele (și deci, în viitor, adrese).

În limbajul C, declarăm funcții prin intermediul antetului lor, și le folosim prin apelarea lor:
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
Adică un alt modul poate defini o funcție (o funcție care să aibă corp) și o variabilă, rezultând în alocarea de memorie pentru aceste simoboluri: cod pentru funcție și date pentru variabilă.
Este rolul linkerului de a parcurge fișierele obiect și de a extrage simbolurile nedefinite.
Pentru fiecare referință de simbol nedefinit, linkerul va căuta fișierul obiect unde simbolul este definit.
Apoi va realiza conexiunea între cele două.
Adică locul unde era referit simbolul nedefinit va fi acum completat cu adresa corectă.

## Unificarea secțiunilor

TODO

## Rezolvarea simbolurilor

TODO

## Linkare statică

TODO

## Linkare dinamică

TODO

## Biblioteci cu linkare dinamică

TODO

## Sumar

TODO

## Referințe

https://people.cs.pitt.edu/~xianeizhang/notes/Linking.html

https://docs.oracle.com/cd/E19683-01/817-3677/chapter2-88783/index.html

https://stac47.github.io/c/relocation/elf/tutorial/2018/03/01/understanding-relocation-elf.html
