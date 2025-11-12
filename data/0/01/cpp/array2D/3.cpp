#include <iostream>
#include <string>
//x = row, y = column

void map_printer(int x, int y) {
    int map[x][y];

    for (int row = 0; row < x; row++) {
        for(int column = 0; column < y; column++) {
            map[row][column] = 0;
        }
    }

    //map[][] = 1;
    map[1-1][1-1] = 9; //player
    map[2-1][2-1] = 1; //enemy1
    for (int row = 0; row < x; row++) {
        for (int column = 0; column < y; column++) {
            std::cout << map[row][column];
        }
        std::cout << std::endl;
    }

}

int main() {
    int x,y;

    std::cout << "row: ";
    std::cin >> x;
    std::cout << "column: ";
    std::cin >> y;
    std::cout << "enemy = 1" << "\n" << "player = 9" << "\n";
    map_printer(x, y);

    return 0;
}
