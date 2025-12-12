#include <iostream>
using namespace std;

void compare(string* add_string, int* add_num) {
    *add_string = "AAA";
    *add_num = 5;
}

int main()
{

    string great;
    int small;
    int y;
    string x;
    cout << "Enter string and number: \n";

    compare(&great, &small);
    cout << "\nstring: " << great
         << "\nnumber: " << small
         << "\nnumber + 5: " << small + 5;
    return 0;
}

