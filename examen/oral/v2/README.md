# Examen oral IOCLA

Examenul oral de IOCLA constă din furnizarea unei arhive cu fișiere sursă C și limbaj de asamblare.
Studenții vor primi această arhivă și o vor folosi pe parcursul examenului pentru a răspunde la întrebări și pentru a rezolva sarcini indicate de evaluatori.

## Întrebări

Întrebările de mai jos sunt orientative, structurate pe categorii.
Nu sunt singurele întrebări care vor fi prezente în discuție.
De la aceste întrebări discuția va atinge și alte noțiuni prezentate la cursul de IOCLA.

### Declaratii variabile si Memorie
1. Ce octeti ocupa `fmt_decimal` in urma in instructiunii `fmt_decimal: db "%d", 0xd, 0xa, 0`?

2. Ce efect are instructiunea `arr resd 1`?

3. Care este efectul instructiunii `enter 32, 0`?

4. Cum apar in memorie octetii numarului `0xdeadbeef` in urma instructiunii `mov dword[ebp-0x8], 0xdeadbeef`?

### Sintaxa ASM

1. Ce efect are instructiunea `mov byte[len], al`?

2. Ce rol are directiva `extern` in urmatoarea secventa?
`
extern fgets
extern printf
extern stdin
extern strlen
extern malloc
extern strncpy
`

3. Cum arata continutul registrului `eax` dupa executia urmatoarei secvente?
`
xor eax, eax
mov al, byte[len]
`



### Adresare
1. Ce efect are instructiunea `mov al, byte[len]`?

2. Ce se aduna la registrul `al` in baza instructiunii `add al, byte [ebx + ecx - 1]`?

3. Ce efect are instructiunea `mov ecx, [ebp+12]`?


### Stiva si Functii:
1. Ce efect are urmatoarea secventa de cod?
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
2. Cati parametrii sunt transmisi functiei `do_something` in urma secventei de cod?
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

3. Cati parametrii are functia `do_something` din program.asm?
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

4. Ce calucleaza functia `do_something` din program.asm?
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

5. Ce lungime are bufferul local functiei `main` din `program.asm` considerand urmatoarea secventa de cod?
`
enter 32, 0
mov dword[ebp-0x8], 0xdeadbeef
`

### Buffers Overflows

1. La ce offset se afla adresa de retur a functiei `main` fata de inceput bufferului local?

2. Este corecta urmatoarea secventa de cod din functia `main` sigura din punct de vedere al securitatii? De ce?
`
push dword [stdin]
push 128
lea eax, [ebp - 32]
push eax
call fgets
add esp, 0xc
`
3. Prezinta functia `do_something` din `program.asm` vulnerabilitati de tipul buffer overflow? De ce?

4. Cum putem afla care este adresa functiei `invisible_func` avand doar executabilul `program`?

5. Ce forma ar trebui sa aibe payload-ul pentru suprascrie adresa de retur a functiei `main`?

### Altele

1. Cum putem optimiza functia `do_something` din punct de vedere al timpului de executie?

2. Ce ii putem face binar-ului `program` pentru a scapa de sibolurile de relocare?

3. Cum am putea modifica flag-urile de compilare astfel incat vulnerabilitatile din executabilul `program` sa fie mai greu de exploatat?
