#include <stdio.h>
char hello()
{
    printf("Hello World!");
}

int calc()
{
    float x;
    float y;

    printf("number 1: ");
    scanf("%f", &x);

    printf("number 2: ");
    scanf("%f", &y);

    printf("%.2f\n", x + y);
    printf("%.2f\n", x - y);
    printf("%.2f\n", x * y);
    printf("%.2f\n", x / y);
}

int main()
{
    int num;
    printf("[1] hello world!\n[2] calculator\n Option:");
    scanf("%d", &num);
    
    if (num == 1)
        hello();
    if (num == 2)
        calc();
    
    return 0;
}