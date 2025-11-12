#include <iostream>
#include <fstream>

std::string File1Txt;
std::fstream File1;

int Counting_lines(std::string Filename1) {
    int lines = 0;
    
    File1.open(Filename1, std::ios::in);
    while(getline(File1, File1Txt)) {
        if (File1.eof() == 0) {
            lines++;
        }
    }
    File1.close();
    return lines;
}

void WriteFile(std::string Filename1, std::string File1Txt) {
    File1.open(Filename1, std::ios::out);
    File1 << File1Txt;
    File1.close();
}

void ReadFile(std::string Filename1) {
    File1.open(Filename1, std::ios::in);
    while(getline(File1, File1Txt)) {
        std::cout << File1Txt << "\n";
    }
    File1.close();
}

void line_Chooser(std::string Filename1, int Chosed_line) {
    int lines = 0;

    File1.open(Filename1, std::ios::in);
    while(getline(File1, File1Txt)) {
        lines++;
        if (lines == Chosed_line) {
            std::cout << "line Choosen has item: " << File1Txt << "\n";
            break;
        }
    }
    File1.close();
}

std::string Filename() {
    std::string Filename;
    std::cout << "File name: ";
    std::cin >> Filename;

    return Filename;
}

int main() {
    std::string Filename1;
    Filename1 = Filename();
    ReadFile(Filename1);
    line_Chooser(Filename1, 2);
    std::cout << Counting_lines(Filename1);
    return 0;
}
