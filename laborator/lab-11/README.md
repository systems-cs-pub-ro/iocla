# Laborator 11: Optimizări

Asa cum vi s-a spus la începutul semestrului, programarea assembly se practică din ce în ce mai rar. Compilatoarele au avansat suficient pentru a face o treabă mai bună ca oamenii atunci când vine vorba de generarea și optimizarea codului. Cu toate acestea, există situații în care compilatorul are nevoie de ajutor pentru a ajunge la o formă optimă. În asemenea cazuri, cunoștințele de assembly se dovedesc esențiale pentru optimizarea programului.

## Introducere

Optimizarea este procedeul prin care un sistem este modificat astfel încât consumul acestuia să scadă în planul uneia sau a mai multor resurse. În cazul programelor software, criteriile de optimizare cel mai des întalnite sunt:

1. **Timpul**. Această metrică este reprezentată de timpul efectiv de rulare al programului pe un sistem de calcul și este influențată de numărul de instrucțiuni executate și de timpul de execuție al instrucțiunilor folosite (afirmația este valabilă pentru programe secvențiale; în cazul programelor paralelizate intervin factori precum gradul de paralelizare și numarul de procesoare utilizate).
1. **Spațiul**. Această metrică poate fi privită din două puncte de vedere: cea a dimensiunii programului și cea a dimensiunii memoriei pentru date. În prima situație, factorii fundamentali de influență sunt numărul de instrucțiuni utilizate și dimensiunea instrucțiunilor; în cea din urmă situație, factorul determinant este reprezentat de cantitatea de memorie pe care o folosește un program.
1. **Energia**. Acestă metrică este deosebit de importantă atât pentru sistemele portabile (telefon mobil, laptop, tabletă etc.) întrucât determină durata de viață a bateriei, cât și pentru companiile care furnizează servicii software la scară largă deoarece electricitatea reprezintă o parte considerabilă din costuri. Deși eficientizarea consumului de energie se face adesea la nivel hardware, optimizând programele pe axa timpului și a spațiului va duce în mod implicit și la un consum de energie mai scăzut.

Pentru a optimiza un program pe axa uneia dintre metricile prezentate mai sus este important să înțelegem care sunt factorii care determină comportamentul actual și să identificăm modalități de ameliorare.

## Principiile optimizării

Prin însăși vocația lui, orice inginer tinde către o folosire cât mai eficientă a resurselor disponibile unui sistem, astfel încât se poate spune că optimizarea este sarcina naturală a acestuia. Cu toate acestea, experiența a dovedit că cea mai importantă parte a optimizării este aceea de a ști când să nu o faci. Deși poate părea contradictoriu, în realitate se întamplă foarte des ca programatorii să cadă inconștient în capcana seducătoare a optimizării în situații precum: codul nu este suficient de frecvent utilizat sau codul reprezintă un procent insignifiant din timpul total de rulare. Cu alte cuvinte, codul trebuie optimizat doar dacă modificările vor avea un impact semnificativ asupra metricilor urmărite sau dacă acesta este utilizat suficient de des pentru a justifica timpul petrecut pentru optimizare și sansa de a introduce schimbări cu potențial destructiv. Pentru a evita astfel de situații, este bine să urmăriți acest set de princpii:

1. **Codul trebuie să meargă corect înainte de a fi făcut să meargă rapid** sau cu alte cuvinte: "Premature optimization is the root of all evil" (Donald Knuth).
1. **Profilarea exhaustivă este arma principală a celui care optimizează**. În tentativa de a face programele mai eficiente este foarte important să găsim "bottleneck"-ul din programul nostru; aceasta se poate realiza doar printr-o profilare foarte granulară.
1. **Programele complexe au șanse mai mari să fie greșite**. O optimizare foarte greu de înțeles trebuie să aducă o creștere foarte semnificativă de performanță pentru a balansa potențialul de risc pe care îl introduce.

## Strategia de optimizare

În majoritatea covârșitoare a situațiilor când va trebui să optimizați un program, acesta nu va fi scris în limbaj de asamblare, ci într-unul de nivel înalt. În asemenea situații se recomandă urmatoarea abordare top-down:

