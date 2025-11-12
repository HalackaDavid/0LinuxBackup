#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char* argv[])
{
    char* process_name = argv[0];
    char command[256] = "rm ";
    strcat(command, process_name);

    printf("Attempting to delete self...\n");

    system(command);
    return 0;
}
