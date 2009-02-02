#include <stdio.h>
#include <stdlib.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>

Display *disp;
Window win;
int width = 200, height = 200;

void rect_fill(int offset){
  XClearWindow(disp,win);
  XFillRectangle(disp,win,DefaultGC(disp,0),offset,0,width,height);
}

int main(int argc, char *argv[])
{
  disp = XOpenDisplay(NULL);
  win = XCreateSimpleWindow(disp, RootWindow(disp,0),
			    0,0,2*width,height,1,BlackPixel(disp,0),WhitePixel(disp,0));
  XSelectInput(disp,win,ButtonPressMask | LeaveWindowMask | EnterWindowMask | PointerMotionMask);
  XStoreName(disp,win,argv[0]);
  XMapWindow(disp,win);
  while(True){
    int is_left;
    XEvent ev;

    XNextEvent(disp,&ev);
    switch(ev.type){
    case EnterNotify:
      rect_fill((is_left=(ev.xcrossing.x < width)) ? 0:width);
      break;
    case LeaveNotify:
      XClearWindow(disp,win);
      break;
    case MotionNotify:
      if(ev.xmotion.x < width && !is_left){
	rect_fill(0);
	is_left = True;
      }else if(ev.xmotion.x > width && is_left){
	rect_fill(width);
	is_left = False;
      }
      break;
    case ButtonPress:
      exit(1);
    }
  }
  return 0;
}
