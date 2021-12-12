## Task 4 - Conturile lui Biju

Dupa a 4-a usa, Biju este intampinat de Thoralf Skolem, cel care a definit pentru prima data functiile recursive. Acesta ii da lui Biju contul bancar al lui Tzanca Uraganu, intr-o forma dubioasa, si-i cere sa scrie mai multe functii recursive, pentru a afla cati bani are Tzanca in cont.

### Cerinţă:

Va trebui să implementaţi 3 funcţii recursive (lui Biju îi place recursivitatea mutuală) care vor evalua o expresie primită ca parametru:

- `expression(char *p, int *i)`
    - evaluează expresii de tipul `term + term` sau `term - term`
- `term(char *p, int *i)`
    - evaluează expresii de tipul `factor * factor` sau `factor / factor`
- `factor(char *p, int *i)`
    - evaluează expresii de tipul `(expression)` sau `number`, unde număr este o secvenţă de cifre

### Precizări:
- `p` este şirul de caractere
- `i` este poziţia actuală în şirul de caratere (atenţie, acesta va trebui actualizat în funcţii)
- numerele vor fi întregi pozitive, însă în urma operaţiilor pot apărea numere negative
- împărţirile vor fi făcute pe numere întregi
- rezultatele se încadrează pe tipul `int`
- expresiile primite vor fi corecte
- pe scurt, recursivitatea mutuală presupune definirea a doua funcţii una în funcţie de cealaltă. Ilsutrativă în acest sens este următoarea secvenţă de cod:
```C
function1()
{    
    // do something 
    function2();
    // do something
}

function2()
{
    // do something 
    function1();
    // do something
}
```

- pentru mai multe detalii legate de recursivitatea mutuală consultaţi [acest link](https://en.wikipedia.org/wiki/Mutual_recursion).
- **orice rezolvare care nu foloseşte recursivitate mutuală nu va fi punctată**

### Exemplu de test:

| `test.in `     | `test.out` |
|----------------|------------|
|```15+8*2000``` | ```16015```|

### Hint:
- Funcţiile pe care trebuie să le implementaţi se vor apela între ele
- Pentru împărţiri cu semn: [cdq](https://stackoverflow.com/questions/36464879/when-and-why-do-we-sign-extend-and-use-cdq-with-mul-div)

### Punctare:
- Task-ul are 25 de puncte, dintre care 2 puncte pentru coding-style si detalierea implementarii.
