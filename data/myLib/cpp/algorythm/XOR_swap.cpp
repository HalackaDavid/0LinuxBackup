#include <iostream>

//bitwise XOR swap algorithm
//method that avoids using a temporary variable
//good in low level or low on memory
int main() {
	int a = 37, b = 59;

	std::cout << a << "  " << b << std::endl;
	a = a ^ b;
	std::cout << a << "  " << b << std::endl;
	b = a ^ b;
	std::cout << a << "  " << b << std::endl;
	a = a ^ b;
	std::cout << a << "  " << b << std::endl;

	return 0;
}
