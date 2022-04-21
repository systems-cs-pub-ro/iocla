# Task 1 - simple cipher #
Acest algoritm de criptare presupune shiftarea la dreapta in cadrul alfabetului a 
fiecarui caracter de un anumit numar de ori. 

De exemplu, textul "ANABANANA" se transforma in "BOBCBOBOB" cand pasul este 1.

Astfel, o criptare cu pas 26 nu modifica litera intrucat alfabetul englez are 26 de caractere.

Pentru acest task, va trebui să implementați în fișierul `simple.asm` funcția `simple()`
care criptează un string în clar folosind metoda descrisă mai sus. 

Antetul funcției este:

```
void simple(int n, char* plain, char* enc_string, int step);
```

Semnificatia argumentelor este:
- **n** dimensiunea textului
- **plain** string-ul care trebuie criptat
- **enc_string** adresa la care se va scrie textul criptat
- **step** cu cat se shifteaza fiecare caracter

Restrictii:
- se vor folosi toate **majusculele** alfabetului englez
- shiftarea se realizeaza **strict** in cadrul alfabetului