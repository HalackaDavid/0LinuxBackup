#include <stdio.h>
//first line = first wifi log, second line = second wifi log......
// befor ":" = wifi name
// after ":" = wifi password
FILE *file1;
int reader()
{
    int line1 = 1;
    int linesearch1 = 1;
    int i;
    char fileread1[100];
    file1 = fopen("txt.txt","r");
    while(fgets(fileread1,100,file1))
    {
        for (i = 1; line1 <= linesearch1; i++)
        {
            if(linesearch1 == line1)
            {
                printf("line %d: %s",linesearch1, fileread1);
            } 
            line1++;
        }
        linesearch1++;
    }
    fclose(file1);
}

int main()
{
    reader();
    int line2 = 1;
    int linesearch2;
    int found = 0;
    char liner[100];
    printf("\n\nline number:");
    scanf("%d",&linesearch2);
    file1 = fopen("txt.txt","r");
    while(fgets(liner,100,file1))
    {
        if(linesearch2 == line2)
        {
            found = 1;
            printf("line %d: %s",linesearch2,liner);
        }
        line2++;
    }
    fclose(file1);
    if (found == 0)
    {
        printf("line number %d was not found",linesearch2);
    }
}