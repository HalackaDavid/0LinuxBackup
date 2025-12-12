#include <iostream>
#include <string>
#include <fstream>

void Add_to_DB(std::string py_output, std::string database) {
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
        std::cout << "New data added." << std::endl;
    }
}

void Data_sorter(std::string Fname, std::string Ftemp) {
    std::fstream file_in, file_out;
    char start = '{';
    char end = '}';
    char data;
    std::string datarer;
    std::cout << "Sorting....\n";

    file_in.open(Fname, std::ios::in);
    while (file_in >> data) {
        if (data == start) {
            datarer += data;
        } else if (data == end) {
            datarer += data;
            file_out.open(Ftemp, std::ios::out | std::ios::app);
            file_out << datarer << std::endl;
            file_out.close();
            datarer = "";
        } else {
            datarer += data;
        }
    }
    file_in.close();
    std::remove(Fname.c_str());
    std::rename(Ftemp.c_str(), Fname.c_str());

    std::cout << "Sorting done." << std::endl;
}
