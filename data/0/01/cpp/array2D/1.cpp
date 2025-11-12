#include <iostream>
#include <string>
//x = column, y = row

int main() {

    int kinosal[10][5];
    for (int y = 0; y < 10; y++) {
        for (int x = 0; x < 5; x++) {
            kinosal[y][x] = 0;
        }
    }

    kinosal[5][2] = 7;
    kinosal[4][2] = 7;
/*
    int radek1 = 1,
        pocet1 = 10;

    int radek2 = 3,
        pocet2 = 10;

    for (int i = 0; i < pocet1; i++) {
        kinosal[i][radek1] = 1;
    }

    for (int i = 0; i < pocet2; i++) {
        kinosal[i][radek2] = 1;
    }
*/

    for (int j = 0; j < 5; j++) {
        for (int i = 0; i < 10; i++) {
            std::cout << kinosal[i][j];
        }
    std::cout << std::endl;
    }

    return 0;
}
