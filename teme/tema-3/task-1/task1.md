# Task 1 - Sortarea albumelor

Intrand pe prima usa, Biju este intampinat de Allen Newell, unul din inventatorii listelor inlantuite. Acesta il provoaca pe Biju sa sorteze albumele unuia dintre rivalii lui, Bogdan de la Ploiesti. Albumele lui, fiind pretioase, sunt tinute in niste noduri ale unei liste simplu-inlantuite.

Biju trebuie să implementeze funcția cu semnătura `struct node* sort(int n, struct node* node);` din fișierul task1.asm, care “leagă” nodurile din listă în ordine crescătoare. Funcția primește numărul de noduri și adresa vectorului și întoarce adresa primului nod din lista rezultată.

Structura unui nod este:
```
struct node {
    int val;
    struct node* next;
};
```
și, inițial, câmpul `next` este setat la `NULL`.

## Precizări:
- n >= 1
- secvența conține numere consecutive distincte începand cu 1 (ex: 1 2 3 ...)
- structura vectorulului NU trebuie modificată (interschimbarea nodurilor este interzisă)
- sortarea trebuie facută in-place
- este permisă folosirea unor structuri auxiliare, atâta timp cât, nodurile listei rezultate sunt cele din vectorul inițial
- NU este permisă folosirea funcției `qsort` din libc

## Exemplu
```
Inițial:

| Adresă    | Valoare   | Next      |
| --------- | --------- | --------- |
| 0x32      | 2         | NULL      |
| 0x3A      | 1         | NULL      |
| 0x42      | 3         | NULL      |

Apelul funcției `sort` întoarce `0x3A` (adresa nodului cu valoarea 1) și vectorul va arăta astfel:

| Adresă    | Valoare   | Next      |
| --------- | --------- | --------- |
| 0x32      | 2         | 0x42      |
| 0x3A      | 1         | 0x32      |
| 0x42      | 3         | NULL      |
```

## Hint:
- pentru implementarea sortării vă puteți inspira din [Selection Sort](https://www.geeksforgeeks.org/selection-sort/)

## Punctare
- Task-ul are 25 de puncte, dintre care un punct pentru coding-style si detalierea implementarii.