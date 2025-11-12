#include <iostream>
#include <fstream>

void Read(std::string filename1) {
    std::string RFile1;
    std::fstream File1;
    int lines = 0;

    File1.open(filename1, std::ios::in);
    while (getline(File1, RFile1)) {
        std::cout << RFile1 << "\n";
        lines++;
    }
    std::cout << "\nLines: " << lines << "\n";
    File1.close();
}

void Read1(std::string filename1) {
    std::string RFile1;
    std::fstream File1;
    int lines = 0;
    int counter = 1;
    File1.open(filename1, std::ios::in);
    while (getline(File1, RFile1)) {
        lines++;
        if (lines == counter) {
            std::cout << RFile1 << "\n";
            break;
        }
    }
    File1.close();
}

int main() {
    std::string filename1 = "passwd1.txt";
    Read(filename1);
    Read1(filename1);
    return 0;
}
