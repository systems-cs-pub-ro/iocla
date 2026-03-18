; hello64.asm - "Hello, World!" în assembly NASM x86-64 (Linux, 64-bit)
;
; Compilare și rulare:
;   nasm -f elf64 -g -F dwarf hello64.asm -o hello64.o
;   ld -z noexecstack -o hello64 hello64.o
;   ./hello64

; ---------------------------------------------------------------------------
; Secțiunea .data – conține date inițializate (citire/scriere) care există
; în imaginea procesului din momentul în care programul pornește.
; ---------------------------------------------------------------------------
section .data

    msg db 'Hello, World!', 0xa   ; definim un șir de octeți
                                  ;   db  = "define byte" (definește octet/octeți)
                                  ;   0xa = caracterul newline (ASCII 10)
    len equ $ - msg               ; calculăm lungimea în octeți a șirului
                                  ; la momentul asamblării (compile-time)
                                  ;   $   = contorul poziției curente
                                  ;   equ = constantă la asamblare (nu se alocă
                                  ;         memorie, spre deosebire de dd/dw/db)

; ---------------------------------------------------------------------------
; Secțiunea .text – conține codul executabil.
; Este marcată read-only de către încărcătorul sistemului de operare.
; ---------------------------------------------------------------------------
section .text

    global _start   ; exportăm simbolul "_start" pentru ca linker-ul să găsească
                    ; punctul de intrare în program (fără libc → _start, nu main)

; ---------------------------------------------------------------------------
; _start – punctul de intrare în program
; ---------------------------------------------------------------------------
_start:

    ; -----------------------------------------------------------------------
    ; syscall write(fd, buf, count)  — scriere la consolă
    ;   Numărul syscall Linux : 1   (sys_write)
    ;   rdi = descriptor fișier  : 1   (stdout)
    ;   rsi = pointer la buffer  : msg
    ;   rdx = număr de octeți    : len
    ;   Valoare returnată (rax)  : numărul de octeți scrisi efectiv
    ;
    ; ABI-ul Linux pe 64-bit transmite argumentele syscall în registrele:
    ;   rax (numărul syscall), rdi, rsi, rdx, r10, r8, r9
    ; și folosește instrucțiunea "syscall" (nu "int 0x80" ca pe 32-bit).
    ; -----------------------------------------------------------------------

    mov rax, 1          ; numărul syscall 1 = sys_write
                        ; rax trebuie să conțină numărul syscall înainte de "syscall"

    mov rdi, 1          ; primul argument: descriptor fișier = 1 (stdout)
                        ; rdi este registrul pentru primul argument în ABI-ul
                        ; System V AMD64 (folosit atât la syscall-uri cât și la funcții C)

    mov rsi, msg        ; al doilea argument: adresa buffer-ului (șirului de caractere)
                        ; rsi este registrul pentru al doilea argument

    mov rdx, len        ; al treilea argument: numărul de octeți de scris
                        ; rdx este registrul pentru al treilea argument

    syscall             ; transferăm controlul către kernel
                        ; CPU salvează rip, trece în modul kernel, execută
                        ; serviciul cerut, apoi revine aici

    ; -----------------------------------------------------------------------
    ; syscall exit(status)  — terminarea procesului
    ;   Numărul syscall Linux : 60  (sys_exit)
    ;   rdi = codul de ieșire : 0   (succes)
    ;
    ; Trebuie să apelăm exit explicit – spre deosebire de programele C,
    ; nu există un wrapper libc care să facă asta când _start se termină.
    ; -----------------------------------------------------------------------

    mov rax, 60         ; numărul syscall 60 = sys_exit

    xor rdi, rdi        ; codul de ieșire = 0 (succes)
                        ; xor reg, reg este idiomul standard pentru a pune zero
                        ; într-un registru: se encodează pe 3 octeți în loc de 7
                        ; (față de "mov rdi, 0") și este mai rapid deoarece
                        ; rupe lanțul de dependențe față de valoarea veche a lui rdi

    syscall             ; apelăm kernel-ul – această instrucțiune nu mai revine niciodată
