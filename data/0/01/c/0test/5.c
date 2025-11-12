#include <stdio.h>
int ann()
{
    //inside [] is max lenght of word (-1)
    char usr[11];
    int age;

    printf("1name: ");
    fgets(usr, sizeof (usr), stdin);
    printf("1age: ");
    scanf("%d", &age);

    printf("\n2user: %s", usr);
    printf("2age: %d", age);
}


int main()
{
    ann();
}
