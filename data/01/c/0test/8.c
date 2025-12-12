//Create or Apend txt to file
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char file1[6] = "t.txt";

int clear() 
{
	#ifdef _WIN32
	    system("cls");
	#elif __linux__
	    system("clear");
	#elif __unix__
	    system("clear");
	#else
	    system("clear");
	#endif
	return 1;
}

int readf()
{
    FILE *fptr;
    fptr = fopen(file1, "r");
    char String[100];
    if (fptr == NULL)
    {
        printf("File not exists");
    }
    else    
    {    
        while(fgets(String, 100, fptr)) 
        {
            printf("%s", String);
        }
        fclose(fptr);
    }
}
int delf()
{
    if (remove(file1) == 0)
    {
        printf("file remove succesfuly");
    }
    else
    {
        printf("file remove unsuccesfuly");
    }
}

int apndf()
{
    char usri1[300];
    FILE *fptr;
    printf("Text: "); //its starts after fgets and its output
    fgets(usri1, 254, stdin);
    fptr = fopen(file1, "a");
    fprintf(fptr, usri1);
    fclose(fptr);
}

int crtf()
{
    FILE *fptr;
    fptr = fopen(file1, "w");
    fclose(fptr);
}

int main()
{
    while (1)
    {
        int usri;
        printf("[1] Create file\n[2] Apend to file\n[3] Delete file\n[4] Read file\n[5] Exit\noption: ");
        scanf("%d", &usri);
        printf("==================\n");
        fgetc(stdin);
        if (usri == 1)
            crtf();
        if (usri == 2)
            apndf();
        if (usri == 3)
            delf();
        if (usri == 4)
            readf();
        if (usri == 5)
            return 0;
    }   
}
