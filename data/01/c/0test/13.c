#include <stdio.h> /* printf */
#include <string.h> /* strrchr */

//Bad sorting
int main()
{
    const char filename[20] = "program.cc";
    const char *ext = strrchr(filename, '.');
    if (!ext) 
    {
        /* no extension */
    } 
    else
    {
        printf("extension is %s\n", ext);
    }    
    if ( strstr(ext, ".cs") != NULL )
    {
        printf("programing language is cs\n");
    }
    else if ( strstr(ext, ".cpp") != NULL )
    {
        printf("programing language is cpp\n");
    }
    else if ( strstr(ext, ".c") != NULL )
    {
        printf("programing language is c\n");
    }
}