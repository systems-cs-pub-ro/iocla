# Task 2 - Points #
Prin intermediul acestui task se doreste aprofundarea lucrului cu structuri.

Se da structura unui punct in coordonate carteziene:
```
    struct point{
        short x;
        short y; 
    };
```

## Exercitiul 1 ##
Pentru aceasta parte a task-ului aveti de implementat functia *points_distance()*
din fisierul *points-distance.asm* care va calcula distanta dintre doua puncte aflate
pe o dreapta paralela cu axele.

Antetul functiei este:
```
int points_distance(struct point *p, int *rez);
```

Semnificatia argumentelor este:
- **p** adresa de inceput a vectorului de puncte
- **rez** distanta dintre cele doau puncte

## Exercitiul 2 ##
In continuarea exercitiului 1, acum trebuie sa implementati functia *road()* din
fisierul *road.asm* care va calcula distanta dintre punctele vecine dintr-un vector.

Astfel, pentru un vector de 4 puncte se vor calcula 3 distante: *(0,1)* , *(1,2)*,
*(2,3)*.

Antetul functiei este:
```
void road(struct point* points, int len, int* distances);
```

Semnificatia argumentelor este:
- **points** adresa de inceput a vectorului de puncte
- **len** numarul de puncte
- **distances** adresa de inceput a vectorului de distantele

**Observatie**
    
    Lungimea vectorului de distante este cu 1 mai mica decat lungimea vectoului
    de puncte.

## Exercitiul 3 ##

Ultima parte a task-ului presupune analizarea fiecarei distante calculate anterior
pentru a determina daca este patrat perfect. Trebuie sa implementati functia
*is_square()* din fisierul *is_square.asm*.

Antetul functiei este:
```
void is_square(int *dist, int n, int *rez);
```
Semnificatia argumentelor este:
- **dist** adresa de inceput a vectorului de distante aflate la exercitiul 2
- **n** lungimea vectorului
- **rez** adresa de inceput a vectorului rezultat in urma verificarilor

**Nota** Un patrat perfect va fi notat cu 1, iar restul numerelor cu 0.

**ATENTIE** 

    - Pentru obtinerea punctalului maxim pe acest task trebuie realizate toate exercitiile
    - Punctajul pentru ex 2 nu se acorda fara rezolvarea ex 1, iar pentru ex3 
    trebuie rezolvate si ex2 si ex1
