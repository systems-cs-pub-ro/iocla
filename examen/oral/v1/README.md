# Examen oral IOCLA

Examenul oral de IOCLA constă din furnizarea unei arhive cu fișiere sursă C și limbaj de asamblare.
Studenții vor primi această arhivă și o vor folosi pe parcursul examenului pentru a răspunde la întrebări și pentru a rezolva sarcini indicate de evaluatori.

## Întrebări

Întrebările de mai jos sunt orientative, structurate pe categorii.
Nu sunt singurele întrebări care vor fi prezente în discuție.
De la aceste întrebări discuția va atinge și alte noțiuni prezentate la cursul de IOCLA.

### Declarații de variabile și memorie

1. Ce valori se găsesc inițial în memorie începând de la adresa `arr` în baza instrucțiunii următoare?
 `arr resd 1`

2. Ce efect are instrucțiunea  `len dd 128`?

3. Rezervarea unei zone de memorie locale se realizează prin?

4. Ce efect are instrucțiunea `sub esp, 28` din funcția `main` în fișierul program.asm?

5. Cum apar in memorie octeții numărului `0x1234abcd` în urma execuției instrucțiunii `mov dword[ebp-0x4], 0x1234abcd` ?

6. Care este efectul următoarei secvente de cod?
`
    push len
    call malloc
    add esp, 4
    mov dword[arr], eax
`

### Sintaxa ASM
1. Ce rol au declarațiile cu `extern` de la începutul programului?

2. Ce se specifica prin directiva `global`?

3. Ce efect are instrucțiunea `add esp, 4`?

4. Ce efect are instrucțiunea `xor edx, edx`?

5. Ce efect are `jnz repeat`?

### Adresare

1. Ce se citește în registrul `ecx` din funcția `do_something` prin instrucțiunea
`mov ecx, dword [ebp + 16]`?

2. Ce efect are instrucțiunea `mov byte [ebp + 1*eax - 0x28], 0` din cadrul următoarei secvente de cod?
`
	lea eax, [ebp - 28]
	push eax
	call strlen
	add esp, 4
    dec eax
	mov byte [ebp + 1*eax - 28], 0
`

3. Ce se citește în registrul dl prin instrucțiunea  `mov dl, byte [ebx + ecx - 1]`?

4. Ce efect are instrucțiunea `mov dword[arr], eax` din cadrul următoarei secvente de cod?
`
    push len
    call malloc
    add esp, 4
    mov dword[arr], eax
`

### Stiva și Funcții:

1. Ce rol are instrucțiunea `leave` din funcția `do_something` în fișierul `program.asm`?

2. Câți parametrii are funcția `do_something` și ce face?

3. Funcția din `function.c` se poate apela in `program.asm` fără a schimba codul?

4. Ce rol are instrucțiunea `enter 28, 0` din funcția `main` în fișierul `program.asm`?

5. Ce se va afla în zona de memorie indicata de `arr` dupa execuția secventei?
`
    push len
    call malloc
    add esp, 4
    mov dword[arr], eax
`
### Buffers Overflows

1. Ce adrese de memorie au funcțiile `invisible_func()` din fișierul `functions.c`?

2. Ce lungime are buffer-ul local utilizat în funcția `main`?

3. Ce vulnerabilitate prezintă programul?

4. La ce offset se afla adresa de retur a funcție `main` fata de începutul buffer-ului?

5. Ce payload trebuie sa construim pentru a apela funcția `invisible_func()`?

### Altele

1. Ce efect are flag-ul de compilare `-static` din Makefile?

2. Ce trebuie făcut pentru a apela funcția `invisible_func()` din `functions.c` în programul principal din `program.asm`?

3. Cum puteți restructura ciclu din funcția `do_something` pentru a facilita o execuție mai rapida?
