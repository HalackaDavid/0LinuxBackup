#include <iostream>
#include <fstream>

int main() {
    std::ifstream file("test.txt");
    std::string data;
    std::string newString;
    int count;

    while (getline(file, data)) {
        if (count == 0) {
            newString = data + "{";
        } else {
            newString = newString  +  data + ';';
        }
    count++;
    }
    newString = newString + "}";

    std::cout << newString;
    return 0;
}
