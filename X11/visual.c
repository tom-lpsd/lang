#include <stdio.h>
#include <stdlib.h>
#include <X11/Xlib.h>

int main(void)
{
  Display *disp = XOpenDisplay("localhost:0.0");
  if(disp==NULL) printf("No!!\n"), exit(1);
  Visual *a = DefaultVisual(disp,0);
  printf("%d\n",a->class);
  printf("%d\n",TrueColor);
  printf("%d\n",DirectColor);
  return 0;
}
