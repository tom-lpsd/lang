#include <complex.h>
#include <stdio.h>

int main(void)
{
  complex x = 1.0+2.0I;
  complex y = 2.0+4.0I;
  complex z;
  z = conj(x);
  printf("%f %f\n",cabs(z),cimag(z));
  return 0;
}
