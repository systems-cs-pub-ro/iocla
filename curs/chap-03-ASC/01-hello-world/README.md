# chap-03-demo

## Prezentare generală

Acest director conține două programe assembly NASM care demonstrează
ABI-ul Linux x86-64 la niveluri diferite:

| Fișier | Punct de intrare | Linkeditat cu | Scop |
|--------|-----------------|---------------|------|
| `hello.asm` | `main` | libc (prin `gcc`) | Explică anatomia registrelor (`AX/AH/AL/EAX/RAX`) și flagurile; afișează "Hello, world!" printr-un `syscall` direct |
| `hello64.asm` | `_start` | nimic (doar `ld`) | Program pur pe 64-bit fără dependențe; demonstrează ABI-ul complet Linux syscall fără runtime C |

---

## 1. Compilare

```bash
make          # compilează ambele ținte: hello și hello64
make hello    # compilează doar hello
make hello64  # compilează doar hello64
make clean    # șterge toate fișierele .o și binarele generate
```

---

## 2. Ghid detaliat — `hello.asm`

### 2.1 Secțiunea de date

```nasm
section .data
    msg db 'Hello, world!', 0xa   ; șir de octeți + newline (ASCII 10)
    len dd $ - msg                ; DWORD pe 32-bit care reține numărul de octeți
                                  ; dd  = define doubleword (4 octeți)
                                  ; $   = poziția curentă → lungime = sfârșit − început
```

> **Notă:** `len` este stocat în memorie ca valoare pe 32-bit (`dd`). Când este
> citit la rulare cu `mov rdx, [len]`, cei 4 octeți din memorie sunt
> extinși cu zerouri în registrul pe 64-bit `RDX`.

### 2.2 Anatomia registrelor

Primul bloc de instrucțiuni din `main` este un tur practic al modului în care
registrele generale x86-64 se suprapun:

```
 63      32 31    16 15  8 7    0
 ┌─────────┬────────┬─────┬─────┐
 │         │  EAX   │ AH  │ AL  │
 │         │        └──AX─┘     │
 └─────────┴────────────────────┘
              RAX  (toți 64 de biți)
```

```nasm
mov ax,  0x102      ; AX  = 0x0102  (258 zecimal, 0000_0001_0000_0010 binar)
                    ; AH  = 0x01,  AL = 0x02

mov ah,  -1         ; AH  = 0xFF  (-1 ca octet cu semn, sau 255 fără semn)
                    ; AX  este acum 0xFF02

mov al,  1          ; AL  = 0x01
                    ; AX  este acum 0xFF01
```

### 2.3 Etichetă și aritmetică

```nasm
adunare:            ; etichetă – un nume simbolic pentru această adresă
    add al, ah      ; AL = AL + AH = 0x01 + 0xFF = 0x100
                    ; dar AL are doar 8 biți → AL = 0x00
                    ; CF (Carry Flag / Flagul de transport) este SETAT deoarece
                    ;   rezultatul a depășit 8 biți
                    ; ZF (Zero Flag / Flagul de zero) este SETAT deoarece AL = 0
```

După `add`, încercați valori diferite pentru a observa:

| Flag | Semnificație | Se setează când |
|------|-------------|-----------------|
| `ZF` | Zero | rezultat == 0 |
| `CF` | Carry (transport) | depășire fără semn |
| `OF` | Overflow (depășire) | depășire cu semn |
| `PF` | Parity (paritate) | octetul inferior are număr par de biți de 1 |

### 2.4 Scriere în registru pe 32-bit

```nasm
mov eax, 0x1234ABCD ; scrierea în EAX *zerorizează automat biții superiori 32* din RAX
                    ; RAX = 0x0000_0000_1234_ABCD
                    ; AX  = 0xABCD  (cei mai puțin semnificativi 16 biți)
```

### 2.5 Afișarea șirului (syscall direct)

```nasm
; jmp iesire        ; (comentat) sare peste afișare – decomentați pentru a testa
mov rdi, 0x1        ; arg 1: descriptor fișier = 1 (stdout)
mov rsi, msg        ; arg 2: pointer către șir
mov rdx, [len]      ; arg 3: numărul de octeți – citit din memorie (parantezele = dereferențiere)
mov rax, 0x1        ; numărul syscall 1 = sys_write
syscall             ; intrăm în kernel; kernel-ul scrie șirul; returnează octeții scriși în RAX
```

### 2.6 Calea de ieșire

```nasm
iesire:
    xor rax, rax    ; RAX = 0 — valoarea returnată de funcție (codul de ieșire 0)
    ret             ; revenim din main() la wrapper-ul libc __libc_start_main
                    ; libc apelează apoi exit(0) în locul nostru
```

---

## 3. Ghid detaliat — `hello64.asm`

Acest program face un singur lucru: afișează "Hello, World!" și se termină curat — fără nicio dependență față de biblioteca C. Totul trece direct prin interfața syscall a kernel-ului.

### 3.1 Secțiunea de date

```nasm
section .data
    msg db 'Hello, World!', 0xa   ; șir de octeți + newline
    len equ $ - msg               ; constantă calculată la asamblare (NU stocată în memorie)
                                  ; equ este ca #define în C — valoarea este
                                  ; substituită la asamblare, nu există nicio adresă
```

