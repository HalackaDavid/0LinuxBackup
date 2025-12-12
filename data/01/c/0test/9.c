#include <stdio.h>
int main()
{
    char usri;
    printf("\n[1] Option 1\n[2] Option 2\n[b] Option b\nOption: ");
    scanf("%c", &usri);
    if (usri == '1')
        printf("option 1");
    if (usri == '2')
        printf("option 2");
    if (usri == 'b')
        printf("option b");
}