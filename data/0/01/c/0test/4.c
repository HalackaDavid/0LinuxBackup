#include <stdio.h>

int main()
{
    //must be 'D' not "D"
    char Hello1 = 'D';
    //C language haven't string data type so you need to make string in char by add after char name []
    char Hello2[] = "Hello world";
    
    printf("%c\n", Hello1);
    printf("%s", Hello2);
    return 0;
}