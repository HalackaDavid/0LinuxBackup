#include <iostream>
#include <fstream>
#include <string>

//--CHANGE TO UNIVERSAL COUNT FILELINER--
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

//Read Database and return array
//--READ FILE AND PARSE CONTENT TO ARR--
//---delete[] arr;---
std::string* FTA_File_to_array(std::string filename, int filesize) {
    int count = 0;
    std::ifstream file;
    std::string data;
    std::string* arr = new std::string[filesize];

    file.open(filename);
    while(getline(file, data)) {
        arr[count] = data;
        count++;
    }
    file.close();

    return arr;
}

//---if data are equal or not---
void ParseWithDB(std::string* arr, int lines) {

}

void Data_sorter(std::string Fname, std::string Ftemp) {
    std::fstream file_in, file_out;
    char start = '{';
    char end = '}';
    char data;
    std::string datarer;

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
}

std::string* py(int &lines) {
    std::string filename1= "data";
    std::string temp_DB = "d38910";
    std::string temp_py = "p38910";
    std::string pfile = "p.py";
    std::string command = "python3 " + pfile + " " + temp_py + " hostname public_ip mac";
    std::string database = "database";

    //python
    system(command.c_str());
    lines = CountFileLine(temp_py);
    std::string* arr = FTA_File_to_array(temp_py, lines);
    remove(temp_py.c_str());

    lines; //important

    

    return arr;
}

void Starter() {
    std::string filename1= "data";
    std::string temp_DB = "d38910";
    std::string temp_py = "p38910";
    std::string pfile = "p.py";
    std::string command = "python3 " + pfile + " " + temp_py + " hostname public_ip mac";
    std::string database = "database";
    int py_lines;

    //python
    std::string* arr = py(py_lines);
        //read python
    for (int i = 0; i < py_lines; i++) {
        std::cout << arr[i] << std::endl;
    }



    //Database
//    Data_sorter(database, temp_DB);
    ParseWithDB(arr, py_lines);

    delete[] arr;
    arr = NULL;
    std::cout << "\nHeaps were freed >> " << arr << std::endl;
}

int main() {
    //nodel
    Starter();
    //DONE ???
//    DB_local_sorter("database", "DBtemp");

    return 0;
}
