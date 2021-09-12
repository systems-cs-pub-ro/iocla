# Laborator 12: CTF

În acest laborator veți interacționa cu majoritatea noțiunilor prezentate pe parcursul semestrului prin intermediul unor taskuri de tip `Capture-The-Flag`. Acestea vor testa înțelegerea și stăpânirea metodelor și toolurilor specifice de analiză statică și dinamică, înțelegerea procesului de compilare, a limbajului de asamblare - sintaxă, regiștri, lucru cu memoria, funcții - dar și capacitatea de identificare și exploatare a unor vulnerabilități simple de tip buffer overflow.

## Exerciții

> **NOTE:** Fiecare dintre exerciții ascunde un flag cu formatul `iocla_{<string>}`

> **TIP:** În general, flagul va fi returnat ca și string de o funcție specială, al cărei conținut nu ajută în rezolvarea taskurilor. Se recomandă tratarea acestei funcții ca și Black Box.

### 1.1. Hidden in plain sight
Binarul `1-1-hidden-in-plain-sight/link` expune tot ce aveți nevoie. Găsiți un mod de a-l folosi.

### 1.2. Hidden in plain sight ++
Investigați binarul `1-2-hidden-in-plain-sight/link2`. Modul în care poate fi executat nu mai este un mister, dar va fi puțin mai dificil să ajungeți la flag.

### 2. Look at him go
Binarul `2-look-at-him-go/dynamic` este de data aceasta executabil și are ca unic scop obținerea flagului și plasarea lui undeva in memorie. No tricks here.
> **TIP:** GDB is your friend

### 3.1 Playing God
Binarul `3-1-playing-god/dynamic2` vă cere să ghiciți un număr între 1 și 100000. Găsiți o cale mai bună de a-l afla.

### 3.2 Playing God ++
Binarul `3-2-playing-god/buff-ovf` este vulnerabil. De data aceasta, găsirea numărului nu va fi de ajuns, dar este posibil să nici nu fie nevoie.
> **TIP:** Vulnerabilitatea vă oferă posibilitatea de a modifica date. Există mai mult de o cale prin care puteți îndeplini condiția pentru obținerea flagului.

### 4. Indirect business
Binarul `4-indirect-business/buff-ovf2` expune aceeași vulnerabilitate cu un extra step.

### 5. RIP my buffers off
Binarul `5-rip-my-buffers-off/buff-ovf3` nu folosește funcția get\_flag(), dar oferă o oportunitate de a o apela.
> **TIP:** Unde se poate suprascrie o adresă de funcție?

### 6. Feeling chained
Urmăriți șirul de operații din funcțiile binarului `6-feeling-chained/buff-ovf4`. Identificați-le pe cele necesare și... deja știți cum se apelează.
