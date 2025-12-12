#include <iostream>
#include <string>
#include <cstdlib>
#include <cstdio>
#include <cstring>

int main() {
    std::string userInput;

    // Get user input
    std::cout << "Enter some text: ";
    std::getline(std::cin, userInput);

    // Open a pipe to the Python script
    FILE* pipe = popen("python3 script.py", "w");
    if (!pipe) {
        std::cerr << "Error opening pipe to Python script\n";
        return EXIT_FAILURE;
    }

    // Send user input to the Python script
    fprintf(pipe, "%s\n", userInput.c_str());
    pclose(pipe);

    // Open a pipe to read the result from the Python script
    pipe = popen("python3 script.py", "r");
    if (!pipe) {
        std::cerr << "Error opening pipe to Python script\n";
        return EXIT_FAILURE;
    }

    // Read the result from the Python script
    char buffer[100];
    std::fgets(buffer, sizeof(buffer), pipe);

    // Close the pipe
    pclose(pipe);

    // Display the result
    std::cout << "Result from Python script: " << buffer << std::endl;

    return 0;
}

