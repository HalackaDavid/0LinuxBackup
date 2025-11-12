#include <iostream>
#include <fstream>
#include <string>

//--CHANGE TO UNIVERSAL COUNT FILELINER--
int CountFileLines(std::string filename) {
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

std::string py(std::string data) {
    std::string newString;

    std::string arr[] = {"\"mac\":12341", "\"hostname\":localhost", "\"ip\":127.0.0.1"};
    std::string e = "\"hostname\":";

    if (data.find(e) != std::string::npos) {
        if (data.find(e) != std::string::npos) {
            data.erase(0, e.size());
        } else if (data.find("\"") != std::string::npos) {
            std::cout << "FOUND";
        }
        newString = data + newString;
    } else {
        newString += data + ";";
    }
    std::cout << "\n";

    return newString;
}

std::string InputPy (std::string command, std::string temp_py) {
    std::ifstream file;
    std::string data;
    std::string newData;
    int count = 0;

    system(command.c_str());
    file.open(temp_py);
    while (getline (file, data)) {
        if (count == 0) {
            newData = data + "{";
            count++;
        } else {
            newData += data + ";";
        }
    }
    newData += "}";
    file.close();
    //remove(temp_py.c_str());
    std::cout << py(newData) << " --THIS-- ";

    return newData;
}


/*
std::string py(std::string command, std::string ) {
    std::string newString;
    //file.py output
    std::string arr[] = {"\"mac\":1234", "\"hostname\":localhost", "\"ip\":127.0.0.1"};
    std::string findingString = "\"hostname\":";
    //file.py output better
    

    for (std::string data : arr) {
        if (data.find(findingString) != std::string::npos) {
            if (data.find(findingString) != std::string::npos) {
                data.erase(0, findingString.size());
            }
            newString = data + "{" + newString;
        } else {
            newString += data + ";";
        }
    }
    newString += "}";
    return newString;
}
*/



void Parser(std::string py_output, std::string database) {
    bool same = false;
    int count = 0;
    std::fstream file;
    std::string data, datarer;
    int filelines = CountFileLines(database);

    //read database
    file.open(database, std::ios::in);
    while (getline(file, data)) {
        if (data == py_output) {
            same = true;
            break;
        }
        datarer = data;
        count++;
    }
    file.close();

    if (same == false) {
        file.open(database, std::ios::out | std::ios::app);
        file << py_output << std::endl;
        file.close();
        std::cout << "Missing writen to database." << std::endl;
    }
}

void Starter() {
    std::string filename1= "data";
    std::string temp_DB = "d38910";
    std::string temp_py = "p38910";
    std::string command = "python3 p.py " + temp_py +  " hostname public_ip mac";
    std::string database = "database";

    InputPy(command, temp_py);
}

int main() {
    Starter();

    return 0;
}
