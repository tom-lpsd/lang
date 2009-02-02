#include <iostream>
using namespace std;

class Foo {
    double x;
public:
    static void *operator new(size_t size, int x) {
	cerr << "new" << x << " " << size << endl;
	return ::operator new(size);
    }
    static void operator delete(void *mem, size_t size) {
	cerr << "delete" << " " << size << endl;
	::operator delete(mem);
    }
};

class Bar {};

int main()
{
    Foo *foo = new(10) Foo;
    Bar *bar = new Bar;
    cerr << sizeof(Foo) << endl;
    cerr << sizeof(Bar) << endl;
    delete bar;
    delete foo;
    return 0;
}
