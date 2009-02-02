#include <stdio.h>

int main(void)
{
  int i,buf[1];
  int out[100];


  for(i=0;i<100;i++){
    fread(buf, 2, 1, stdin);
    out[i] = buf[0]>>16;
  }
  for(i=0;i<100;i++){
    printf("%d\n",out[i]);
  }
  return 0;
}
