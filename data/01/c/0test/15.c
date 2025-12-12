#include <stdio.h>
#include <string.h>

int main() 
{ 
 
    char* ext;
    char* p;
    char fullname [] = "file.txt";
    ext = strchr(fullname,'.');
    printf("extension - %s\nfilename - ",ext+1);
    for(p=fullname;p!=ext;p++)
    {
        printf("%c",*p);
    }
    printf("\n");
     
}