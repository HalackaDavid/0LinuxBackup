#include <iostream>

int count_digit(int number) {
    int count = 0;
    while(number != 0) {
      number = number / 10;
      count++;
    }
   return count;
}

int main() {

    std::cout << "Number of digits: " << count_digit(100);
    return 0;
}
