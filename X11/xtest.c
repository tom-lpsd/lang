#include <stdio.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>

int main(int argc, char *argv[])
{
  Display *disp;
  disp = XOpenDisplay(NULL);
  printf("%d\n",DefaultDepth(disp,0));
  XCloseDisplay(disp);
  return 0;
}
