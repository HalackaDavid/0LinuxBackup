#include <iostream>

int main() {
    int i = 0;
    std::string arr[] = {"abc","def","ghi","jkl"};
    for (std::string arrger : arr) {
        std::cout << arrger << "\n";
    }

    return 0;
}
