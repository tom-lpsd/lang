#include <iostream>
using namespace std;

class Foo {
public:
    void foo() {
	cout << "foo on foo" << endl;
    }
};

class Bar : public Foo {
public:
    using Foo::foo;
    void foo(int x) {
	cout << "foo on bar" << endl;
    }
};

int main()
{
    Bar bar;
    bar.foo();
    bar.foo(10);
    return 0;
}
