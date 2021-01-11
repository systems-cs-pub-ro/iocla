#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char surrname[20] = {0};

int main()
{
    char hidden2[15] = {0};
    char mando[15] = {0};
    char hidden1[15] = {0};
    char answer[4] = {0};

    printf("Hello! Are you eager to solve the final assignment? [Yes/ No/ ???]\n");
    gets(answer);
    if (strncmp(hidden1, "ssssssssss", 10) == 0)
    {
        printf("Oh, you found me! Here's a test:\n");
        printf("What's the name of the Mandalorian?\n");
        gets(mando);
        if (strncmp(mando, "Din Djarin", 10) == 0)
        {
            if (strncmp(hidden2, "IOCLA", 5) == 0)
            {
                
                if (strncmp(hidden2 + 10, "Grogu", 5) == 0)
                {
                    printf("What's your name, son? (sorry if I assume your gender, I'm not very smart)\n");
                    scanf("%s ", surrname);
                    printf("%s, you proved to be worthy. When the time is right, answer our call!\n", surrname);
                    printf("SSSv8{Live long and prosper}\n");
                }
                else
                    printf("Almost there\n");
            }
            else 
                printf("Yes, that's him. It was a pleasure speaking to you. Bye!\n");
        }
        else if (strncmp(mando, "Bobba Fett", 10) == 0)
            printf("Sorry to dissapoint you, but he's not a real mandalorian.\n");
        else
            printf("You are not worthy\n");
    }
    else if (strncmp(answer, "Yes", 3) == 0)
        printf("Glad to hear it! Stay tuned!\n");
    else if (strncmp(answer, "No", 2) == 0)
        printf("Shame :( Maybe you change your mind. We have cookies!\n");
    else if (strncmp(answer, "???", 3) == 0)
        system("wget --output-document=confused.bmp \'https://i.dietdoctor.com/wp-content/uploads/2013/01/confused.bmp?auto=compress%2Cformat&w=650&h=431&fit=crop\'");
    else
        printf("Are you trying to mess with me? Terminating\n");
    return 0;
}