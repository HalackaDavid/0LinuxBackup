#include <iostream>
int main() {
    std::string newString;

    std::string arr[] = {"\"mac\":1234", "\"hostname\":localhost", "\"ip\":127.0.0.1"};
    std::string e = "\"hostname\":";

    for (std::string data : arr) {

        if (data.find(e) != std::string::npos) {
            std::cout << "Y >>"<< data;
            //1. remove "hostname" and ""
            if (data.find(e)  != std::string::npos) {
                data.erase(0, e.size());
            } else if (data.find("\"") != std::string::npos) {
                std::cout <<"FOUHND";
            }
            newString = data + "{" + newString;
        } else {
            std::cout << "N >>" << data;
            newString += data + ";";
        }
        std::cout << "\n";

    }
    newString += "}";
    std::cout << "DATA >> " << newString;

    return 0;
}
