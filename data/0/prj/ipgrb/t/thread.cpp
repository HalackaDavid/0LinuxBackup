#include <iostream>
#include <thread>
#include <unistd.h>

namespace abcde {
    #include <thread>
    #include <unistd.h>

    void t1(int time, long num) {
        int i1 = 0;
        while(i1 < num* 10) {
            i1++;
        }
        std::cout << "Task1 done!"<< "\n";

    }

    void t2(int time, long num) {
        int i1 = 0;
        while(i1 < num) {
            i1++;
        }
        std::cout << "Task2 done!"<< "\n";
    }

    void threader() {
        int time = 0;
        long num = 100'000'000;
        std::thread th1(t1, time, num);
        std::thread th2(t2, time, num);
        th1.join();
        th2.join();
        std::cout << "\n\nDONE!\n";
    }
}

int main() {
    abcde::threader();

    return 0;
}
