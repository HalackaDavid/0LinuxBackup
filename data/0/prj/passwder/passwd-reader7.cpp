#include <iostream>
#include <fstream>
#include <cstring>
#include "/root/myLib/cpp/cString/Strcmp.h"
#include "/root/myLib/cpp/cString/StrLen.h"
#include "/root/myLib/cpp/cString/Strapp.h"
#include "/root/myLib/cpp/ClearStdin.h"
#define READ_BUFFER 1024
#define WRITE_BUFFER 256

namespace Test {
	void cStr1(char *buffer) {
		for(int i = 0; true; i++) {
			if (buffer[i] == '\n') {
				std::cout << "n" << i << ": " << "NEW LINE" << std::endl;
			} else if (buffer[i] == '\0') {
				std::cout << "0" << i << ": " << "NULLTERM" << std::endl;
				break;
			} else if (buffer[i] != '\n'){
				std::cout << "e" << i << ": " << buffer[i] << std::endl;
			}
		}
	}
}

namespace Refactoring {
	int WriteFile(char *fileName) {
		FILE *file;
		char opt[3][11] = {"AP ESSID: ", "WPA PSK:  ", "WPS PIN:  "};
		char fileTxt[30];
		char buffer[WRITE_BUFFER];
		int buffer_size = 0;
		int loop_count;
		int opt_size = sizeof(opt)/sizeof(opt[0]);
		int max_fileTxt = sizeof(fileTxt)/sizeof(fileTxt[0]);

//		file = fopen(fileName, "a");

		std::cout << opt_size << "\n";
		for(int i = 0; i < opt_size; i++) {
			std::cout << opt[i] << "|" << opt_size << "|";
			if(fgets(fileTxt, max_fileTxt, stdin)) {
				for(loop_count = 0; fileTxt[loop_count] != '\n' && loop_count < max_fileTxt; loop_count++);

				if (fileTxt[0] == '\n') {return 1;}

				Strapp(buffer, fileTxt, &buffer_size, StrLen(fileTxt));
				std::cout << buffer_size << "/" << WRITE_BUFFER << "|" << StrLen(fileTxt) << "|" << max_fileTxt << std::endl;
//				if(!Strcmp(fileTxt, "\n")) {std::cout << "COMPARE 1\n"; fprintf(file, fileTxt);}
			} else {
				i--;
				std::cout << "error user input";
			}

			ClearStdin(loop_count, max_fileTxt);
		}

		Test::cStr1(buffer);

//	    fclose(file);
		return 0;
	}
}

void Clear() {
        #ifdef __linux__
            system("clear");
        #elif __unix__
            system("clear");
        #elif _WIN32
            system("cls");
        #endif
}

void ReadFile(char *fileName) {
	FILE *file;
	char fileTxt[READ_BUFFER];
    int count = 0;
	file = fopen(fileName, "r");
    while(fgets(fileTxt, sizeof(fileTxt)/sizeof(fileTxt[0]), file)) {
        count ++;
        std::cout << " " << count << " | " << fileTxt;
    }
	fclose(file);
}

void DeleteFileLine(char *fileName) {
    FILE *file, *temp;
	char fileTxt[READ_BUFFER];
	char line[8];
    int lines = 0;

    std::cout << "delete line: ";
	fgets(line, sizeof(line)/sizeof(line[0]), stdin);

    temp = fopen("Temp", "a");
    file = fopen(fileName, "r");

    while(fgets(fileTxt, sizeof(fileTxt)/sizeof(fileTxt[0]), file)) {
        lines++;

        if (lines != atoi(line)) {
            fprintf(temp, fileTxt);
        }
    }
    fclose(temp);

    remove(fileName); //removing file
    rename("Temp", fileName); //changing name to removed file
}

int PasswdReader(char *fileName) {
	char userInput[16];
	char ch;
	int i;
	int max_userInput = sizeof(userInput)/sizeof(userInput[0]);
	while(1) {
//		std::cout << "[clear] clear display\n[1] write\n[2] show\n[3] delete\n[0] Exit\n>>> ";
		std::cout << "pswd >> ";
		fgets(userInput, max_userInput, stdin);
		for(i = 0; userInput[i] != '\n' && i < max_userInput; i++);
		userInput[i] = '\0';
	    if(Strcmp(userInput, "clear")){
			Clear();
	    }
	    else if(Strcmp(userInput, "w")) {
//			WriteFile(fileName);
	    }
	    else if(Strcmp(userInput, "r")) {
			ReadFile(fileName);
	    }
	    else if(Strcmp(userInput, "d")) {
			DeleteFileLine(fileName);
	    }
	    else if(Strcmp(userInput, "exit")) {
//			Clear();
			return 0;
	    } else {
			std::cout << "[" << userInput << "] Command not known" << std::endl;
		}

		if (i >= (max_userInput - 1)) {
			while((ch = fgetc(stdin)) != '\n' && ch != EOF); //clearing stdin
		}
	}
	return 0;
}

int main() {
	//executable pswd
    char fileName[11] = "passwd.txt";
//	Clear();
//	PasswdReader(fileName);
	Refactoring::WriteFile(fileName);
	return 0;


//	making atoi with int ASCII
//	arr= {'1','2','3','\0'};
//	lenght is 4 but - 1 so 3 first element is 3, second is 2, third is 1
// --> 3 == 100, 2 == 10, 1 == 1
}
