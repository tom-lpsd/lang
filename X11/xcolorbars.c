#include <stdio.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>

static char *colors[] = {
  "black","blue4","green4","cyan4","red4","magenta4","brown",
  "lightgray","gray","blue","green","cyan","red","magenta",
  "yellow","white",
  "gray0","gray6","gray12","gray18","gray24","gray30","gray36",
  "gray42","gray48","gray54","gray60","gray66","gray72",
  "gray78","gray84","gray90"
};

int width, height;
Display *disp;
Window win;
GC gc;

void event_loop(void)
{
  int i;
  XEvent ev;
  XColor def,closest;

  while(True){
    XNextEvent(disp,&ev);
    for(i=0;i<32;i++){
      XAllocNamedColor(disp,DefaultColormap(disp,0),
		       colors[i],&closest,&def);
      XSetForeground(disp,gc,closest.pixel);
      if(i<16) XFillRectangle(disp,win,gc,i*(width/16),0,width/16,height*2/3);
      else XFillRectangle(disp,win,gc,(i-16)*(width/16),height*2/3,width/16,height/3);
    }
  }
}

int main(void)
{
  disp = XOpenDisplay(NULL);
  win = XCreateSimpleWindow(disp,RootWindow(disp,0),0,0,
			    width=DisplayWidth(disp,0)/2,
			    height=DisplayHeight(disp,0)/2,1,0,0);
  gc = XCreateGC(disp,win,0,NULL);
  XSelectInput(disp,win,ExposureMask);
  XMapWindow(disp,win);
  event_loop();
}
