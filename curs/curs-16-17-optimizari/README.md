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
cauzele acestora.

Din punct de vedere al programatorului optimizarea poate avea loc la 3
niveluri diferite:

1. Optimizari la nivel de algoritm. Acest pas presupune identificarea
algoritmului optim pentru problema de fata si este independent de
ecosistemul in care ruleaza aplicatia (ceea ce am invatat la "Analiza
Algoritmilor").

2. Optimizari la nivel de implementare. In acest punct este necesar ca
programatorul sa cunoasca detalii despre arhitectura sistemului pe care
ruleaza si prin indicii sau rescrieri de cod sa ajute compilatorul sa
genereze un cod mai eficient.

3. Optimizari la nivel de asamblare. Acest pas presupune intelegerea
codului assembly rezultat si identificarea situatiilor in care compilatorul
nu a generat codul optim. In acest caz, programatorul va trebui sa
substituie sau sa adauge cod (inline) assembly in codul sursa de nivel
inalt.

In cadrul acestui curs ne vom axa pe optimizarile de timp la nivel de
asamblare pentru a vedea cum cunoasterea arhitecturii sistemului de
calcul si a limbajului de asamblare ne poate ajuta sa optimizam
programele. Astfel, cursul va aborda urmatoarele subiecte:
 - vom enumera care sunt metodele de masurare/profilare disponibile
 - vom analiza o serie de optimizari pe care le are la dispozitie compilatorul
 - vom studia o serie de instructiuni speciale ale procesorului pe care
   compilatorul nu le foloseste prea des, dar care au potential mare de a
   creste performanta

## Profilare

Programele din ziua de azi sunt din ce in ce mai mari (de ordinul milioanelor
de linii de cod). In acest context este important sa avem o metoda usoara
de a identifica care sunt portiunile din program care sunt executate cel
mai des (hotpaths). Odata identificate aceste portiuni, este necesar
sa intelegem anatomia acestora pentru a putea gasi metode de optimizare.
Profilarea unei aplicatii reprezinta procesul prin care putem realiza
acest lucru.

Astfel, in procesul de profilare vom utiliza una sau mai multe unelte,
in functie de scop.

### perf

`perf` este un utilitar de monitorizare a performantei pentru Linux. Acesta
are access la unitatea de monitarizare a performantei din procesor asa ca
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


## Optimizari

### Optimizari de compilator (-O2 -O3)
### Loop unrolling
### Functii inline
### Folosire instructiuni speciale
    - prefetch
    - popcnt
    - bsf
###AVX/SSE
