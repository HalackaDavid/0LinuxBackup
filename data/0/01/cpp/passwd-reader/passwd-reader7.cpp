#include <iostream>
#include <fstream>

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

int StrLen(const char *str) {
	int i = 0; while(str[i] != '\0') {i++;}
	return i;
}

int Compare_cStr(const char *str1, const char *str2) {
	int len1 = 0; while(str1[len1] != '\0') {len1++;}
	int len2 = 0; while(str2[len2] != '\0') {len2++;}

	if (len1 == len2) {
		for (int i = 0; i < len1; i++) {
			if (str1[i] != str2[i]) {
				return 0; //not equal
			}
		}
		return 1; //equal
	}
	return 0; //not equal
}

void WriteFile(std::string Filename1) {
    std::fstream File;
    std::string FileTxt;

    File.open(Filename1, std::ios::out | std::ios::app);
    std::cout << "New: ";
    std::cin >> FileTxt;
    File << FileTxt << "\n";
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

int PasswdReader(char *fileName) {
	char userInput[16];
    while (1) {
        std::cout << "[clear] clear terminal\n[1] write\n[2] show wifi\n[3] delete\n[0] Exit\n>>> ";
        std::cin >> userInput;
//        std::cin.clear();
		std::cout << "\n";
        if (Compare_cStr(userInput, "clear")){
            Clear();
        }
        else if (Compare_cStr(userInput, "1")) {
            WriteFile(fileName);
        }
        else if (Compare_cStr(userInput,"2")) {
            ReadFile(fileName);
            std::cout << "\n";
        }
        else if (Compare_cStr(userInput,"3")) {
            ReadFile(fileName);
            DeleteFileLine(fileName);
            ReadFile(fileName);
            std::cout << "\n";
        }
        else if (Compare_cStr(userInput,"0")) {
			return 0;
            break;
        }
    }
	return 0;
}

int main() {
    Clear();
    char fileName[16] = "passwd.txt";
    PasswdReader(fileName);
    return 0;
}
