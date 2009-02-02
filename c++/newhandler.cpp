#include <iostream>
#include <new>
using namespace std;

void my_handler()
{
    cerr << "My Handler!!" << endl;
    abort();
}

int main()
{
    set_new_handler(my_handler);
    int *foo = new int[1000000000];
    return 0;
}
