#include <iostream>

class A {
  int x;
public:
  A() { x = 0; ++x; }
};

int main() {
 for (int i = 0; i < 1000000000; ++i) {
   A *a = new A();
   std::cout << a << "\n";
   //delete a;
}
 std::cout << "DING!" << std::endl;
}
