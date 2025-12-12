#include <iostream>

int main() {
    int x = 3,
        y = 9,
        arr[x][y];

//cout
    for (int x1 = 0; x1 < x; x1++) {
        for (int y1 = 0; y1 < y; y1++) {
             arr[x1][y1] = 0;
        }
    }

    arr[0][0] = 1;

    for (int x2 = 0; x2 < x; x2++) {
        for (int y2 = 0; y2 < y; y2++) {
            std::cout << arr[x2][y2];
        }
    std::cout << std::endl;
    }

    return 0;
}
