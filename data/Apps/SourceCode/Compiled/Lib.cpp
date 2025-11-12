#include <iostream>
#include <dirent.h>
#include <cstring>

namespace Get {
	char **DirListArr(char *in_cstr, char **arr, int &lenght) {
		char *aarr[1024];
		struct dirent *de;
		bool bFound;

		DIR *dr = opendir(in_cstr);
		if (dr == NULL) {
	        std::cout << "Could not open passed directory\n";
			char **error = new char*[11];
			error[0] = "error\0";
			error[1] = "open error\0";
			return error;
	    }
		int count = 0;
	    while ((de = readdir(dr)) != NULL) {
			bFound = false;

			for (int i = 0; i < 2; i++) {
				if (strcmp(de->d_name, arr[i])==0) {
					bFound = true;
					break;
				}
			}

			if (bFound == false) {
				aarr[count] = de->d_name;
				count++;
			}

		}

		char **a = new char*[count];

		for (int i = 0; i < count; i++) {
			a[i] = aarr[i];
		}
		lenght = count;
		closedir(dr);

		return a;
	}
}

int main() {
	char *rootPath = "/root/myLib\0";
	char *no[3] = {".", ".."};
	int userInput;
	int lenght_dirList;

	char **dirList = Get::DirListArr(rootPath, no, lenght_dirList);
	if (dirList[0] == "error\0") {
		delete[] dirList;
		dirList = NULL;
		return -1;
	}

	for (int i = 0; i < lenght_dirList; i++) {
		std::cout << "[" << i+1 << "] " << dirList[i] << "\n";
	}

	std::cout << ">> ";
	std::cin >> userInput;

	if (!(userInput >= 0 && userInput <= lenght_dirList)) {
		return -1;
	}
	std::cout << "\n<< " << dirList[userInput-1];

	delete[] dirList;
	dirList = NULL;
	return 0;
}
