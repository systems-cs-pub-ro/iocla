# Task Bonus - Instructiuni speciale - CPUID

Biju intra intr-una din camerele din spatele lui Steve. Gaseste un plic pe care scrie "descopera".

CPUID este o instructiune speciala a procesoarelor care folosesc arhitectura x86, sau derivate, care permite aflarea unor informatii despre procesorul pe care se executa aceasta instructiune. Instructiunea cpuid nu primeste parametri, ci se executa in functie de continutul registrului eax si, in anumite situatii, a registrului ecx. Informatiile date ca raspuns sunt stocate in registrele eax, ebx, ecx, edx. Semnificatia rezultatelor este documentata in specificatia [Intel](https://web.archive.org/web/20120625025623/http://www.intel.com/Assets/PDF/appnote/241618.pdf).

Vi se cere sa aflati, folosind cpuid, urmatoarele informatii despre procesorul vostru:
 - Manufacturer ID-ul (3p)
 - daca este suportat setul de instructiuni [VMX](https://en.wikipedia.org/wiki/X86_virtualization#Intel_virtualization_(VT-x)) (1p)
 - daca este suportata instructiunea [RDRAND](https://en.wikipedia.org/wiki/RDRAND) (1p)
 - daca este suportat setul de instructiuni [AVX](https://en.wikipedia.org/wiki/Software_Guard_Extensions) (1p)
 - dimensiunea liniei de cache de nivel 2 (1p)
 - dimensiunea cache-ului de nivel 2, **pentru un singur nucleu** (1p)

Implementarea se va face in fisierul bonus_cpuid.asm.

Ultimele 2 puncte ale task-ului se vor acorda pentru descrierea implementarii si coding-style.
