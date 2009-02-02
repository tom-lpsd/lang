#include <iostream>
using namespace std;

template<typename T, int I, int J>
class Swap {
public:
  static void compareAndSwap(T* data) {
    if (data[I] > data[J])
      std::swap(data[I], data[J]);
  }
};

template<typename T, int I, int J>
class BubbleSortLoop {
private:
  static const bool go = (J <= I-2);
public:
  static void loop(T* data) {
    Swap<T,J,J+1>::compareAndSwap(data);
    BubbleSortLoop<T, go ? I : 0, go ? (J+1) : 0>::loop(data);
  }
};

template<typename T>
class BubbleSortLoop<T,0,0> {
public:
  static void loop(T*) { }
};

template<typename T, int N>
class BubbleSort {
public:
  static void sort(T *data) {
    BubbleSortLoop<T, N-1,0>::loop(data);
    BubbleSort<T, N-1>::sort(data);
  }
};

template<typename T>
class BubbleSort<T,1> {
public:
  static void sort(T *data) { }
};

int main()
{
  double data[] = {1.4, 3.2, -2.9, -5.0, 10.1, 5.4, 12.4, 20.2};
  BubbleSort<double, sizeof(data)/sizeof(double)>::sort(data);
  for(unsigned i=0;i<sizeof(data)/sizeof(double);i++){
    cout << data[i] << "\n";
  }
  return 0;
}
