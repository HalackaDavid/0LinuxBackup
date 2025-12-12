#include <iostream>
#include "ipgrb.cpp"
#include "Databaser.cpp"

int main() {
    std::string temp_DB = "d38910";
    std::string temp_py = "p38910";
    std::string command = "python3 p.py " + temp_py +  " hostname public_ip mac";
    std::string database = "database";

    std::string database1 = "database-test"; //TEMPORARY
    std::string tempDB = "TDB"; //TEMPORARY

    std::cout << "Add_to_DB(py())\n";
    Add_to_DB(py(command, temp_py), database1);
    std::cout << "Data_sorter()\n";
    Data_sorter(tempDB, temp_DB);

    return 0;
}
