#include <stdio.h>

void func(char name[]) 
{
    printf("Hello %s\n", name);
}

int main() 
{
    func("User1");
    func("User2");
    func("User3");
    return 0;
}
