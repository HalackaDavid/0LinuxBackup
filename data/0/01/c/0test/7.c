//Create File
#include <stdio.h>

int main()
{
    FILE *fptr;
    fptr = fopen("hello.txt", "w");
    fprintf(fptr,"hello World!");
    fclose(fptr);
    return 0;
}