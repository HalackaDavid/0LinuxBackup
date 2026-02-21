#include <stdio.h>
int main() {
    char x[] = { (char)('0' + sizeof(long)), '\0' };   
    puts(x);
    return 0;
}
