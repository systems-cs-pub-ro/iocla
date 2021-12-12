# Task Bonus - Assembly 64bit

Biju intra intr-una din camerele din spatele lui Steve. Gaseste un plic pe care scrie "accepta prezentul".

Task-ul implementarea unei functii care face intercalarea a 2 vectori `void intertwine(int *v1, int n1, int *v2, int n2, int *v);`, in assembly pe 64 de biti.

Prin intercalare se intelege crearea unui nou vector, care contine, alternativ, elementele celor 2 vectori.

## Exemplu
- v1 = 1 1 1 1
- v2 = 2 2
- intercalare: 1 2 1 2 1 1

## Atentie

Daca un vector este mai lung decat celalalt, elementele lui vor fi puse la finalul vectorului rezultat.

## Punctare

Acest task valoreaza 10 puncte, dintre care un punct e pentru descrierea implementarii si coding style.