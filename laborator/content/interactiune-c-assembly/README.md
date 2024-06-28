# Laborator 10: Interactiunea C-assembly
Având în vedere că limbajul de asamblare prezintă dificultăți atât în citirea cât și în dezvoltarea codului, tendința generală este aceea de a se migra către limbaje de nivel înalt (care sunt mult mai ușor de citit și oferă un API mult mai ușor de utilizat). Cu toate acestea, tot există situații în care, din rațiuni de optimizare, se folosesc mici rutine assembly care sunt integrate în modulul limbajului de nivel inalt.

În acest laborator vom vedea cum se pot integra module de assembly în programe C și viceversa.

## Utilizarea procedurilor assembly în funcții C
Pentru ca un program C să ajungă să fie executat, este necesar ca acesta să fie tradus în codul mașina al procesorului; aceasta este sarcina unui compilator. Având în vedere că acest cod rezultat în urma compilării nu este întotdeauna optim, în anumite cazuri se preferă înlocuirea unor porțiuni de cod scris în C cu porțiuni de cod assembly care să facă același lucru, însă cu o performanță mai bună.

### Declararea procedurii
Pentru a ne asigura că procedura assembly și modulul C se vor combina cum trebuie și vor fi compatibile, următorii pași trebuie urmați:
- declararea labelului procedurii ca fiind global, folosing directiva GLOBAL. Pe lângă asta, orice date care vor fi folosite de către procedură trebuie declarate ca fiind globale.
- folosirea directivei EXTERN pentru a declara procedurile și datele globale ca fiind externe.

### Setarea stivei
Atunci când se intră intr-o procedură, este necesar să se seteze un stack frame către care să se trimită parametrii. Desigur, dacă procedura nu primește parametri, acest pas nu este necesar. Așadar, pentru a seta stiva, trebuie inclus următorul cod:
```Assembly
push ebp
mov ebp, esp
```
EBP-ul ne oferă posibilitatea să îl folosim ca un index în cadrul stivei și nu ar trebui alterat pe parcursul procedurii.
### Conservarea registrelor
Este necesar ca procedura să conserve valoarea registrelor ESI, EDI, EBP și a registrelor segment. În cazul în care aceste registre sunt corupte, este posibil ca programul să producă erori la întoarcerea din procedura assembly.
### Transmiterea parametrilor din C către procedura assembly
Programele C trimit parametrii către procedurile assembly folosind stiva. Să considerăm următoarea secvență de program C:
```C
extern int Sum();
   ...
int a1, a2, x;
   ...
x = Sum(a1, a2);
```
Când C-ul execută apelul către Sum, mai întâi face push la argumente pe stivă, în ordine inversă, apoi face efectiv call către procedură. Astfel, la intrarea în corpul procedurii, stiva va fi intactă.

Cum variabilele `a1` și `a2` sunt declarate ca fiind valori `int`, vor folosi fiecare câte un cuvânt pe stivă. Metoda aceasta de pasare a parametrilor se numește pasare prin valoare. Codul procedurii Sum ar putea arăta în felul următor:
```Assembly
Sum:
        push    ebp             ; creează stack frame pointer
        mov     ebp, esp
        mov     eax, [ebp+8]    ; ia primul argument
        mov     ecx, [ebp+12]   ; ia al doilea argument
        add     eax, ecx        ; suma celor 2
        pop     ebp             ; reface base pointerul
        ret
```
Este interesant de remarcat o serie de lucruri. În primul rând, codul assembly pune în mod implicit valoarea de retur a procedurii în registrul `eax`. În al doilea rând, comanda `ret` este suficientă pentru a ieși din procedură, datorită faptului că compilatorul de C se ocupă de restul lucrurilor, cum ar fi îndepărtarea parametrilor de pe stivă.
## Apelarea de funcții C din proceduri assembly
În majoritatea cazurilor, apelarea de rutine sau funcții din biblioteca standard C dintr-un program în limbaj de asamblare este o operație mult mai complexă decât viceversa. Să luăm exemplul apelării funcției `printf` dintr-un program în limbaj de asamblare:
```Assembly
global  main

extern  printf

section .data

text    db      "291 is the best!", 10, 0
strformat db    "%s", 0

section .code

main
        push    dword text
        push    dword strformat
        call    printf
        add     esp, 8
        ret
```
Remarcați faptul că procedura este declarată ca fiind globală și se numește `main` - punctul de pornire al oricărui program C. Din moment ce în C parametrii sunt puși pe stivă în ordine inversă, offsetul stringului este pus prima oară, urmat de offsetul șirului de formatare. Funcția C poate fi apelată după aceea, însa stiva trebuie restaurată la ieșirea din funcție.

