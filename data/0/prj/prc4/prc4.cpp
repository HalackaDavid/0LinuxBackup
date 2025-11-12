#include <iostream>

void Clear() {
    #ifdef _WIN32
        system("cls");
    #elif __linux__
        system("clear");
    #endif
}

void Inventory() {std::cout << "SHOWING INVENTORY\n";
	/*Load from in Inventory.txt*/
}

void NewGame() {
	/*make file Game{number}
	if file Game{number} exists int i++ until Game{number} = 0*/
}
void LoadGame() {

}

void MenuStart() {
    char usri[64];

    while (1) {
        std::cout << "[1] Start New Game\n[2] Load Game\n[b] Exit\nChoice: ";
		
        if (usri == "1") {
            std::cout << "NEW GAME\n";
        } else if (usri == "2") {
            std::cout << "LOAD GAME\n";
        } else if (usri == "b") {
            return;
        }
    }
}

int main() {
    Clear();
    MenuStart();

    return 0;
}
