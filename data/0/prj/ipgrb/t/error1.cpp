#include <iostream>

//AFTER RETURN FUNC WILL END

std::string inter1() {
    if (1 == 1) {
        return "Error1-1"; //AFTER THIS WILL NOT BE EXECUTED
    }
    std::cout << "Error1-2"; //THIS WILL NOT BE EXECUTED
    return 0;
}

std::string inter2() {
    std::string x;
    if (1 == 1) {
      x = "error2-1";
    }
    return x;
}

int main() {
    std::cout << inter1() << "\n"
              << inter2() << "\n";
    return 0;
}
