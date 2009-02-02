#include <iostream>
using namespace std;

template<typename T, typename G>
struct Foo {
    void foo();
};

template<typename T, typename G>
void Foo<T, G>::foo() { cout << "foo" << endl; }

template<typename T>
struct Foo<double, T> {
    void foo() { cout << "bar" << endl; }
};

template<>
void Foo<double, int>::foo() { cout << "baz" << endl; }

int main()
{
    Foo<double, int> f;
    f.foo();
    return 0;
}