1. **Optimizare la nivel de algoritm**. Primul lucru pe care trebuie să îl facem este să ne asigurăm că am aplicat algoritmul optim pentru problema pe care o rezolvăm. Acest pas este independent de limbajul de programare pe care îl folosim sau platforma pe care rulăm algoritmul.
1. **Optimizare la nivel de implementare**. Daca în urma pasului 1 codul tot nu respectă criteriile de performanță, ne punem problema optimizării la nivel de implementare. Concret, urmărim cum putem să modificam codul astfel încât să ajutăm compilatorul să genereze cod mai eficient, spre exemplu: folosirea shift-ărilor în locul înmulțirii/împărțirii cu 2, transmiterea parametrilor prin referință în loc de valoare, loop unrolling, mutarea codului invariant în afara buclelor, folosirea de funcții inline, evitarea apelurilor de funcții atunci când parametrii sunt identici de la un apel la altul, oferirea indiciilor de optimizare compilatorului, folosirea "flag"-urilor de optimizare din compilator etc. Acest pas este influențat de limbajul de programare folosit întrucât codul generat depinde de modul în care compilatorul translatează instrucțiunile din programul nostru.
1. **Optimizare la nivel de assembly**. În majoritatea cazurilor, dacă optimizările operate în pasul 2 sunt exhaustive, programul ar trebui să ajungă în forma sa optimă. Cu toate acestea, există situații în care, în ciuda ajutorului nostru, compilatorul nu poate genera codul cel mai eficient.

