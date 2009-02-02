#include "static_check.hpp"

int main()
{
  STATIC_CHECK(sizeof(int) > sizeof(double) , 
	       sizeof_int_is_not_larger_than_sizeof_double);
  return 0;
}
