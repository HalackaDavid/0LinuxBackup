#include <iostream>
#include <fstream>
#include <string>
int CountFileLine(std::string filename) {
    int count = 0;
    std::ifstream file;
    std::string data;

    file.open(filename);
    while (getline(file, data)) {
        count++;
    }
    file.close();

    return count;
}

std::string* createStrArray(std::string filename, int size) {
    int c = 0;
    std::ifstream file;
    std::string data;
    std::string* intArray = new std::string[size]; // Allocate memory for the array

    file.open(filename);
    // Initialize the array with values
  /*  for (int i = 0; getline(file, data); ++i) {
        intArray[i] = data;
    }*/
    while(getline(file, data)) {
        intArray[c] = data;
        c++;
    }
    file.close();
    return intArray;
}

int main() {
    std::string filename = "ddd";
    int size = CountFileLine(filename);

    std::string* myStringarr = createStrArray(filename, size);

    // Print the array
    for (int i = 0; i < size; ++i) {
        std::cout << myStringarr[i] << std::endl;
    }

    // Free the allocated memory
    delete[] myStringarr;

    return 0;
}
