# Laborator 12: Linking

<!-- Convert to DokuWiki format using Pandoc: pandoc -f markdown_github-hard_line_breaks -t dokuwiki README.md -->

Linking / Legare este faza finală a procesului de build.
Linking unifică mai multe fișiere obiect în fișier executabil.

Pentru a obține un fișier executabil din fișiere obiect, linkerul realizează următoarele acțiuni:
1. rezolvarea simbolurilor (*symbol resolution*): localizarea simbolurilor nedefinite ale unui fișier obiect în alte fișiere obiect
1. unificarea secțiunilor: unificarea secțiunilor de același tip din diferite fișiere obiect într-o singură secțiune în fișierul executabil
1. stabilirea adreselor secțiunilor și simbolurilor (*address binding*): după unificare se pot stabili adresele efective ale simbolurilor în cadrul fișierului executabil
1. relocarea simbolurilor (*relocation*): odată stabilite adresele simbolurilor, trebuie actualizate, în executabil, instrucțiunile și datele care referă adresele acelor simboluri
1. stabilirea unui punct de intrare în program (*entry point*): adică adresa primei instrucțiuni ce va fi executată

## Invocarea linkerului

Linkerul este, în general, invocat de utilitarul de compilare (`gcc`, `clang`, `cl`).
Astfel, invocarea linkerului este transparentă utilizatorului.
În cazuri specifice, precum crearea unei imagini de kernel sau imagini pentru sisteme încorporate, utilizatorul va invoca direct linkerul.

Dacă avem un fișier `app.c` cod sursă C, vom folosi compilatorul pentru a obține fișierul obiect `app.o`:
```
gcc -c -o app.o app.c
```
Apoi pentru a obține fișierul executabil `app` din fișierul obiect `app.o`, folosim tot utilitarul `gcc`:
```
gcc -o app app.o
```
În spate, `gcc` va invoca linkerul și va construi executabilul `app`.
Linkerul va face legătura și cu biblioteca standard C (libc).

Procesul de linking va funcționa doar dacă fișierul `app.c` are definită funcția `main()`, funcția principală a programului.
Fișierele linkate trebuie să aibă o singură funcție `main()` pentru a putea obține un executabil.

Dacă avem mai multe fișiere sursă C, invocăm compilatorul pentru fiecare fișier și apoi linkerul:
```
gcc -c -o helpers.o helpers.c
gcc -c -o app.o app.c
gcc -o app app.o helpers.o
```
Ultima comandă este comanda de linking, care leagă fișierele obiect `app.o` și `helpers.o` în fișierul executabil `app`.

În cazul fișierelor sursă C++, vom folosi comanda `g++`:
```
g++ -c -o helpers.o helpers.cpp
g++ -c -o app.o app.cpp
g++ -o app app.o helpers.o
```
Putem folosi și comanda `gcc` pentru linking, cu precizarea linkării cu biblioteca standard C++ (libc++):
```
gcc -o app app.o helpers.o -lstdc++
```

