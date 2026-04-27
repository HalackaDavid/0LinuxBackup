#include <iostream>
#include <fstream>
std::string line = "=================\n";

void Clear() {
        #ifdef _WIN32
            system("cls");
        #elif __linux__
            system("clear");
        #elif __unix__
            system("clear");
        #else
            system("clear");
        #endif
}

void WriteFile(std::string Filename1) {
    std::fstream File;
    std::string FileTxt;

    File.open(Filename1, std::ios::out | std::ios::app);
    std::cout << "New: ";
    std::cin >> FileTxt;
    File << FileTxt;
    File.close();
}

void ReadFile(std::string Filename1) {
    std::fstream File;
    std::string FileTxt;
    int count = 0;

    File.open(Filename1, std::ios::in);
    while(getline(File, FileTxt)) {
        count ++;
        std::cout << " " << count << " | "<< FileTxt << "\n";
    }
    File.close();
}

void DeleteFileLine(std::string Filename1) {
    std::fstream File, Temp;
    std::string FileTxt;
    int Chosed_line, lines = 0;

    std::cout << "delete line: ";
    std::cin >> Chosed_line;
    Temp.open("Temp", std::ios::out);
    File.open(Filename1, std::ios::in);
    while(getline(File, FileTxt)) {
        lines++;

        if (lines != Chosed_line) {
            Temp << FileTxt << std::endl;
        }
    }
    Temp.close();
    File.close();

    const char * p = Filename1.c_str(); //changing to const char
    remove(p); //removing file
    rename("Temp", p); //changing name to removed file
}

void PasswdReader(std::string Filename1) {
    int usri;

    std::cout << "[1] write\n[2] show wifi\n[3] delete\n>>> ";
    std::cin >> usri;
    switch (usri) {
        case 1:
            WriteFile(Filename1);
            break;
        case 2:
            ReadFile(Filename1);
            break;
        case 3:
            ReadFile(Filename1);
            std::cout << line;
            DeleteFileLine(Filename1);
            std::cout << line;
            ReadFile(Filename1);
            break;
    }
}

int main() {
    /*
    1. Choose file
    2. Choose read wifi or write to (later delete = append file content without selected line which is for delete)
    */
    std::string Filename1 = "passwd.txt";

    Clear();
    PasswdReader(Filename1);

    return 0;
}
