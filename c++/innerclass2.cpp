#include <iostream>
using namespace std;

class Foo {
    class Bar {
	int i;
    public:
	Bar() : i(0) {}
	Bar &inc() { ++i; return *this; }
	friend ostream &operator<<(ostream&, Bar&);
    };
    Bar b;
public:
    Bar &bar() {
	return b;
    }
    friend ostream &operator<<(ostream&, Bar&);
};

ostream &operator << (ostream &os, Foo::Bar &b)
{
    os << b.i;
    return os;
}

int main() 
{
    Foo f;
    f.bar().inc().inc().inc();
    cout << f.bar() << endl;
    return 0;
}