Utilitarul de linkare este, în Linux, `ld` și este invocat în mod transparent de `gcc` sau `g++`.
Pentru a vedea cum este invocat linkerul, folosim opțiunea `-v` a utilitarului `gcc`, cu un output precum:
```
/usr/lib/gcc/x86_64-linux-gnu/7/collect2 -plugin /usr/lib/gcc/x86_64-linux-gnu/7/liblto_plugin.so
-plugin-opt=/usr/lib/gcc/x86_64-linux-gnu/7/lto-wrapper -plugin-opt=-fresolution=/tmp/ccwnf5NM.res
-plugin-opt=-pass-through=-lgcc -plugin-opt=-pass-through=-lgcc_s -plugin-opt=-pass-through=-lc
-plugin-opt=-pass-through=-lgcc -plugin-opt=-pass-through=-lgcc_s --build-id --eh-frame-hdr -m elf_i386 --hash-style=gnu
--as-needed -dynamic-linker /lib/ld-linux.so.2 -z relro -o hello
/usr/lib/gcc/x86_64-linux-gnu/7/../../../i386-linux-gnu/crt1.o
/usr/lib/gcc/x86_64-linux-gnu/7/../../../i386-linux-gnu/crti.o /usr/lib/gcc/x86_64-linux-gnu/7/32/crtbegin.o
-L/usr/lib/gcc/x86_64-linux-gnu/7/32 -L/usr/lib/gcc/x86_64-linux-gnu/7/../../../i386-linux-gnu
-L/usr/lib/gcc/x86_64-linux-gnu/7/../../../../lib32 -L/lib/i386-linux-gnu -L/lib/../lib32 -L/usr/lib/i386-linux-gnu
-L/usr/lib/../lib32 -L/usr/lib/gcc/x86_64-linux-gnu/7 -L/usr/lib/gcc/x86_64-linux-gnu/7/../../../i386-linux-gnu
-L/usr/lib/gcc/x86_64-linux-gnu/7/../../.. -L/lib/i386-linux-gnu -L/usr/lib/i386-linux-gnu hello.o -lgcc --push-state
--as-needed -lgcc_s --pop-state -lc -lgcc --push-state --as-needed -lgcc_s --pop-state
/usr/lib/gcc/x86_64-linux-gnu/7/32/crtend.o /usr/lib/gcc/x86_64-linux-gnu/7/../../../i386-linux-gnu/crtn.o
COLLECT_GCC_OPTIONS='-no-pie' '-m32' '-v' '-o' 'hello' '-mtune=generic' '-march=i686'
```
Utilitarul `collect2` este, de fapt, un wrapper peste utilitarul `ld`.
Rezultatul rulării comeznii este unul complex.
O invocare "manuală" a comenzii `ld` ar avea forma:
```
ld -dynamic-linker /lib/ld-linux.so.2 -m elf_i386 -o app /usr/lib32/crt1.o /usr/lib32/crti.o app.o helpers.o -lc /usr/lib32/crtn.o
```
Argumentele comenzii de mai sus au semnificația:
* `-dynamic-linker /lib/ld-linux.so.2`: precizează loaderul / linkerul dinamic folosit pentru încărcarea executabilului dinamic
* `-m elf_i386`: se linkează fișiere pentru arhitectura x86 (32 de biți, i386)
* `/usr/lib32/crt1.o`, `/usr/lib32/crti.o`, `/usr/lib32/crtn.o`: reprezintă biblioteca de runtime C (`crt` - *C runtime*) care oferă suportul necesar pentru a putea încărca executabilul
* `-lc`: se linkează biblioteca standard C (libc)

## Inspectarea fișierelor

Pentru a urmări procesul de linking, folosim utilitare de analiză statică precum `nm`, `objdump`, `readelf`.

Folosim utilitarul `nm` pentru a afișa simbolurile dintr-un fișier obiect sau un fișier executabil:
```
$ nm hello.o
00000000 T main
         U puts

$ nm hello
0804a01c B __bss_start
0804a01c b completed.7283
0804a014 D __data_start
0804a014 W data_start
08048370 t deregister_tm_clones
08048350 T _dl_relocate_static_pie
080483f0 t __do_global_dtors_aux
08049f10 t __do_global_dtors_aux_fini_array_entry
0804a018 D __dso_handle
08049f14 d _DYNAMIC
0804a01c D _edata
0804a020 B _end
080484c4 T _fini
080484d8 R _fp_hw
08048420 t frame_dummy
08049f0c t __frame_dummy_init_array_entry
0804861c r __FRAME_END__
0804a000 d _GLOBAL_OFFSET_TABLE_
         w __gmon_start__
080484f0 r __GNU_EH_FRAME_HDR
080482a8 T _init
08049f10 t __init_array_end
08049f0c t __init_array_start
080484dc R _IO_stdin_used
080484c0 T __libc_csu_fini
08048460 T __libc_csu_init
         U __libc_start_main@@GLIBC_2.0
08048426 T main
         U puts@@GLIBC_2.0
080483b0 t register_tm_clones
08048310 T _start
0804a01c D __TMC_END__
08048360 T __x86.get_pc_thunk.bx
```

