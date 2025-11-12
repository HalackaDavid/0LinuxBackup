#include <iostream>
#include <fstream>

void ReadFile(std::string filename) {
    std::fstream file;
    std::string text;

    file.open(filename, std::ios::in);
    while ( getline (file, text)) {
        std::cout << text << "\n";
    }
    file.close();
}

void WriteFile(std::string filename) {
    std::fstream file;

    file.open(filename, std::ios::out|std::ios::app);
    file << "666\naaa";
    file.close();
}

void DeleteFile(std::string filename) {
    remove(filename.c_str());
}

void OpenPython() {
    
    system(PipType());
}

int main() {
    std::string filename = "hello.txt";

    //WriteFile(filename);
    ReadFile(filename);
    //DeleteFile(filename);
    OpenPython();
    return 0;
}
