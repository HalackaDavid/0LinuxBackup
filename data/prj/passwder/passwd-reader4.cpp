#include <iostream>
#include <fstream>
std::string FileTxt;
std::fstream File, Temp;

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

int Count_lines(std::string Filename1) {
    int lines = 0;

    File.open(Filename1, std::ios::in);
    while(getline(File, FileTxt)) {
        if (File.eof() == 0) {
            lines++;
        }
    }
    File.close();
    return lines;
}

void WriteFile(std::string Filename1) {
    File.open(Filename1, std::ios::out | std::ios::app);
    std::cout << "New: ";
    std::cin >> FileTxt;
    File << FileTxt;
    File.close();
}

void ReadFile(std::string Filename1) {
    File.open(Filename1, std::ios::in);
    while(getline(File, FileTxt)) {
        std::cout << FileTxt << "\n";
    }
    File.close();
}

void DeleteFileLine(std::string Filename1) {
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

      /*
        if (lines == Chosed_line) {
            std::cout << "line Choosen has item: " << FileTxt;
            break;
        }
      */

    }
    Temp.close();
    File.close();

    const char * p = Filename1.c_str();
    remove(p);
    rename("Temp", p);
}

void Menu1(std::string Filename1) {
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
            DeleteFileLine(Filename1);
            break;
    }
}

int main() {
    /*
    1. Choose file
    2. Choose read wifi or write to (later delete = append file content without selected line which is for delete)
    */
    std::string Filename1 = "passwd.txt";
    std::cout << "lines: " << Count_lines(Filename1) << "\n";

    Menu1(Filename1);

    return 0;
}