Comanda `nm` afișează trei coloane:
* adresa simbolului
* secțiunea și tipul unde se găsește simbolul
* numele simbolului

Un simbol este numele unei variabile globale sau a unei funcții.
Este folosit de linker pentru a face conexiunile între diferite module obiect.
Simbolurile nu sunt necesare pentru executabile, de aceea executabilele pot fi stripped.

Adresa simbolului este, de fapt, offsetul în cadrul unei secțiuni pentru fișierele obiect.
Și este adresa efectivă pentru executabile.

A doua coloana precizează secțiunea și tipul simbolului.
Dacă este vorba de majusculă, atunci simbolul este exportat, este un simbol ce poate fi folosit de un alt modul.
Dacă este vorba de literă mică, atunci simbolul nu este exportat, este propriu modulului obiect, nefolosibil în alte module.
Astfel:
* `d`: simbolul este în zona de date inițializate (`.data`), neexportat
* `D`: simbolul este în zona de date inițializate (`.data`), exportat
* `t`: simbolul este în zona de cod (`.text`), neexportat
* `T`: simbolul este în zona de cod (`.text`), exportat
* `r`: simbolul este în zona de date read-only (`.rodata`), neexportat
* `R`: simbolul este în zona de date read-only (`.rodata`), exportat
* `b`: simbolul este în zona de date neinițializate (`.bss`), neexportat
* `B`: simbolul este în zona de date neinițializate (`.bss`), exportat
* `U`: simbolul este nedefinit (este folosit în modulul curent, dar este definit în alt modul)

Alte informații se găsesc în pagina de manual a utilitarul `nm`.

Cu ajutorul comenzii `objdump` dezasamblăm codul fișierelor obiect și a fișierelor executabile.
Putem vedea, astfel, codul în limbaj de asamblare și funcționarea modulelor.

Comanda `readelf` este folosită pentru inspectarea fișierelor obiect sau executabile.
Cu ajutorul comenzii `readelf` putem să vedem headerul fișierelor.
O informație importantă în headerul fișierelor executabile o reprezintă entry pointul, adresa primei instrucțiuni executate:
```
$ readelf -h hello
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
  Entry point address:               0x8048310
  Start of program headers:          52 (bytes into file)
  Start of section headers:          8076 (bytes into file)
  Flags:                             0x0
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         9
  Size of section headers:           40 (bytes)
  Number of section headers:         35
  Section header string table index: 34
```

Cu ajutorul comenzii `readelf` putem vedea secțiunile unui executabil / fișier obiect:
```
$ readelf -S hello
There are 35 section headers, starting at offset 0x1f8c:
Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .interp           PROGBITS        08048154 000154 000013 00   A  0   0  1
  [ 2] .note.ABI-tag     NOTE            08048168 000168 000020 00   A  0   0  4
  [ 3] .note.gnu.build-i NOTE            08048188 000188 000024 00   A  0   0  4
[...]
```

Tot cu ajutorul comenzii `readelf` putem lista (*dump*) conținutul unei anumite secțiuni:
```
$ readelf -x .rodata hello

Hex dump of section '.rodata':
  0x080484d8 03000000 01000200 48656c6c 6f2c2057 ........Hello, W
  0x080484e8 6f726c64 2100                       orld!.
```

## Feedback

