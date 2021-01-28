## Exemple Intrebari - Nu sunt exhaustive, doar orientative structurate pe categorii.

### Declaratii variabile si Memorie

1. Ce valori se gasesc initial in memorie incepand de la adresa arr in baza instructiunii urmatoare?
 ```arr resd 1```

2. Ce efect are instructiunea  ```len dd 128```?

3. Rezervarea unei zone de memorie locale se realizeaza prin?

4. Ce efect are instructiunea ```sub esp, 28``` din functia main in fisierul program.asm?

5. Cum apar in memorie octetii numarului ```0x1234abcd``` in urma executiei instructiunii ```mov dword[ebp-0x4], 0x1234abcd``` ?

6. Care este efectul urmatorului snipet de cod?
```
    push len
    call malloc
    add esp, 4
    mov dword[arr], eax 
```

### Sintaxa ASM
1. Ce rol au declaratiile cu ```extern``` de la inceptul programului?

2. Ce se specifica prin directiva ```global```?

3. Ce efect are instructiunea ```add esp, 4```?

4. Ce efect are inststructiunea ```xor edx, edx```?

5. Ce efect are ```jnz repeat```?

### Adresare

1. Ce se citeste in registrul ecx din functia do_something prin instructiunea 
```mov ecx, dword [ebp + 16]```?

2. Ce efect are instructiunea ```mov byte [ebp + 1*eax - 0x28], 0``` din cadrul umatorului snipet de cod?
```
	lea eax, [ebp - 28]
	push eax
	call strlen
	add esp, 4
    dec eax
	mov byte [ebp + 1*eax - 28], 0
```

3. Ce se citeste in registrul dl prin instructiunea  ```mov dl, byte [ebx + ecx - 1]```?

4. Ce efect are instructiunea ```mov dword[arr], eax``` din cadrul umatorului snipet de cod?
```
    push len
    call malloc
    add esp, 4
    mov dword[arr], eax 
```

### Stiva si Functii:

1. Ce rol are instructiunea leave din functia ```do_something``` in fisierul program.asm?

2. Cati parametrii are functia ```do_something``` si ce face?

3. Functia din ```function.c``` se poate apela in ```program.asm``` fara a schimba codul? 

4. Ce rol are instructiunea ```enter 28, 0``` din functia main in fisierul program.asm?

5. Ce se va afla in zona de memorie indicata de arr dupa executia secventei?
```
    push len
    call malloc
    add esp, 4
    mov dword[arr], eax 
```
### Buffers Overflows

1. Ce adrese de memorie au functiile ```invisible_func()``` din fisierul functions.c?

2. Ce lungime are bufferul local utilizat in functia ```main```?

3. Ce vulnerabilitate prezinta programul?

4. La ce offset se afla adresa de retur a functie ```main``` fata de inceputul bufferului? 

5. Ce payload trebuie sa construim pentru a apela functia ```invisible_func()```?

### Altele

1. Ce efect are flag-ul de compilare ```-static``` din Makefile?

2. Ce trebuie facut pentru a apela functia ```invisible_func()``` din ```functions.c``` in programul principal din ```program.asm```?

3. Cum puteti restructura ciclu din functia ```do_something``` pentru a facilita o executie mai rapida?
