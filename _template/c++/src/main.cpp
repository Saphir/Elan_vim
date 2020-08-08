#include <cstdlib>  /* exit system malloc atoi rand */
#include <iostream> /* std::cout std::endl */
#include <cstdio>   /* fopen fgets printf */
#include <unistd.h> /* read sleep NULL close */

int main(int argc, char * argv[]) {
#ifndef NDEBUG
    std::cout << "[MAIN] argc: " << argc << std::endl;
    std::cout << "[MAIN] argv: ";
    for (std::int32_t i {0}; i < argc; ++i) {
        std::cout << argv[i];
        if (i == argc - 1) {
            std::cout << std::endl;
        } else {
            std::cout << " ";
        }
    }
#endif
    std::endl(std::cout << "Hello World!");

    std::endl(std::cout << "MAIN exit");
    // exit(EXIT_FAILURE);
    return EXIT_SUCCESS;
}

