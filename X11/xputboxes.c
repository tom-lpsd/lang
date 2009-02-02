#include <stdio.h>
#include <stdlib.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>

int main(int argc, char *argv[])
{
  Display *disp;
  Window win;

  disp = XOpenDisplay(NULL);
  win = XCreateSimpleWindow(disp, RootWindow(disp,0),
			    0,0,400,300,100,BlackPixel(disp,0),WhitePixel(disp,0));
  XSelectInput(disp,win,ButtonPressMask);
  XStoreName(disp,win,argv[0]);
  XMapWindow(disp,win);
  while(True){
    XEvent ev;
    XNextEvent(disp,&ev);
    if(Button3 == ev.xbutton.button) exit(1);
    XDrawRectangle(disp, win, DefaultGC(disp,0),ev.xbutton.x,ev.xbutton.y,10,10);
  }
  return 0;
}
