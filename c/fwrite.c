#include <stdio.h>

int main(void)
{
  int i = 16;
  i=i<<16;
  fwrite(&i, 2, 1, stdout);
  return 0;
}
