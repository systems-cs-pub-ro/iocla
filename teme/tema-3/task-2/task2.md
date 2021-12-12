## Task 2 - Cosmarul lui Turing

Dupa a 2-a usa, Biju este intampinat de Alan Turing. Acestaa ii pune in fata o [Masina cu stiva](https://en.wikipedia.org/wiki/Stack_machine), adica o masina care stie sa foloseasca doar stiva, prin instructiuni de tip push si pop, pentru a lucra cu memoria. Provocarea lui biju este sa implementeze 2 functii pe aceasta masina:

### CMMMC

Prima functie este `int cmmmc(int a, int b)`, care calculeaza cel mai mic multiplu comun a 2 numere, date ca parametru. Se garanteaza ca rezultatul inmultirii lui a si b incape pe 4 bytes.

### Paranteze

A doua functie este `int par(int str_length, char *str)`, care verifica daca o secventa de paranteze este corecta. Aceasta primeste un sir catre contine doar paranteze rotunde si lungimea sirului, si intoarce 1, daca secventa e corecta, sau 0, daca secventa e gresita.

#### Exemplu

Pentru secventa `((()())(()))`, rezultatul va fi 1
Pentru secventa `(())((`, rezultatul va fi 0

## Punctare
- Task-ul are 25 de puncte, dintre care 2 puncte pentru coding-style si detalierea implementarii.
