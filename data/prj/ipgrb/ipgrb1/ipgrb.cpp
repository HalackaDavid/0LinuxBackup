#include <iostream>
#include <string>
#include <fstream>

int CountFileLines(std::string filename) {
    std::ifstream file;
    std::string data;
    int count;

    file.open(filename);
    while (getline(file, data)) {
        count++;
    }
    file.close();
    return count;
}

std::string py(std::string command, std::string temp_py) {
    std::string newString;
    std::string data;
    std::ifstream file;
    std::string findingString = "\"hostname\":";

    system(command.c_str());
    file.open(temp_py);
    while (getline(file, data)) {
        if (data.find(findingString) != std::string::npos) {
            if (data.find(findingString) != std::string::npos) {
                data.erase(0, findingString.size());
            }
            newString = data + "{"+ newString;
        } else {
            newString += data + ";";
        }
    }
    newString += "}";
    file.close();
    std::remove(temp_py.c_str());

    return newString;
}