Pentru a îmbunătăți cursul de IOCLA, componentele sale și modul de desfășurare, ne sunt foarte utile opiniile voastre.
Pentru aceasta, vă rugăm să accesați și completați formularul de feedback de pe site-ul [curs.upb.ro](https://curs.upb.ro/).
Trebuie să fiți autentificați și înrolați în cadrul cursului.

Formularul este anonim și este activ în perioada 18 ianuarie 2021 - 29 ianuarie 2021.
Rezultatele vor fi vizibile în cadrul echipei cursului doar după încheierea sesiunii.
Puteți accesa formularul de feedback începând cu 18 ianuarie 2021.
Este accesibil la link-ul "Formular feedback" a paginii principale a cursului de IOCLA al seriei voastre.
Nu este în meta-cursul disponibil tuturor seriilor.

Vă invităm să evaluați activitatea echipei de IOCLA și să precizați punctele tari și punctele slabe și sugestiile voastre de îmbunătățire a disciplinei.
Feedbackul vostru ne ajută să creștem calitatea materiei în anii următori și să îmbunătățim disciplinele pe care le veți face în continuare.

Vom publica la începutul semestrului viitor analiza feedbackului vostru.

Ne interesează în special:
1. Ce nu v-a plăcut și ce credeți că nu a mers bine?
1. De ce nu v-a plăcut și de ce credeți că nu a mers bine?
1. Ce ar trebui să facem ca lucrurile să fie plăcute și să meargă bine?

## Exerciții

În cadrul laboratoarelor vom folosi repository-ul de Git de IOCLA: https://github.com/systems-cs-pub-ro/iocla.
Repository-ul este clonat pe desktopul mașinii virtuale.
Pentru a îl actualiza, folosiți comanda `git pull origin master` din interiorul directorului în care se află repository-ul (`~/Desktop/iocla`).
Recomandarea este să îl actualizați cât mai frecvent, înainte să începeți lucrul, pentru a vă asigura că aveți versiunea cea mai recentă.
Dacă doriți să descărcați repository-ul în alt loc (`{target}`), folosiți comanda
```
git clone https://github.com/systems-cs-pub-ro/iocla ${target}
```
Pentru mai multe informații despre folosirea utilitarului `git`, urmați ghidul de la [Git Immersion](https://gitimmersion.com/).

Cele mai multe dintre exerciții se desfășoară pe o arhitectură x86 (32 de biți, i386).
Pentru a putea compila / linka pe 32 de biți atunci când sistemul vostru este pe 64 de biți, aveți nevoie de pachete specifice.
Pe o distribuție Debian / Ubuntu, instalați pachetele folosind comanda:
```
sudo apt install gcc-multilib libc6-dev-i386
```

Pentru exersarea informațiilor legate de linking, parcurgem mai multe exerciții.
În cea mai mare parte, aceste exerciții sunt exerciții în care observăm ce se întâmplă în procesul de linking, cele marcate cu sufixul `-tut` sau `-obs`.
Unele exerciții necesită modificări pentru a repara probleme legate de linking, cele marcate cu sufixul `-fix`.
Alte exerciții sunt exersarea unor noțiuni (cele marcate cu sufixul `-diy`) sau dezvoltarea / completarea unor fișiere (cele marcate cu sufixul `-dev`).
Fiecare exercițiu se găsește într-un director indexat; cele mai multe fișiere cod sursă și fișiere `Makefile` sunt deja prezente.

### 00. Hey! Hey, listen!

Dacă ne oferiți feedback, ne ajutați să ~~îl facem pe Lunk mai puternic~~ îmbunătățim materia.
Mergeți la secțiunea [feedback](#feedback) pentru detalii.

### 01. Linkarea unui singur fișier

Accesăm directorul `01-one-tut/`.
Vrem să urmărim comenzile de linkare pentru un singur fișier cod sursă C.
Fișierul sursă este `hello.c`.

În cele trei subdirectoare, se găsesc fișierele de suport pentru următoarele scenarii:
* `a-dynamic/`: crearea unui fișier executabil dinamic
* `b-static/`: crearea unui fișier executabil static
* `c-standalone/`: creare unui fișier executabil standalone, fără biblioteca standard C

În fiecare subdirector folosim comanda `make` pentru a compila fișierul executabil `hello`.
Folosim comanda `file hello` pentru a urmări daca fișierul este compilat dinamic sau static.

În fișierele `Makefile`, comanda de linkare folosește `gcc`.
Este comentată o comandă echivalentă care folosește direct `ld`.
Pentru a urmări folosirea directă a `ld`, putem comenta comanda `gcc` și decomenta comanda `ld`.

În cazul `c-standalone/`, pentru că nu folosim biblioteca standard C sau bibliotecă runtime C, trebuie să înlocuim funcționalitățile acestora.
Funcționalitățile sunt înlocuite în fișierul `start.asm` și `puts.asm`.
Aceste fișiere implementează, respectiv, funcția / simbolul `_start` și funcția `puts`.
Funcția / simbolul `_start` este, în mod implicit, entry pointul unui program executabil.
Funcția `_start` este responsabilă pentru apelul funcției `main` și încheierea programului.
Pentru că nu există bibliotecă standard, aceste două fișiere sunt scrise în limbaj de asamblare și folosesc apeluri de sistem.

**Bonus**: Adăugați, în fișierul `Makefile` din directorul `c-standalone/`, o comandă care folosește explicit `ld` pentru linkare.

### 02. Linkarea unui singur fișier

Accesați directorul `02-one-diy/`.
Vrem să compilăm și linkăm fișierele cod sursă din fiecare subdirector, pe modelul exercițiului anterior.

Copiați fișierele `Makefile` și actualizați-le în fiecare subdirector pentru a obține fișierul executabil.

### 03. Linkarea mai multor fișiere

Accesăm directorul `03-multiple-tut/`.
Vrem să urmărim comenzile de linkare din fișiere multiple cod sursă C: `main.c`, `add.c`, `sub.c`.

La fel ca în exercițiile de mai sus, sunt trei subdirectoare pentru trei scenarii diferite:
* `a-no-header/`: declararea funcțiilor externe se face direct în fișierul sursă C (`main.c`)
* `b-header/`: declararea funcțiilor externe se face într-un fișier header separat (`ops.h`)
* `c-lib/`: declararea funcțiilor externe se face într-un fișier header separat, iar linkarea se face folosind o bibliotecă statică

În fiecare subdirector folosim comanda `make` pentru a compila fișierul executabil `main`.

### 04. Linkarea mai multor fișiere

Accesați directorul `04-multiple-diy/`.
Vrem să compilăm și linkăm fișierele cod sursă din fiecare subdirector, pe modelul exercițiului anterior.

Copiați fișierele `Makefile` și actualizați-le în fiecare subdirector pentru a obține fișierul executabil.

### 05. Folosirea variabilelor

Accesăm directorul `05-vars-obs/`.
Vrem să urmărim folosirea variabilelor globale, exportate și neexportate.

În fișierul `hidden.c` avem variabila statică (neexportată) `hidden_value`.
Variabila este modificată și citită cu ajutorul unor funcții neexportate: `init()`, `get()`, `set()`.

În fișierul `plain.c` avem variabila exportată `age`.
Aceasta poate fi modificată și citită direct.

Aceste variabile sunt folosite direct (`age`) sau indirect (`hidden_value`) în fișierul `main.c`.
Pentru folosirea lor, se declară funcțiile și variabilele în fișierul `ops.h`.
Declararea unei funcții se face prin precizarea antetului; declararea unei variabile se face prin prefixarea cu `extern`.

### 06. Repararea entry pointului

Accesați directorul `06-entry-fix/`.
Vrem să urmărim probleme de definire a funcției `main()`.

Accesați subdirectorul `a-c/`.
Rulați comanda `make`, interpretați eroarea întâlnită și rezolvați-o prin editarea fișierului `hello.c`.

Accesați subdirectorul `b-asm/`.
Rulați comanda `make`, interpretați eroarea întâlnită și rezolvați-o prin editarea fișierului `hello.asm`.

**Bonus**: În subdirectoarele `c-extra-nolibc/` și `d-extra-libc/` găsiți soluții care nu modifică codul sursă al `hello.c`.
Aceste soluții modifică, în schimb, sistemul de build pentru a folosi altă funcție, diferită de `main()`, ca prima funcție a programului.

### 07. Repararea entry pointului

Accesați directorul `07-entry-2-fix/`.
Rulați comanda `make`, interpretați eroarea întâlnită și rezolvați-o prin editarea fișierului `hello.c`.

### 08. Warning (nu eroare)

Accesați directorul `08-include-fix/`.
Rulați comanda `make`, apare un warning, dar este de la procesul de preprocesare / compilare.
Rezolvați acest warning prin editarea fișierului `hello.c`.

**Bonus**: Rezolvați warningul fără folosirea directivei `#include`.

### 09. Reparare probleme de export

Accesați directorul `09-export-fix/`.
Fiecare subdirector (`a-func/`, `b-var/`, `c-var-2/`) conține o problemă legată de exportarea unor simboluri (funcții sau variabile).
În fiecare subdirectorul, rulați comanda `make`, identificați problema și editați fișierele necesare pentru rezolvarea problemei.

### 10. Folosire simboluri (variabile și funcții)

Accesați directorul `10-var-func-fix/`.
Rulați comanda `make`, interpretați eroarea întâlnită și rezolvați-o prin editarea fișierelor sursă.

### 11. Reparare problemă cu bibliotecă

Accesați directorul `11-lib-fix/`.
Rulați comanda `make`, interpretați eroarea întâlnită și rezolvați-o prin editarea fișierului `Makefile`.
Urmăriți fișierul `Makefile` din directorul `03-multiple-tut/c-lib/`.

### 12. Linkare C și C++

Accesăm directorul `12-cpp-obs/`.
Vrem să urmărim cum se realizează linkarea din surse mixte: C și C++.

În subdirectorul `bad/` avem două directoare `c-calls-cpp/` și `cpp-calls-c/` în care se combinăm surse mixte C și C++.
În ambele cazuri, folosirea `make` afișează erori.
Acest lucru se întâmplă întrucât simbolurile C++ sunt *mangled*.
Dacă folosim comanda `nm` pe module obiect obținute din cod sursă C, obținem:
```
$ nm add.o
0000000000000000 T _Z3addii

$ nm sub.o
0000000000000000 T _Z3subii
```
Numele simbolurilor nu sunt `add`, respectiv `sub`, ci sunt `_Z3addii` și `_Z3subii`.
Numele simbolurilor C++ sunt *mangled* și definesc signatura funcției.
Acest lucru se întâmplă pentru a permite funcții cu același nume, dar cu signaturi diferite.
Detalii despre *name mangling* găsiți [aici](https://en.wikipedia.org/wiki/Name_mangling).

Pentru a rezolva acest lucru, trebuie ca simbolurile definite C și importate în C++, sau invers, să fie prefixate cu directiva `extern "C"`.
În felul acesta, compilatorul C++ va folosi numele simple pentru simbolurile importate / exportate, pentru a fi folosite împreună cu module C.
Acest lucru este realizat în subdirectorul `good/`.
Detalii despre directiva `extern "C"` găsiți [aici](https://stackoverflow.com/a/1041880/4804196).

### 13. Linkare fișier obiect (fără fișier cod sursă)

Accesați directorul `13-obj-link-dev/`.
Fișierul `shop.o` expune o interfață (funcții și variabile) care permite afișarea unor mesaje.
Editați fișierul `main.c` pentru a apela corespunzător interfața expusă și pentru a afișa mesajele:
```
price is 21
quantity is 42
```

Explorați interfața și conținutul funcțiilor din fisierul `shop.o` folosind `nm` și `objdump`.
