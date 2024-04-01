#include <iostream>
#include <cstdlib> 
#include <ctime>   

int main() {
    srand(time(0));


    for (int i = 0; i < 1; ++i) {
        int testCase = rand() % 100 + 1;
        std::cout << testCase << std::endl;
    }

    return 0;
}
