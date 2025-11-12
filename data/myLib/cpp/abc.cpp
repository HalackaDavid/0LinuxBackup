#include <iostream>
void Ascii(int x, int y) {
	for(int i = 0; ( x + i ) <= y; i++) {
		std::cout <<  (char)(x+i) << std::endl;
	}
	return;
}

int main() {
	int i = 65;
	int y = 90;
	Ascii(i, y);

	return 0;
}