> **`dd` vs `equ`:** În `hello.asm`, `len` este un `dd` — o variabilă de 4 octeți
> în memorie, citită cu `[len]`. Aici, `len` este un `equ` — o constantă numerică
> pură, integrată direct în encodarea instrucțiunii `mov rdx, len`.
> Niciun acces la memorie la rulare.

### 3.2 Secțiunea text și punctul de intrare

```nasm
section .text
    global _start   ; linker-ul caută _start ca punct de intrare
                    ; (folosit la linkeditare fără libc — ld nu știe de main)
```

### 3.3 Syscall-ul sys_write

ABI-ul Linux pe 64-bit transmite argumentele syscall în registre în această ordine:

| Rol | Registru |
|-----|----------|
| Numărul syscall | `rax` |
| Argumentul 1 | `rdi` |
| Argumentul 2 | `rsi` |
| Argumentul 3 | `rdx` |
| Argumentul 4 | `r10` |
| Argumentul 5 | `r8` |
| Argumentul 6 | `r9` |

```nasm
mov rax, 1      ; syscall 1 = sys_write
mov rdi, 1      ; arg 1: fd = 1 (stdout)
mov rsi, msg    ; arg 2: adresa buffer-ului
mov rdx, len    ; arg 3: număr de octeți (constantă compile-time, fără [paranteze])
syscall         ; → kernel-ul scrie 14 octeți la stdout, returnează 14 în RAX
```

### 3.4 Syscall-ul sys_exit

```nasm
mov rax, 60     ; syscall 60 = sys_exit
xor rdi, rdi    ; arg 1: codul de ieșire = 0
                ; xor reg, reg  ≡  mov reg, 0  dar:
                ;   • se encodează pe 3 octeți în loc de 7
                ;   • rupe lanțul de dependențe față de valoarea veche a lui rdi
                ;   • este recunoscut de CPU ca idiom de zerorizare (execuție mai rapidă)
syscall         ; → kernel-ul termină procesul; nu mai revine niciodată
```

> **De ce nu există `ret`?** Nu există un wrapper din runtime-ul C. Dacă execuția
> ar ajunge la sfârșitul lui `_start` fără a apela `sys_exit`, CPU-ul ar rula
> orice octeți se găsesc în memorie după — cel mai probabil un crash. Întotdeauna
> terminați programele cu `_start` direct prin syscall-ul de ieșire.

---

## 4. Demo GDB — `hello`

```bash
gdb hello
```

```gdb
b main            # punct de oprire la main
r                 # rulează programul
si                # avansează o instrucțiune mașină
info reg          # afișează toate registrele
p/x $eax          # afișează EAX în hexazecimal
p/t $eflags       # afișează EFLAGS în binar (t = binar)
set $eax = 0xffffffff   # suprascrie manual valoarea unui registru
set $eip = main         # repornește execuția de la main
```

Secvență de observare sugerată:

1. Oprire la `mov ax, 0x102` → verificați `$ax`, `$ah`, `$al`
2. După `mov ah, -1` → observați `$ah == 0xff`, `$ax == 0xff02`
3. După `add al, ah` → urmăriți cum se schimbă `CF` și `ZF` în `$eflags`
4. După `mov eax, 0x1234ABCD` → confirmați că biții superiori 32 ai `$rax` sunt zerorizați
5. După `syscall` → apare "Hello, world!"; `$rax` conține octeții scriși (14)

---

## 5. Demo GDB — `hello64`

```bash
gdb hello64
```

```gdb
b _start          # punct de intrare (fără libc, fără main)
r
si                # avansează instrucțiune cu instrucțiune
info reg rax rdi rsi rdx   # urmăriți cele patru registre pentru syscall
x/s $rsi          # examinați memoria la adresa din rsi ca șir de caractere
```

Secvență de observare sugerată:

1. Înainte de primul `syscall` → confirmați `rax=1`, `rdi=1`, `rsi=<adresa msg>`, `rdx=14`
2. După primul `syscall` → `rax` conține acum valoarea returnată (14 = octeți scriși)
3. Înainte de al doilea `syscall` → confirmați `rax=60`, `rdi=0`
4. Intrați în `syscall` → procesul se termină; gdb raportează "exited normally"

---

## 6. Inspectați `~/.gdbinit`

```bash
less ~/.gdbinit
```

Configurări recomandate:

```
set disassembly-flavor intel
set history save on
```

---

## 7. Diferențe principale, comparație directă

| | `hello.asm` | `hello64.asm` |
|-|-------------|--------------|
| Punct de intrare | `main` | `_start` |
| Linkeditor | `gcc` (include libc) | `ld` (fără biblioteci) |
| Mecanism de ieșire | `ret` din `main` → libc apelează `exit()` | `syscall` 60 direct |
| Stocare `len` | `dd` în `.data` (citire din memorie la rulare) | constantă `equ` (fără memorie) |
| Instrucțiunea syscall | `syscall` | `syscall` |
| Număr syscall — scriere | 1 | 1 |
| Număr syscall — ieșire | N/A (libc se ocupă) | 60 |
| Focus pe registre | Anatomia `AL/AH/AX/EAX/RAX` + FLAGS | Transmiterea argumentelor în ABI 64-bit |
