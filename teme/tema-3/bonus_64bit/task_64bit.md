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

Antetul functiei este `void intertwine(int *v1, int n1, int *v2, int n2, int *v);`

Semnificatia parametrilor:
  v1 -> adresa primului vector
  n1 -> lungimea primului vector
  v2 -> adresa celui de-al doilea vector
  n2 -> lungimea celui de-al doilea vector
  v -> adresa vectorului rezultat.
  
Atentie, functia nu returneaza nimic, rezultatul intercalarii se va salva in vectorul v, transims ca parametru.

## Punctare

Acest task valoreaza 10 puncte, dintre care un punct e pentru descrierea implementarii si coding style.
