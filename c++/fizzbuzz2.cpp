#include <iostream>

enum FizzBuzz {Fizz = 0, Buzz};
const static char *fizzbuzz[] = {"Fizz", "Buzz"};

template<bool T, FizzBuzz I>
struct Print {
    Print () { std::cout << fizzbuzz[I]; }
};

template<FizzBuzz I>
struct Print<false, I> { };

template<bool T, int N>
struct Terminate {
    Terminate () { std::cout << std::endl; }
};

template<int N>
struct Terminate<false, N> {
    Terminate () { std::cout << N << std::endl; }
};

template<int N, int M>
struct RunFizzBuzz {
    RunFizzBuzz () {
	const static bool fizz = N % 3 == 0, buzz = N % 5 == 0;
	Print<fizz, Fizz>(); 
	Print<buzz, Buzz>();
	Terminate<fizz || buzz, N>();
	RunFizzBuzz<N+1, M>();
    }
};

template<int N>
struct RunFizzBuzz<N, N> { };

int main()
{
    RunFizzBuzz<1, 101>();
    return 0;
}

