#include <iostream>
using namespace std;

template<bool T>
struct Fizz {
    Fizz () { cout << "Fizz"; }
};

template<>
struct Fizz<false> { };

template<bool T>
struct Buzz {
    Buzz () { cout << "Buzz"; }
};

template<>
struct Buzz<false> { };

template<bool T, int N>
struct Terminate {
    Terminate () { cout << endl; }
};

template<int N>
struct Terminate<false, N> {
    Terminate () { cout << N << endl; }
};

template<int N>
struct FizzBuzz {
    FizzBuzz () {
	const static bool 
	    fizz = N % 3 == 0,
	    buzz = N % 5 == 0;
	Fizz<fizz>(); 
	Buzz<buzz>();
	Terminate<fizz || buzz, N>();
	FizzBuzz<N+1>();
    }
};

template<>
struct FizzBuzz<101> { };

int main()
{
    FizzBuzz<1>();
    return 0;
}

