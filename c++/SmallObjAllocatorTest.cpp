#include "Benchmarker.hpp"
#define LOKI_DEFAULT_CHUNK_SIZE 0
#include "loki/SmallObj.h"
using namespace Loki;

class A : public SmallObject <>{
  int x;
};

int main()
{
  const int num = 10000000;
  A *a;

  Benchmarker bm("small object allocator:");
  for(int i=0;i<num;i++){
    a = new A;
    delete a;
  }

  return 0;
}
