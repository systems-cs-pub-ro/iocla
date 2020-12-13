# Linking

Linking (sau link editare sau legare sau editarea de legături) este faza finală a procesului de compilare.
Linkingul agregă mai multe fișiere obiect (sau colecții de fișiere obiect: biblioteci) într-un fișier executabil.
Un fișier executabile conține datele și codul necesare pentru a porni o aplicație / un proces.
Pornirea unui proces dintr-un fișier executabil este numită **loading** (încărcare).
Spunem că fișierul executabil este încărcat în memorie pentru a porni un proces.
Spunem că fișierul executabil este **imaginea procesului**.

La compilare, sau la linkare sau la încărcare, se realizează diferite acțiuni specifice.
Numim acele momente *compile-time*, *link-time* și *load-time*.
Rularea efectivă a codului unui proces este numită *run-time*.

Programul folosit pentru linking este numit **linker**.
Linkerul folosește ca intrare fișiere obiect și fișiere de tip bibliotecă; produce fișiere executabile sau biblioteci dinamice.
Nu vom insista pe cazul în care linkerul produce biblioteci dinamice, doar pe cazul în care produce fișiere executabile.
Pe scurt, linkerul folosește fișiere care conțin date și cod (mașină) și generează un alt fișier (executabil) care conține date și cod (mașină).
Acest fișier executabil este rezultatul agregării datelor și codului (mașină) din fișierele folosite.

## Formate de fișiere executabile

## Acțiunile linkerului

Linkerul produce un fișier executabil care conține datele și codul agregate din mai multe fișiere obiect.
Pentru a produce fișierul executabil, linkerul realizează o serie de acțiuni, pe care le vom detalia mai jos:
1. rezolvarea simbolurilor (*symbol resolution*): localizarea simbolurilor nedefinite ale unui fișier obiect în alte fișiere obiect
2. unificarea secțiunilor: unificarea secțiunilor de același tip din diferite fișiere obiect într-o singură secțiune în fișierul executabil
3. stabilirea adreselor secțiunilor și simbolurilor (*address binding*): după unificare se pot stabili adresele simbolurilor, rezultând în actualizarea, în executabil, anumitor instrucțiuni sau date care referă acele adrese
4. stabilirea unui punct de intrare în program (*entry point*): adică adresa primei instrucțiuni ce va fi executată

În mod obișnuit, secvența de mai sus este secvența de acțiuni realizate de linker, ordonate cronologic.
Pentru o mai ușoară înțelegere, vom detalia aceste acțiuni în ordine inversă.

## Stabilirea unui punct de intrare în program

**Entry pointul** unui program este adresa primei instrucțiuni executate din fișierul executabil.
Entry pointul are sens doar pentru fișiere executabile, nu și pentru fișiere obiect.

În directorul `01-one-file/` vom compila și lega un fișier cod sursă C: `one.c`.
Pentru procesul de linkare, vom asambla și lega un fișier în limbaj de asamblare (`start.s`).
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
  Entry point address:               0x8048124
  Start of program headers:          52 (bytes into file)
  Start of section headers:          5280 (bytes into file)
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
08048134 r __GNU_EH_FRAME_HDR
080480f8 T increment
0804810b T main
00000001 a __NR_exit
0804a000 D num_items
08048124 T _start
```

Simbolul `_start` este definit în fișierul în limbaj de asamblare `start.s`.
Simbolul `_start`, adică entry pointul, adică adresa primei instrucțiuni executate, este echivalentul unei funcții care apelează funcția `main()`.
Deci `main()` nu este entry pointul unui program, nu este prima funcție executată.
O altă secvență de cod, numită tipic, la fel ca în acest caz, `_start`, este prima executată.
Și aceasta apelează `main()`.

Așadar, dându-se unul sau mai multe fișiere obiect, linkerul creează executabilul și stabilește entry pointul acestuia.
Entry pointul are sens doar pentru fișiere executabile, **NU** pentru fișiere obiect.

## Rezolvarea simbolurilor

Un fișier obiect, obținut în urma compilării unui fișier cod sursă, conține simbobluri definite și nedefinite (*undefined*).
Simbolurile nedefinite sunt simboluri **declarate** și **folosite** în fișierul cod sursă inițial, fără a fi însă definite, adică fără a se aloca memorie pentru ele (și deci, în viitor, adrese).

În limbajul C, declarăm funcții prin intermediul antetului lor, și le folosim prin apelarea lor:
```
/* Declare function f. */
int f(void);

/* Use function f. */
a = f();
```

Declarăm variabile prefixându-le cu `extern`:
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
Pentru fiecare simbol nedefinit va căuta fișierul obiect unde aceste este definit și le va putea conecta.
Adică locul unde era referit acel simbol nedefinit va fi acum completat cu adresa corectă.