Când se face linkarea codului assembly trebuie inclusă și biblioteca standard C (sau biblioteca care conține funcțiile pe care le folosiți).

## Inline assembly
În primul rând, ce este “inline”?

Termenul `inline` este un cuvânt cheie în limbajul C și este folosit în declararea funcțiilor. În momentul în care compilatorul găsește o funcție declarată ca fiind inline, acesta va înlocui toate apelurile către funcția respectivă cu corpul funcției. Avantajul principal al funcțiilor inline este acela că se pierde overheadul rezultat din apelul unei funcții. Pe de altă parte, dimensiunea binarului va fi mai mare.
> **NOTE:** Nu are sens să declarăm ca fiind inline funcțiile recursive. De ce?
Acum este ușor să ghicim la ce se referă expresia “inline assembly”: un set de instrucțiuni assembly scrise ca funcții inline. Inline assembly este folosit ca o metoda de optimizare și este foarte des întâlnit în system programming.

În programele C/C++ se pot insera instrucțiuni în limbaje de asamblare folosing cuvântul cheie “asm”.

Pentru mai multe detalii, consultați [linkul](https://www.codeproject.com/Articles/15971/Using-Inline-Assembly-in-C-C) pentru gcc sau [linkul](https://docs.microsoft.com/en-us/cpp/assembler/inline/inline-assembler?redirectedfrom=MSDN&view=msvc-160) pentru cl.

## Exerciții
> **IMPORTANT:** În cadrul laboratoarelor vom folosi repository-ul de git al materiei IOCLA - [https://github.com/systems-cs-pub-ro/iocla](https://github.com/systems-cs-pub-ro/iocla). Repository-ul este clonat pe desktop-ul mașinii virtuale. Pentru a îl actualiza, folosiți comanda `git pull origin master` din interiorul directorului în care se află repository-ul (`~/Desktop/iocla`). Recomandarea este să îl actualizați cât mai frecvent, înainte să începeți lucrul, pentru a vă asigura că aveți versiunea cea mai recentă. Dacă doriți să descărcați repository-ul în altă locație, folosiți comanda `git clone https://github.com/systems-cs-pub-ro/iocla ${target}`.Pentru mai multe informații despre folosirea utilitarului `git`, urmați ghidul de la [Git Immersion](https://gitimmersion.com/).

### 1. Tutorial: Buclă for în inline assembly
În subdirectorul `01-inline-for/` din arhiva de sarcini a laboratorului aveți o implementare a unei bucle for folosind inline assembly.

Urmăriți codul și compilați-l și rulați-l într-un terminal. Pentru a-l compila rulați comanda
```bash
make
```
În urma rulării comenzii rezultă executabilul `inline_for` pe care îl putem executa folosind comanda
```bash
./inline_for
```
Urmăriți în cod partea de inline assembly din blockul ce începe cu `asm`. Înțelegeți modul în care funcționează inline assembly înainte de a trece la exercițiul următor.
> **TIP:**
> Structura generală a unei directive de inline assembly este următoarea:
> ```C
> __asm__ ( AssemblerTemplate
>           : OutputOperands
>           [ : InputOperands
>           [ : Clobbers ]]
>         )
> ```
> `AssemblerTemplate` este un string care constituie instrucțiunile in limbaj de asamblare executate de programul vostru. `gcc` nu va ține cont de spațiile albe din acest string, din cauza aceasta trebuie sa marcați fiecare instrucțiune cu `\n` (opțional `\t` pentru indentare).
>
> `OutputOperands` și `InputOperands` reprezintă variabilele de ieșire, respectiv intrare ale rutinei voastre. Convențional, variabilele de ieșire sunt transferate prin referință, iar cele de intrare prin valoare. Pentru variabilele de ieșire, folosiți declarații de forma `"=r" (<variabila_din_codul_C>)`, iar pentru variabile de intrare, `"r" (<variabila_din_codul_C>)`.
>
> Prin `Clobbers` menționați registrele pe care îi folosiți în rutina voastră de asamblare, și în felul acesta instruiți compilatorul să nu se atingă de ei. Altfel, sunt șanse să îi folosească în alte scopuri.
>
> În instrucțiuni, trebuie să înlocuiți aparițiile variabilelor din program (e.g. `sum`), cu registrul aferent (e.g. `%0`). Registrele de tip general (`"r"`) sunt numerotați crescător începând cu 0, în ordinea declarațiilor. Există și posibilitatea de a mapa explicit o variabilă la un anumit registru (e.g. `"=a" (var)` va mapa variabila `var` la registrul `eax`), însă, pentru simplitate, în laborator folosim doar mapări la registrele generale.
>
> Pentru debugging, puteți inspecta fișierul de assembly generat de `gcc` - acesta se generază executând comanda:
> ```bash
> make asm
> ```

### 2. Rotație în inline assembly
În limbajul C avem suport pentru operații de shiftare pe biți dar nu avem suport pentru operații de rotație pe biți. Acest lucru în ciuda prezenței operațiilor de rotație pe biți la nivelul procesorului.
În subdirectorul `02-inline-rotate/` găsiți un schelet de cod pe care să îl folosiți pentru a implementa, folosind mnemonicile `rol` și respectiv `ror`, rotații pe biți. O descriere scurtă a acestor instrucțiuni găsiți [aici](https://en.wikibooks.org/wiki/X86_Assembly/Shift_and_Rotate#Rotate_Instructions).
Pentru compilare folosiți comanda `make`.
> **TIP:**
> La o implementare corectă a rotației cu 8 biți la stânga și dreapta, în urma rulării executabilului `./inline_rotate`, veți obține un rezultat de forma:
> ```bash
> ./inline_rotate
> init: 0x12345678, rot_left: 0x34567812, rot_right: 0x78123456
> ```

### 3. RTDSCP în inline assembly
La nivelul procesoarelor moderne există o instrucțiune simplă, accesibilă doar din limbaj de asamblare, care oferă informații despre registrul TSC (Time Stamp Counter) numită `rtdscp`.
În subdirectorul `03-inline-rtdscp/` găsiți un schelet de cod pe care să îl folosiți pentru obținerea valorii registrului TSC folosind instrucțiunea `rtdscp`. Completați scheletul și faceți programul să afișeze informațiile dorite.
Pentru compilare folosiți comanda `make`.
> **TIP:**
> Pentru informații despre instrucțiunea `rtdscp` consultați și aceste link-uri:
> - https://www.felixcloutier.com/x86/rdtscp
> - https://en.wikipedia.org/wiki/Time_Stamp_Counter

### 4. Tutorial: Calcul maxim în assembly cu apel din C
În subdirectorul `04-5-max-c-calls/` din arhiva de sarcini a laboratorului găsiți o implementare de calcul a maximului unui număr în care funcția `main()` este definită în C de unde se apelează funcția `get_max()` definită în limbaj de asamblare.

Urmăriți codul din cele două fișiere și modul în care se transmit argumentele funcției și valoarea de retur.

Compilați și rulați programul. Pentru a-l compila rulați comanda:
```bash
make
```
În urma rulării comenzii rezultă executabilul mainmax pe care îl putem executa folosind comanda:
```bash
./mainmax
```
> **IMPORTANT:**
> Acordați atenție înțelegerii codului înainte de a trece la exercițiul următor.

> **IMPORTANT:**
> Valoarea de retur a unei funcții este plasată în registrul `eax`.

### 5. Extindere calcul maxim în assembly cu apel din C
Extindeți programul de la exercițiul anterior (în limbaj de asamblare și C) astfel încât funcția `get_max()` să aibă acum semnătura `unsigned int get_max(unsigned int *arr, unsigned int len, unsigned int *pos)`. Al treilea argument al funcției este adresa în care se va reține poziția din vector pe care se găsește maximul.

La afișare se va afișa și poziția din vector pe care se găsește maximul.
> **TIP:**
> Pentru reținerea poziției, cel mai bine este definiți o variabilă locală `pos` în funcția `main` din fișierul C (`main.c`) în forma
> ```C
> unsigned int pos;
>  ```
>  iar apelul funcției `get_max` îl veți face în forma:
>  ```C
> max = get_max(arr, 10, &pos);
>  ```

### 6. Depanare stack frame corupt
În subdirectorul `06-stack-frame/` din arhiva de sarcini a laboratorului găsiți un program C care implementează afișarea stringului `Hello world!` printr-un apel al funcției `print_hello()` definită în assembly pentru prima parte a mesajului, urmat de două apeluri ale funcției `printf()` direct din codul C.

Compilați și rulați programul. Ce observați? Mesajul printat nu este cel așteptat deoarece din codul assembly lipsește o instrucțiune.

Folosiți GDB pentru a inspecta adresa din vârful stivei înainte de execuția instrucțiunii `ret` din funcția `print_hello()`. Către ce pointează? Urmăriți valorile registrelor EBP si ESP pe parcursul execuției acestei funcții. Ce ar trebui să se afle în vârful stivei după execuția instrucțiunii `leave`?

Găsiți instrucțiunea lipsă și rerulați executabilul.

> **TIP:**
> Pentru a putea restaura stiva la starea sa de la începutul funcției curente, instrucțiunea `leave` se bazează pe faptul că frame pointerul funcției a fost setat.

### 7. Tutorial: Calcul maxim în C cu apel din assembly
În subdirectorul `07-8-max-assembly-calls/` din arhiva de sarcini a laboratorului găsiți o implementare de calcul a maximului unui număr în care funcția `main()` este definită în limbaj de asamblare de unde se apelează funcția `get_max()` definită în C.

Urmăriți codul din cele două fișiere și modul în care se transmit argumentele funcției și valoarea de retur.

Compilați și rulați programul.
> **IMPORTANT:**
> Acordați atenție înțelegerii codului înainte de a trece la exercițiul următor.

### 8. Extindere calcul maxim în C cu apel din assembly
Extindeți programul de la exercițiul anterior (în limbaj de asamblare și C) astfel încât funcția `get_max()` să aibă acum semnătura `unsigned int get_max(unsigned int *arr, unsigned int len, unsigned int *pos)`. Al treilea argument al funcției este adresa în care se va reține poziția din vector pe care se găsește maximul.

La afișare se va afișa și poziția din vector pe care se găsește maximul.
> **TIP:**
> Pentru a reține poziția, cel mai bine este să definiți o variabilă globală în fișierul assembly (`main.asm`) în secțiunea `.data`, în forma
> ```Assembly
> pos: dd 0
> ```
>  Această variabilă o veți transmite (prin adresă) către apelul `get_max` și prin valoare pentru apelul `printf` pentru afișare.
>
>  Pentru afișare modificați șirul `print_format` și apelul `printf` în fișierul assembly (`main.asm`) ca să permită afișare a două valori: maximul și poziția.

### 9. Tutorial: Conservare registre
În subdirectorul `09-10-regs-preserve/` din arhiva de sarcini a laboratorului găsiți funcția `print_reverse_array()` implementată printr-un simplu loop ce face apeluri repetate ale funcției `printf()`.

Urmăriți codul din fișierul `main.asm`, compilați și rulați programul. Ce s-a întâmplat? Programul rulează la infinit. Acest lucru se întămplă deoarece funcția `printf()` nu conservă valoarea din registrul `ECX`, folosit aici ca și contor.

Decomentați liniile marcate cu `TODO1` și rerulați programul.

### 10. Depanare SEGFAULT
Decomentați liniile marcate cu `TODO2` în fișierul assembly de la exercițiul anterior. Secvența de cod realizează un apel al funcției `double_array()`, implementată în C, chiar înainte de afișarea vectorului folosind funcția văzută anterior.

Compilați și rulați programul. Pentru depanarea segfault-ului puteți folosi utilitarul `objdump` pentru a urmări codul în limbaj de asamblare corespunzător funcției `double_array()`. Observați care din registrele folosite înainte și după apel sunt modificate de această funcție.

Adăugați în fișierul assembly instrucțiunile pentru conservarea și restaurarea registrelor necesare.

### 11. Warning (nu eroare)

Accesați directorul `11-include-fix/`.
Rulați comanda `make`.
Veți primi un warning.
Este de la compilare sau de la linkare?
Rezolvați acest warning prin editarea fișierului `hello.c`.

Rezolvați warningul fără folosirea directivei `#include`.

### 12. Reparare probleme de export

Accesați directorul `12-export-fix/`.
Fiecare subdirector (`a-func/`, `b-var/`, `c-var-2/`) conține o problemă legată de exportarea unor simboluri (funcții sau variabile).
În fiecare subdirector, rulați comanda `make`, identificați problema și editați fișierele necesare pentru rezolvarea problemei.

### 13. Tutorial: Linkare C și C++

Accesăm directorul `13-cpp-obs/`.
Vrem să urmărim cum se realizează linkarea din surse mixte: C și C++.

În subdirectorul `errors/` avem două directoare `c-calls-cpp/` și `cpp-calls-c/` în care se combinăm surse mixte C și C++.
În ambele cazuri, folosirea `make` afișează erori.
Acest lucru se întâmplă întrucât simbolurile C++ sunt *mangled*, adică simbolurile lor au nume diferite din cauza claselor și a namespace-urilor prezente in C++.
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
Acest lucru este realizat în subdirectorul `correct/`. In acest subdirector sunt reparate erorile din subdirrectorul `errors/`. Comparati fisierele `ops.h` din ambele subdirectoare.
Detalii despre directiva `extern "C"` găsiți [aici](https://stackoverflow.com/a/1041880/4804196).

### 14. Bonus: Calcul maxim în assembly cu apel din C pe 64 de biți
Intrați în subdirectorul `14-max-c-calls-x64/` și faceți implementarea calculului maximului în limbaj de asamblare pe un sistem pe 64 de biți. Porniți de la programul de la exercițiile 4 și 5 în așa fel încât să îl rulați folosind un sistem pe 64 de biți.

> **TIP:**
> https://en.wikipedia.org/wiki/X86_calling_conventions.
>
> Primul lucru pe care trebuie să-l aveți în vedere este că pe arhitectura x64 registrele au o dimensiune de 8 octeți și au nume diferite decât cele pe 32 de biți (pe lângă extinderea celor tradiționale: `eax` devine `rax`, `ebx` devine `rbx`, etc., mai există altele noi: R10-R15: pentru mai multe informații vedeți [aici](https://stackoverflow.com/questions/20637569/assembly-registers-in-64-bit-architecture)).
>
>  De asemenea, pe arhitectura x64 parametrii nu se mai trimit pe stivă, ci se pun în registre. Primii 3 parametri se pun în: `RDI`, `RSI` și `RDX`. Aceasta nu este o convenţie adoptată uniform. Această convenţie este valabilă doar pe Linux, pe Windows având alte registre care sunt folosite pentru a transmite parametrii unei funcţii.
>
>  Convenția de apel necesită ca, pentru funcțiile cu număr variabil de argumente, `RAX` să fie setat la numărul de registre vector folosiți pentru a pasa argumentele. `printf` este o funcție cu număr variabil de argumente, și dacă nu folosiți alte registre decât cele menționate în paragraful anterior pentru trimiterea argumentelor, trebuie să setați `RAX = 0` înainte de apel. Citiți mai multe [aici](https://stackoverflow.com/questions/38335212/calling-printf-in-x86-64-using-gnu-assembler).

### 15. Bonus: Calcul maxim în C cu apel din assembly pe 64 de biți
Intrați în subdirectorul `15-max-assembly-calls` și faceți implementarea calculului maximului în C cu apel din limbaj de asamblare pe un sistem pe 64 de biți. Porniți de la programul de la exercițiile 6 și 7 în așa fel încât să îl rulați folosind un sistem pe 64 de biți. Urmați indicațiile de la exercițiul anterior și aveți grijă la ordinea parametrilor.