![https://impossiblehq.com/wp-content/uploads/2013/04/Final-Form.jpg](https://impossiblehq.com/wp-content/uploads/2013/04/Final-Form.jpg)


> **NOTE:** Abia în această etapă ne punem problema să implementăm în asamblare porțiuni din programul nostru. În astfel de situații extreme trebuie analizat codul generat de compilator și identificate bucățile în care acesta eșuează în a aplica diferite optimizări cum ar fi:
>    * există instrucțiuni precum [popcnt](https://www.felixcloutier.com/x86/POPCNT.html) sau [bsf](https://www.felixcloutier.com/x86/BSF.html) a căror exprimare în limbajele de nivel înalt este mult mai ineficientă (O(1) vs O(nbytes)), iar majoritatea compilatoarelor nu au capacitatea de a identifica aceste cazuri.
>    * în funcție de tipul de procesor, fiecare instrucțiune are un anumit timp de execuție; este posibil ca, în anumite cazuri, compilatorul să nu folosească instrucțiunea cea mai eficientă.
>    * sunt situații în care codul generat de compilator nu optimizează la maxim evitarea ["stall"-urilor de pipeline](https://en.wikipedia.org/wiki/Pipeline_stall). Mai multe despre asta la CN2.

## Concluzii

In optimizarea programelor, înțelegerea aprofundată a noțiunilor de asamblare este esențială atât pentru a înțelege cum poate fi îmbunătățit un cod cât și pentru a interpreta rezultatele eficientizării acestuia. Deși, cel mai probabil, nu va fi nevoie să scrieți cod assembly, înțelegerea acestuia vă va facilita o înțelegere superioară a modului de funcționare a programului și vă va îmbunătăți șansele de a găsi implementarea optimă a acestuia.


## Exercitii
> **NOTE:** În cadrul laboratoarelor vom folosi repository-ul de git al materiei IOCLA - https://github.com/systems-cs-pub-ro/iocla. Repository-ul este clonat pe desktop-ul mașinii virtuale. Pentru a îl actualiza, folosiți comanda `git pull origin master` din interiorul directorului în care se află repository-ul (`~/Desktop/iocla`). Recomandarea este să îl actualizați cât mai frecvent, înainte să începeți lucrul, pentru a vă asigura că aveți versiunea cea mai recentă. Dacă doriți să descărcați repository-ul în altă locație, folosiți comanda `git clone https://github.com/systems-cs-pub-ro/iocla ${target}`.Pentru mai multe informații despre folosirea utilitarului `git`, urmați ghidul de la [Git Immersion](https://gitimmersion.com/).

### 1. Loop unrolling

Intrați în directorul `1-2-loop-unrolling`. Inspectați codul din fișierele `normal_loop.c` și `unrolled_loop.c`. Compilați cele 2 surse și rulați-le:

```bash
make run
```

**1.** Cum explicați diferența de timp de rulare dintre cele două implementări?

> **TIP:** Urmăriți codul generat pentru cele 2 binare folosind **objdump**

**2.** Rulați de mai multe ori cele 2 binare. Timpurile de execuție variază. De ce?

Pentru mai multe informații despre **loop unrolling**, accesati acest [link](https://en.wikipedia.org/wiki/Loop_unrolling).

### 2. "Flag"-uri de optimizare

Tot în directorul `1-2-loop-unrolling` inspectați fișierul `Makefile`. Observați că pe langă target-urile prin care am obținut binarele de la punctul 1, mai există două cu extensia `_op`. Acestea folosesc flag-ul de optimizare definit de variabila `OPTFLAGS`. În acest caz, este folosit nivelul cel mai agresiv de optimizare `-O3`.

**1.** Compilați binarul optimizat pentru fișierul `normal_loop.c` și rulați-l. Ce observați? Cum explicați comportamentul?

Pentru compilare și rulare, executați comenzile:
```bash
make normal_loop_op
./normal_loop_op
```

> **TIP:** Urmăriți cu **objdump** codul generat pentru binarul `normal_loop_op`. Identificați zona în care se face suma elementelor vectorului.

**2.** În fișierul `normal_loop.c` decomentați linia în care se face un `printf`. Ce observați? Cum explicați?

**3.** Analizați binarul obținut la punctul 1 pentru `normal_loop` cu binarul obtinut la punctul anterior. Care sunt diferențele? Care sunt motivele pentru care binarul optimizat este mai rapid?

**4.** In `normal_loop.c` comentați prima linie `define N` și decomentați a doua definiție. Compilați cu optimizări și analizați codul generat. Ce s-a intamplat?

> **TIP:** Consultați linkul [acesta](https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html) și în manualul gcc căutați după `fpeel-loops`.

**5.** Compilați cu optimizări fișierul `unrolled-loop.c`. Rulați-l. Există vreo diferență sesizabilă de performanță între varianta de la de punctul 1 și aceasta? Cum se explică?

### 3. Optimizare cod C

Intrați în directorul `3-optimize`. Inspectați sursa `optimize.c`. Acest program poate fi îmbunătățit din punct de vedere al timpului de rulare. Ce optimizări se pot aplica codului? Implementați varianta optimizată și rulați apoi pentru a vedea diferența de performanță. Completați câmpul marcat cu `TODO`.

### 4. Numărarea biților setați

Uneori este nevoie să ținem evidența prezenței sau absenței unor resurse (ex. nuclee de procesor active). Deoarece această caracteristică poate fi reprezentată în mod optim folosind un singur bit (valoare `1` pentru prezență și `0` pentru absență), codificarea unui set se face folosind [vectori de biți](https://en.wikipedia.org/wiki/Bit_array). Deoarece acest tip de reprezentare a datelor este util în multe situații, procesoarele oferă suport hardware pentru execuția unor operații comune. Dintre acestea amintim numărarea de biți setați (cantitatea de resurse disponibile), care se realizează folosind instrucțiunea [popcnt](https://www.felixcloutier.com/x86/popcnt) și descoperirea primului bit setat (descoperirea primului element disponibil), care se realizează folosind instrucțiunea [bsf](https://www.felixcloutier.com/x86/bsf).

Intrați în directorul `4-bitops` și inspectați fișierul `binops.c`. Implementați funcția `count_bits_op` astfel încât să fie o variantă eficientă din punctul de vedere al timpului de execuție a funcției `count_bits` folosind suportul hardware oferit de procesor.

### 5. Loop vs. Jump

Intrați în directorul `5-profile`. Pornind de la fișierul `profile.asm` ne dorim să măsurăm diferența dintre folosirea instrucțiunii `loop` și instrucțiunile din clasa jump  (`j*`). Pentru aceasta va trebui să folosiți instrucțiunea [rdtscp](https://www.felixcloutier.com/x86/rdtscp). Urmăriți comentariile marcate cu `TODO`.

> **TIP:** O explicație referitoare la de ce rezultatele rulării celor 2 variante ar putea părea neintuitive găsiți [aici](https://stackoverflow.com/a/21565600).

### 6. Optimizare cod  assembly

Intrați în directorul `6-optimize-assembly`. Citiți sursele prezente în acest director.

  * Ce face codul scris în assembly?
  * Îmbunătățiți performanța codului scris în assembly. În cazul în care varianta este optimă din puncte de vedere temporal cât și spațial, veți primi 2 puncte bonus, însă va trebui să demonstrați optimalitatea.

> **TIP:** Când dorim să aflăm timpul de execuție al unei bucăți de cod nu există minim accidental, ci doar maxim accidental.
> Asta se datorează faptului că nu avem control asupra modului în care sistemul de operare planifică accesul procesului nostru la resurse, așa că pot interveni diferite întârzieri (de aici apariția maximului accidental); pe de altă parte minimul reprezintă valoarea cea mai apropiată de realitate.

> **TIP:** Pentru bonus puteți să consultați acest [link](https://www.agner.org/optimize/instruction_tables.pdf). Extrageți din fișierul PDF cât durează fiecare operație și încercați să reduceți timpul cât mai mult posibil folosind această informație.
> Folosiți comanda
> ```bash
> cat /proc/cpuinfo | grep "model name" | head -1
> ```
> în terminal pentru a vedea tipul procesorul și căutați apoi în PDF instrucțiunile pentru acesta pentru a vedea cât durează fiecare. Coloana care ne interesează este cea de `latency`.
> 

## Bibliografie
  * [Agner Fog optimization manuals](https://www.agner.org/optimize/#manuals), mai bune decât manualele Intel.  
  * [Optimization tips](http://mark.masmcode.com/)

## Soluții
Soluțiile pentru exerciții sunt disponibile [aici](https://elf.cs.pub.ro/asm/res/laboratoare/lab-11-sol.zip).
