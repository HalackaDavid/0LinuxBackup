#include <iostream>
#include <fstream>

int Counting2(std::string filename1) {
    int lines = 0;
    std::string RFile1;
    std::fstream File1;

    File1.open(filename1, std::ios::in);
    while (getline(File1, RFile1)) {
        lines++;
    }
    return lines;
}

int Counting1(std::string filename1) {
    int lines = 0;
    std::string RFile1;
    std::fstream File1;

    File1.open(filename1, std::ios::in);
    while (getline(File1, RFile1)) {
        lines++;
    }
    File1.close();
    return lines;
}

void Read(std::string filename1) {
    std::string RFile1;
    std::fstream File1;
    int lines = 1;

    File1.open(filename1, std::ios::in);
    while (getline(File1, RFile1)) {
        if (lines < 10) {
            std::cout << lines << "  " << "| " << RFile1 << "\n";
        }
        else if (lines < 100) {
            std::cout << lines << " " << "| " << RFile1 << "\n";
        }
        lines++;
    }
    File1.close();
}

void Choose_line(std::string filename1) {
    std::string RFile1;
    std::fstream File1;
    int lines = 0;
    int counter = 1;

    File1.open(filename1, std::ios::in);
    while (getline(File1, RFile1)) {
        lines++;
        if (lines == counter) {
            std::cout << "\nline choosen: " << counter << ", line: " << lines << ", text: " << RFile1 << "\n";
            break;
        }
    }
    File1.close();
}

int count_digit(int number) {
    int count = 0;
    while(number != 0) {
      number = number / 10;
      count++;
    }
   return count;
}

int main() {
    std::string mode, filename1 = "passwd1.txt";

    Read(filename1);
    Choose_line(filename1);
    int x = Counting1(filename1);
    int y = Counting2(filename1);
    std::cout << x << "\n" << y;
    return 0;
}
