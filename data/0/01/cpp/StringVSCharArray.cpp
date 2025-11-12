#include <iostream>
#include <string>

int main() {
    char c[] = "abcd";
    std::string s = "abcd";

    std::cout << "Char:\n"
              << "=====\n"
              << c << "\n"
              << c[1] << "\n"
              << "\n"
              << "String:\n"
              << "=======\n"
              << s << "\n"
              << s[1] << "\n";

    return 0;
}
