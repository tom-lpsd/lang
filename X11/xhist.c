#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>

#define SIZE 256

Display *disp;
Window win;
int height = SIZE;
unsigned long hist[SIZE], maxval = 1;
double ratio;

void get_args(int argc,char *argv[])
{
  int i,c;
  for(i=0;i<argc;){
    if(strcmp("-h",argv[i])==0){
      height = atoi(argv[i+1]);
      i+=2;
    }
    else i++;
  }
  while((c=getchar()) != EOF){
    hist[c]++;
    if(maxval < hist[c]) maxval = hist[c];
  }
}

void repaint_proc(double t)
{
  int i;
  XClearWindow(disp,win);
  ratio *= t;
  for(i=0;i<SIZE;i++){
    XDrawLine(disp,win,DefaultGC(disp,0),i,height,i,(int)(height-hist[i]*ratio));
  }
  fprintf(stderr,"height %d\n",(int)(height/ratio));
}

void event_proc(void)
{
  XEvent ev;
  XNextEvent(disp,&ev);
  switch(ev.type){
  case ButtonPress:
    switch(ev.xbutton.button){
    case Button1:repaint_proc(1.25); break;
    case Button2:repaint_proc(0.8); break;
    case Button3:fprintf(stderr,"%d\n",ev.xbutton.x);
    }
  case Expose: repaint_proc(1.0);
  }
}

int main(int argc, char *argv[])
{
  get_args(argc-1, argv+1);
  ratio = (double)height/maxval;
  disp = XOpenDisplay(NULL);
  win = XCreateSimpleWindow(disp,RootWindow(disp,0),0,0,SIZE,height,1,0,WhitePixel(disp,0));
  XSelectInput(disp,win,ButtonPressMask | ExposureMask);
  XMapWindow(disp,win);
  while(True) event_proc();
  return 0;
}
