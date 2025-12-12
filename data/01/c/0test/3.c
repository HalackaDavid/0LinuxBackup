#include <stdio.h>

int main(void)
{
    int usri1;

    printf("Menu\n[1]Option1\nOption2\nChoose: ");
    scanf("%d", &usri1);
    
    if(usri1 == 1)
        printf("opt 1");
    if(usri1 == 2)
        printf("opt 2");

    return 0;
}
