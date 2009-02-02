#include <stdio.h>
#include <stdlib.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>

int main(int argc, char *argv[])
{
  Display *disp;
  Window win, left_win, right_win;
  int width = 200, height = 200;
  unsigned long white,black;

  disp = XOpenDisplay(NULL);
  white = WhitePixel(disp,0);
  black = BlackPixel(disp,0);
  win = XCreateSimpleWindow(disp, RootWindow(disp,0),
			    0,0,2*width,height,1,black,white);
  left_win = XCreateSimpleWindow(disp, win,
			    0,0,width,height,1,black,white);
  right_win = XCreateSimpleWindow(disp, win,
			    width,0,width,height,1,black,white);
  XSelectInput(disp,win,ButtonPressMask);
  XSelectInput(disp,left_win,EnterWindowMask | LeaveWindowMask);
  XSelectInput(disp,right_win,EnterWindowMask | LeaveWindowMask);

  XStoreName(disp,win,argv[0]);
  XMapWindow(disp,win);
  XMapWindow(disp,left_win);
  XMapWindow(disp,right_win);
  while(True){
    XEvent ev;

    XNextEvent(disp,&ev);
    switch(ev.type){
    case EnterNotify:
      XFillRectangle(disp,ev.xcrossing.window,DefaultGC(disp,0),0,0,width,height);
      break;
    case LeaveNotify:
      XClearWindow(disp,ev.xcrossing.window);
      break;
    case ButtonPress:
      exit(1);
    }
  }
  return 0;
}
