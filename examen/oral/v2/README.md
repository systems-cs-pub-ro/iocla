# Examen oral IOCLA

Examenul oral de IOCLA constă din furnizarea unei arhive cu fișiere sursă C și limbaj de asamblare.
Studenții vor primi această arhivă și o vor folosi pe parcursul examenului pentru a răspunde la întrebări și pentru a rezolva sarcini indicate de evaluatori.

## Întrebări

Întrebările de mai jos sunt orientative, structurate pe categorii.
Nu sunt singurele întrebări care vor fi prezente în discuție.
De la aceste întrebări discuția va atinge și alte noțiuni prezentate la cursul de IOCLA.

### Declarații variabile si Memorie
1. Ce octeți ocupa `fmt_decimal` în urma în instrucțiunii `fmt_decimal: db "%d", 0xd, 0xa, 0`?

2. Ce efect are instrucțiunea `arr resd 1`?

3. Care este efectul instrucțiunii `enter 32, 0`?

4. Cum apar în memorie octeții numărului `0xdeadbeef` în urma instrucțiunii `mov dword[ebp-0x8], 0xdeadbeef`?

### Sintaxa ASM

1. Ce efect are instrucțiunea `mov byte[len], al`?

2. Ce rol are directiva `extern` în următoarea secventa?
`
extern fgets
extern printf
extern stdin
extern strlen
extern malloc
extern strncpy
`

3. Cum arata continutul registrului `eax` dupa execuția următoarei secvente?
`
xor eax, eax
mov al, byte[len]
`



### Adresare
1. Ce efect are instrucțiunea `mov al, byte[len]`?

2. Ce se aduna la registrul `al` in baza instrucțiunii `add al, byte [ebx + ecx - 1]`?

3. Ce efect are instrucțiunea `mov ecx, [ebp+12]`?


### Stiva și Funcții:
1. Ce efect are următoarea secventa de cod?
`
    xor eax, eax
    mov al, byte[len]
    push eax
    lea eax, [ebp - 32]
    push eax
    push dword[arr]
    call strncpy
    add esp, 8
`
2. Cați parametrii sunt transmiși funcției `do_something` în urma secventei de cod?
`
    xor eax, eax
    mov al, byte[len]
    push eax
    lea eax, [ebp - 32]
    push eax
    push dword[arr]
    call strncpy
    add esp, 8
    push dword[arr]
    call do_something
    add esp, 8
`

3. Câți parametrii are funcția `do_something` din `program.asm`?
`
do_something:
    push ebp
    mov ebp, esp
    xor eax, eax
    mov ebx, [ebp+8]
    mov ecx, [ebp+12]
looping:
    add al, byte [ebx + ecx - 1]
    dec ecx
    jnz looping
    leave
    ret
`

4. Ce calculează funcția `do_something` din `program.asm`?
`
do_something:
    push ebp
    mov ebp, esp
    xor eax, eax
    mov ebx, [ebp+8]
    mov ecx, [ebp+12]
looping:
    add al, byte [ebx + ecx - 1]
    dec ecx
    jnz looping
    leave
    ret
`

5. Ce lungime are buffer-ul local funcției `main` din `program.asm` considerând următoarea secventa de cod?
`
enter 32, 0
mov dword[ebp-0x8], 0xdeadbeef
`

### Buffers Overflows

1. La ce offset se afla adresa de retur a funcției `main` fata de început buffer-ului local?

2. Este corecta următoarea secventa de cod din funcția `main` sigura din punct de vedere al securității? De ce?
`
push dword [stdin]
push 128
lea eax, [ebp - 32]
push eax
call fgets
add esp, 0xc
`
3. Prezintă funcția `do_something` din `program.asm` vulnerabilități de tipul buffer overflow? De ce?

4. Cum putem afla care este adresa funcției `invisible_func` având doar executabilul `program`?

5. Ce forma are payload-ul pentru suprascrie adresa de retur a funcției `main`?

### Altele

1. Cum putem optimiza funcția `do_something` din punct de vedere al timpului de execuție?

2. Ce ii putem face binar-ului `program` pentru a scapă de simbolurile de relocare?

3. Cum am putea modifica flag-urile de compilare astfel încât vulnerabilitatea din executabilul `program` sa fie mai greu de exploatat?
