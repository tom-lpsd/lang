#include <stdio.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>

int main(int argc, char *argv[])
{
  Display *disp;
  Window win;

  disp = XOpenDisplay(NULL);
  win = XCreateSimpleWindow(disp, RootWindow(disp,0),
			    0,0,400,300,100,BlackPixel(disp,0),WhitePixel(disp,0));
  XStoreName(disp,win,argv[0]);
  XMapWindow(disp,win);
  XMapWindow(disp,XCreateSimpleWindow(disp, win,
				      50,100,100,100,10,BlackPixel(disp,0),WhitePixel(disp,0)));
  XMapWindow(disp,XCreateSimpleWindow(disp, win,
				      250,100,100,100,1,BlackPixel(disp,0),WhitePixel(disp,0)));
  XFlush(disp);
  printf("%d %d\n", DisplayHeightMM(disp,0), DisplayWidthMM(disp,0));
  while('\n' != getchar());
  return 0;
}
