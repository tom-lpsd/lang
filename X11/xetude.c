#include <stdio.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>

int main(void)
{
  Display *disp;
  Window win;

  disp = XOpenDisplay(NULL);
  win = XCreateSimpleWindow(disp, RootWindow(disp,0),
			    0,0,400,300,100,BlackPixel(disp,0),WhitePixel(disp,0));
  XMapWindow(disp,win);
  XFlush(disp);
  while(True);
  return 0;
}
