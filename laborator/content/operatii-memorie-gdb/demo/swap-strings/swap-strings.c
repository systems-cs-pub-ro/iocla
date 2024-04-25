#include<stdio.h>

void swap1(char *str1, char *str2)
{
    char *temp = str1;
    str1 = str2;
    str2 = temp;
}

void swap2(char **str1_ptr, char **str2_ptr)
{
    char *temp = *str1_ptr;
    *str1_ptr = *str2_ptr;
    *str2_ptr = temp;
}

int main()
{
    char *str1 = "A";
    char *str2 = "B";
    swap1(str1, str2);
    printf("str1 = %s - str2 = %s\n", str1, str2);

    str1 = "A";
    str2 = "B";
    swap2(&str1, &str2);
    printf("str1 = %s - str2 = %s\n", str1, str2);

    return 0;
}
