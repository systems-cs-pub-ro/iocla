# Optimizari

## Introducere

Optimizarea reprezinta procesul prin care randamentul unei aplicatii
(sau a unui sistem) este maximizat in functie de un anumit criteriu.
Acest criteriu poate fi timpul, spatiul sau energia consumata.

Avand in vedere complexitatea sistemelor din ziua de azi - o aplicatie
nu ruleaza niciodata in vid, ci poate rula direct deasupra unui sistem
fizic (baremetal), ori deasupra unui sistem de operare care la randul
sau poate rula in cadrul unei masini virtuale sau direct deasupra unui
sistem fizic etc. -, procesul de optimizare este unul complicat, multinivel
pentru care nu exista o cale batatorita ce poate fi urmata. In aceste
conditii, optimizarea unui program necesita profilarea extensiva a acestuia
pentru a se descoperi nivelurile unde au loc pierderi de performanta si
cauzele acestora. In mod uzual, spunem ca acea portiune de cod
cauzeaza un "bottleneck".

Din punctul de vedere al modului in care programatorul poate actiona
pentru optimizari, diferentiem 3 niveluri:

1. Optimizari la nivel de algoritm. Acest pas presupune identificarea
algoritmului optim pentru problema de fata si este independent de
ecosistemul in care ruleaza aplicatia (ceea ce am invatat la "Analiza
Algoritmilor").

2. Optimizari la nivel de implementare. In acest punct este necesar ca
programatorul sa cunoasca detalii despre arhitectura sistemului pe care
ruleaza si prin indicii sau rescrieri de cod sa ajute compilatorul sa
genereze un cod mai eficient.

3. Optimizari la nivel de arhitectura de procesor. Acest pas presupune
intelegerea codului assembly rezultat si identificarea situatiilor in
care compilatorul nu a generat codul optim. In acest caz, programatorul
va trebui sa substituie sau sa adauge cod (inline) assembly in codul
sursa de nivel inalt.

In cadrul acestui curs ne vom axa pe optimizarile de timp la nivel de
asamblare, pentru a vedea cum cunoasterea arhitecturii sistemului de
calcul si a limbajului de asamblare ne poate ajuta sa optimizam
programele. Astfel, cursul va aborda urmatoarele subiecte:
 - vom enumera care sunt metodele de masurare/profilare disponibile
 - vom analiza o serie de optimizari pe care le are la dispozitie compilatorul
 - vom studia o serie de instructiuni speciale ale procesorului pe care
   compilatorul nu le foloseste prea des, dar care au potential mare de a
   creste performanta

## Profilare

Programele din ziua de azi sunt din ce in ce mai mari (de ordinul zecilor
de mii de linii cod, uneori chiar milioanelor). In acest context este
important sa avem o metoda usoara de a identifica care sunt portiunile
din program care sunt executate cel mai des ("hot paths"). Odata identificate
aceste portiuni, este necesar sa intelegem anatomia acestora pentru a putea
gasi metode de optimizare. Profilarea unei aplicatii reprezinta procesul
prin care putem realiza acest lucru.

Astfel, in procesul de profilare vom utiliza una sau mai multe unelte,
in functie de scop.

### perf

`perf` este un utilitar de monitorizare a performantei pentru Linux. Acesta
are access la unitatea de monitorizare a performantei din procesor asa ca
poate oferi atat informatii privitoare la evenimente software (numarul de
schimbari de context, numarul de fault-uri, etc.) cat si informatii despre
evenimentele hardware (numarul de cicli , branch miss-uri, numarul de
instructiuni executate etc.).

Demo:

Pentru a colecta informatii despre evenimentele implicite ce au loc la rularea
unui executabil putem sa rulam comanda `perf stat`:

$ perf stat ls

Observam faptul ca a fost executata comanda `ls` si au fost colectate anumite
informatii cum ar fi numarul de cicli necesari pentru rulare.

Pentru a putea vedea evenimentele disponibile rulam comanda:

$ perf list

Observam lista de evenimente disponibile pentru `perf`. Pentru a selecta
evenimentele care ne intereseaza, putem sa folosim optiunea `-e`:

$ perf stat -e cycles ls

`perf` este o unealta ce ne ofera informatii despre o aplicatie la nivel
macro. Nu ne ofera oportunitatea sa analizam aplicatia la nivel mai granular.
Astfel, perf poate fi folosit cu orice binar, nu conteaza cum a fost compilat
acesta.
In general, `perf` este folosit la nivel de sistem de operare pentru a
identifica aplicatiile care au potentialul de a utiliza in exces resursele
sistemului de operare.

### gprof

In cazul in care avem nevoie sa identificam care sunt portiunile critice
ale unui program scris in C, putem sa folosim utilitarul `gprof`. Acesta
beneficiaza de suport in compilator pentru colectarea de informatii
referitoare la timpii de executie ai functiilor. Pentru a putea profila
un program cu utilitarul `gprof` este necesar sa folosim optiunea "-pg".

Vom utiliza un program aleator de aproximativ 500 de linii de cod caruia
vom incerca sa ii descoperim portiunile critice. Acest program face parte
dintr-o suita de teste oficiale (NAS Parallel Benchmark Suite) care este
folosita de cercetatorii in domeniul programelor paralele.

Prima oara vom utiliza `perf` pentru a incerca sa colectam niste date:

$ cd gprof_demo
$ make gprof_demo
$ perf stat ./gprof_demo

Dupa cum se poate observa, `perf` ne ofera date asupra rularii intregului
program, insa nu ne ajuta sa identificam care sunt portiunile critice.
Pentru o analiza mai amuntita, vom utiliza utilitarul `gprof`:

$ make profile
$ cat profile_data.txt

Dupa cum putem observa, `gprof` ne ofera o statistica in legatura cu timpul
petrecut in executarea fiecarei functii si de cate ori a fost apelata aceasta.
Mai mult, in perspectiva detaliata, prezinta si care este graful de apeluri
pentru fiecare dintre functiile profilate. Analizand fisierul `profile_data`,
remarcam faptul ca functia in care se petrece cel mai mult timp este functia
`rank`, urmata de functia `randlc`. In cazul in care intr-o functie se petrece
un timp nerelevant in economia totala a programului, aceasta nu va fi afisata.

Analizand codul sursa ar programului (`gprof_demo.c`), observam faptul ca functia
`randlc` este utilizata in procesul de initializare al programului. In general,
initializarea este un proces ce nu este relevant pentru optimizare, intrucat se
face o singura data, de aceea in cazul de fata, comentariile din cod ne sugereaza
sa nu luam in calcul decat timpul de executie al functiei `rank`.

### Masurare granulara a timpului

Am reusit sa identificam faptul ca functia `rank` reprezinta portiunea critica
din programul nostru. Cu toate acestea functia `rank` la randul ei este destul
de extinsa. Pentru a identifica care portiune este responsabila de majoritatea
timpului este necesar sa facem masuratori la o granularitate mult mai mica.

Pentru aceasta avem mai multe posibilitati, in C:

1. Functii de nivel inalt (clock, gettimeofday etc.)

In exemplul de fata vom folosi functia `clock`.
Cu ajutorul acestei functii se poate masura timpul pe care il ia pe procesor
o anumita bucata de cod. Rezultatul functiei este de tip `clock_t`. Pentru a
obtine un timp masurabil in secunde, impartim rezultatul la o valoare predeterminata,
`CLOCKS_PER_SEC`.

Demo:

$ cd ../time_demo
$ cat clk.c

In fisierul `clk.c` avem programul anterior, doar ca toate buclele au fost
gardate de apeluri catre `clock()`. Astfel, masuram timpul petrecut in
portiunea de cod incadrata.

$ make clk

Dupa cum se poate observa a 3-a bucla este cea responsabila de majoritatea
timpului petrecut pe procesor in functia `rank`.

2. rdtscp

`rdtscp` este o instructiune care are access direct la un registru special
care monitorieaza numarul de cicli de cand a fost pornit calculatorul. Astfel,
daca ne intereseaza o granularitate mai fina (cicli vs. microsecunde), `rdtscp`
reprezinta o alternativa pentru functiile de nivel mai inalt cum ar fi `clock`

In fisierul `time_demo/rdtscp.c` se afla o copie a fisierului `clk.c`. Pe langa
continutul original, se afla implementata functia `void rdtscp` care
este un "wrapper" pentru o inserare "inline assembly" a instructiunii `rdtscp`.
Apelurile functiei `clock` au fost inlocuite cu apeluri catre functia "wrapper"
`rdtscp`.

$ make rdtscp

Observati ca rezultatul este unul mult mai granular atunci cand vine vorba de
buclele 1 si 5 (in cazul `clock` raportul dintre cele 2 valori este ~1, in timp
ce in cazul `rdtscp`, raportul este ~5).

Din nou, observam ca in cadrul celei de-a 3-a bucle se consuma cel mai mult timp.

### Masurare granulara a altor metrici

Acum ca am identificat bucla problematica, ne dorim sa aflam mai multe despre
comportamentul acestui cod. Pentru aceasta putem sa folosim PAPI ("Performance
API") care ne permitem sa facem o profilare similara cu cea a utilitarului
`perf` insa la un nivel de granularitate mult mai mic.

PAPI ofera si un utilitar care ne spune ce evenimente sunt disponibile pe masina
noastra:

$ papi_avail

In functie de acestea, putem sa selectam evenimentele care sunt de interes.
(Aici fiecare titular poate sa incerce diferite combinatii, insa este important
sa se vada ca va fi un numar mare de L1 cache misses)

$ make papi

(Discutie in functie de rezultatulele obtinute)

## Optimizari

### Loop unrolling

Pentru a intelege aceasta optimizare ne vom uita pe un exemplu.

$ cd loop_unroll/

In acest director avem 2 surse. Algoritmic vorbind, cele 2 programe
sunt echivalente: calculeaza suma unui vector de intregi. Compilati
si rulati cele 2 exemple:

$ make

Observam ca in mod consistent a 2-a varianta este mai rapida decat
prima. De ce?


Motivul principal pentru care optimizarea de "loop unrolling"
produce benficii este aceea ca se imputineaza numarul de
instructiuni de control ale buclei. Desi numarul adunarilor
din calculul sumei ramane constant, numarul de comparari
("i < N") si numarul de salt-uri ("jmp") se reduc.
Dezavantajul acestei tehnici este acela ca va creste dimensiunea
binarului. Pe langa aceasta, nu avem garantia ca orice
bucla va beneficia in urma acestei optimizari; in anumite
cazuri este posibil sa duca chiar la inrautatirea performantei.
De aceea, compilatoarele nu folosesc in mod implicit aceasta
optimizare nici macar atunci cand este folosita optiunea
de optimizare maximala.

### Functii inline

### Folosire instructiuni speciale
    - prefetch
    - popcnt
    - bsf
###AVX/SSE

### Optimizari de compilator

In marea majoritatea a cazurilor, optimizarile algoritmice sunt suficiente
pentru a obtine o performanta acceptabila. Restul optimizarilor sunt lasate
pe mana compilatorului, folosind una dintre optiunile de optimizare.

Astfel, compilatoarele ofera mai multe optiuni de optimizare. In cadrul acestui curs,
vom studia optiunile de optimizare ale compilatorului `GCC`.

`GCC` ofera 5 optiuni de optimizare:

1. -O0: nicio optimizare, optiunea implicita. Fiecare instructiune este translata
direct in corespondentul ei in assembly.
2. -O1: optimizari de baza. Binarul ar trebui sa aiba o dimensiune mai mica si sa fie
mai rapid decat binarul compilato cu -O0. Optimizarile mai avansate nu vor fi folosite
cu aceasta optiune.
3. -O2: optimizari de baza + optimizari avansate care nu necesita cresterea dimensiunii
binarului. Compilarea, de regula, va dura mai mult, insa binarul rezultat va fi mai
rapid decat compilarea cu -O1, cu dimensiunea lui cel mult egala.
4. -O3: optimizari de baza + optimizari avansate + optimizari care favorizeaza
rapiditatea rularii in detrimentul dimensiunii binarului. In unele situatii
nefavorabile, este posibil ca performanta binarului sa se inrautateasca.
5. -Os: optimizari de spatiu. Aceasta optiune va selecta optimizarile care
favorizeaza dimensiunea binarului in detrimentul vitezei; se va incerca
obtinerea unui binar cat mai mic cu putinta.

Intrebare: De ce este -O0 optiunea implicita?
Raspuns: In ciclul de productie un program va fi compilat de foarte
multe ori, iar -O0 este varianta cea mai rapida din punct de vedere
al timpului de compilare. In momentul in care programul este corect
si gata de livrare se poate utiliza -O2 sau -O3 pentru a obtine
performanta maxima.

Demo:

$ cd opt_demo
$ make

Aici avem un program simplu care realizeaza suma numerelor dintr-un
vector. Am compilat 4 variante ale programului. Ruland cele 4 variante
vom observa urmatoarea relatie intre timpii de rulare ai programului:

O0 > O1 > O2 = O3 (pe masina mea)

Intre O2 si O3 nu este mare diferenta in aceasta situatie.
Daca analizam dimensiunea binarelor, vom observa ca variantele
optimizate au aceeasi dimensiune, in timp ce varianta neoptimizata
are dimensiunea un pic mai mare (72 bytes pe masina mea). Daca ne
uitam cu `objdump` la codul assembly al binarului, vom remarca
o scadere de ~6% in codul generat cu optimizari.

In fisierul `test.c`, comentati linia care printeaza suma elementelor.
Recompilati toate variantele si rulati-le. Ce observam?
Pentru -O0 si -O1 nu exista nicio modificare a timpului de rulare,
inspre pentru variantele -O2 si -O3 timpul de rulare tinde la 0.
Asta se intampla pentru ca variabila `sum` nu mai este folosita
la nimic si atunci compilatorul decide ca orice operatie care
va salva un rezultat in ea este inutila, de unde si eliminarea
acestora (se poate observa si cu `objdump` faptul ca intre cele
2 apeluri ale functiei `clock` nu se mai afla nicio instructiune).
