/* 
echo 0 >  /proc/sys/kernel/randomize_va_space

se compilează fără optimizări -O2, și fără canar: 
gcc  -m32  -g -Fdwarf  -fno-stack-protector -o nocanary auth_overflow.c
- se testează diverse parole 

3 demo-uri: 

1. MODIFICARE BINAR nocanary
- cp nocanary nocanary.orig
- se caută adresa funcției check_authentication cu nm ./a.out => 0x4DD
- in radare/biew se identifica in funcție zona critica a testului (la 0x52F)
- se suprascrie cu NOP-uri (0x90) pentru a returna mereu 1
- Victorie: binarul obținut acceptă orice parolă! 

2. OVERFLOW nocanary peste variabila auth_flag
- se pasează o parolă de 17 caractere!

3. STACK CANARY 
opțiunea -fno-stack-protector dezactivează canarul 

se compară canary.s cu nocanary.s pentru a vedea implementarea canarului 
se compară canary.lst cu nocanary.lst pentru a vedea implementarea canarului 
se rulează canary și nocanary cu parole sub și peste 17 caactere 

4. OPȚIUNEA pie 
se rulează succesiv pentru a observa adresele .data și .stack care au valori mereu altele
*/

#include <stdio.h> 
#include <stdlib.h> 
#include <string.h>

char brillig[] = "brillig",
  outgrabe[] = "outgrabe"; 

int check_authentication(char *password) 
{ 
  int auth_flag = 0;
  char password_buffer[16];
  printf(".data address = %x; stack_address = %x\n", &brillig, &password_buffer);

  strcpy(password_buffer, password);
  if(strcmp(password_buffer, brillig) == 0) 
    auth_flag = 1;
  if(strcmp(password_buffer, outgrabe) == 0) 
    auth_flag = 1;
  return auth_flag; 
}

int main(int argc, char *argv[]) 
{
  if(argc < 2) {
    printf("Usage: %s <password>\n", argv[0]);
    exit(0); 
  }
  if(check_authentication(argv[1])) { 
    printf("\n-=-=-=-=-=-=-=-=-=-=-=-=-=-\n"); 
    printf(" Access Granted.\n"); 
    printf("-=-=-=-=-=-=-=-=-=-=-=-=-=-\n");
  } else {
    printf("\nAccess Denied.\n");
  } 
}
