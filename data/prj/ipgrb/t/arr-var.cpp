#include <iostream>
#include <string>
#include <fstream>

int counter() {
    int count = 0;
    std::fstream file;
    std::string data;
    file.open("database", std::ios::in);
    while (getline(file, data)) {
        count++;
    }
    file.close();
    return count;
}

std::string* arr_var3() {
    int count = 0;
    std::fstream file;
    std::string data;
    file.open("database", std::ios::in);
    std::string* arr = new std::string [counter()];

    while(getline(file, data)) {
        //std::cout << data << "\n";
        //to array
        arr[count] = data;
        count ++;
    }
    file.close();
    for (int i = 0; i < count; i++) {
        std::cout << "ARR[" << i << "] " << arr[i] << "\n";
    }
    return arr;
}

//UNTIL EXIT CODE IT WILL ALWAYS APPEND STRINGS TOGETHER
void arr_var2() {
    std::string exitcode = "exit";
    std::string input;
    std::string text;
    int count = 0;
    do {
        std::cout << "Enter some txt: ";
        std::cin >> input;
        if (input != exitcode) {
            text = text + input;
            count ++;
        }
    } while(input != exitcode);
    std::cout << "\nText: " << text
              << "\nCount: " << count
              << "\n";
}

//FROM ARR TO STRING + NULL THE POINTER
void arr_var1() {
    int stringSize = 3;
    int count = 0;
    std::string* s = new std::string [stringSize];
    std::cout << "\nEnter " << stringSize << " one-word string values:\n";
    while (count < stringSize) {
        std::string tmpVal;
        std::cin >> tmpVal;
        s[count] = tmpVal;
        count ++;
    }
    //printing / between
    std::cout << "\n";
    std::string newString;
    for (int i = 0; i < stringSize; i++) {
        std::cout << s[i] << "/";
        newString = newString + s[i];
    }
    std::cout << "\n"
              << "\nString: " << newString
              << "\nS(in memory): " << s;
    delete[] s; //this will just say to memory that this chunck can be rewrited any moment
    s = NULL; //this will ensure that this pointer will be rewrited as 0;
    std::cout << "\n"
              << "\nString: " << newString
              << "\nS(=NULL): " << s << "\n";
}

//MAIN FUNC
int main(int argc, char *argv[]) {
    std::cout << *arr_var3();
    return 0;
}
