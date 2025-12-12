#include <iostream>
#include <ctime>

int main() {
    // Get the current time
    time_t now = time(0);
    // Convert now to string form
    char* timeString = ctime(&now);
    // Output the current time
    std::cout << "GMT +0: "<< timeString;
    return 0;
}
