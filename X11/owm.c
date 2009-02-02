#include <stdio.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/cursorfont.h>
#include <X11/Xatom.h>
#include "onsen"

#define NaN -32768

Display *disp;
GC gc;
Window root;

struct {
  Window win;
  int button;
  int x,y;
  int wx,wy,ww,wh;
} pre;

XWindowAttributes wa;
XSetWindowAttributes swa;

void reparent_win(Window win,Bool new_flag)
{
  Window frame;
  XSizeHints hints;

  XGetWindowAttributes(disp,win,&wa);
  if(new_flag && XGetSizeHints(disp,win,&hints,XA_WM_SIZE_HINTS)){
    if((USSize | PSize) & hints.flags) XResizeWindow(disp,win,wa.width=hints.width,wa.height=hints.height);
    if((USPosition | PPosition) & hints.flags) wa.x = hints.x,wa.y=hints.y;
  }
  frame = XCreateWindow(disp,root,wa.x,wa.y,wa.width+2,wa.height+onsen_height+1,0,
			CopyFromParent,InputOutput,CopyFromParent,
			CWBackPixmap | CWEventMask | CWCursor,&swa);
  XSetWindowBorderWidth(disp,win,0);
  XChangeWindowAttributes(disp,win,CWDontPropagate,&swa);
  XReparentWindow(disp,win,frame,1,onsen_height);
  XMapWindow(disp,frame);
  XMapWindow(disp,win);
  XAddToSaveSet(disp,win);
}

void reparent_toplevels(void)
{
  Window parent, *children;
  unsigned nchildren,i;
  
  XQueryTree(disp,root,&root,&parent,&children,&nchildren);
  for(i=0;i<nchildren;i++){
    XGetWindowAttributes(disp,children[i],&wa);
    if(wa.map_state == IsUnmapped) continue;
    reparent_win(children[i],False);
  }
  XFree(children);
}

void handle_configure_request(XConfigureRequestEvent xcr)
{
  XWindowChanges wc;

  wc.x = xcr.x -1;
  wc.y = xcr.y+onsen_height;
  wc.height = xcr.height + onsen_height + 1;
  wc.sibling = wc.stack_mode = TopIf;
  XConfigureWindow(disp,xcr.parent,xcr.value_mask,&wc);
  XResizeWindow(disp,xcr.window,xcr.width,xcr.height);
}

void handle_button_press(XButtonEvent xb)
{
  pre.button = xb.button;
  pre.x = xb.x;
  pre.y = xb.y;
  pre.wx = pre.ww = NaN;
  XGetWindowAttributes(disp,pre.win = xb.window,&wa);
}

void handle_button_release(XButtonEvent xb)
{
  Window parent,*children;
  unsigned nchildren;
  int width,height;

  if(pre.win == None) return;
  XQueryTree(disp,pre.win,&root,&parent,&children,&nchildren);
  switch(pre.button){
  case Button1:
    XDrawRectangle(disp,root,gc,pre.wx,pre.wy,wa.width,wa.height);
    XMoveWindow(disp,pre.win,xb.x_root - pre.x,xb.y_root - pre.y);
    XMoveWindow(disp,*children,2,onsen_height);
    XMoveWindow(disp,*children,1,onsen_height);
    break;
  case Button2:
    if(onsen_width == wa.width && onsen_height == wa.height){
      XGetWindowAttributes(disp,*children,&wa);
      XResizeWindow(disp,pre.win,wa.width+2,wa.height+onsen_height+1);
    }else{
      XMoveResizeWindow(disp,pre.win,((wa.x < 0)? 0:wa.x),((wa.y < 0) ? 0:wa.y),onsen_width,onsen_height);
    }
    break;
  case Button3:
    XDrawRectangle(disp,root,gc,wa.x,wa.y,pre.ww,pre.wh);
    width = xb.x_root - wa.x;
    height = xb.y_root-wa.y;
    if(width<3 || height < onsen_height+2) break;
    XResizeWindow(disp,pre.win,width,height);
    XResizeWindow(disp,*children,width-2,height-onsen_height-1);
    break;
  }
  XRaiseWindow(disp,pre.win);
  XFree(children);
  pre.win = None;
}

void handle_motion_notify(XMotionEvent xm)
{
  if(pre.win == None) return;
  switch(xm.state){
  case Button1Mask:
    if(pre.wx != NaN)
      XDrawRectangle(disp,root,gc,pre.wx,pre.wy,wa.width,wa.height);
    XDrawRectangle(disp,root,gc,pre.wx=xm.x_root-pre.x,pre.wy=xm.y_root-pre.y,wa.width,wa.height);
    return;
  case Button2Mask:
    return;
  case Button3Mask:
    if(pre.ww != NaN)
      XDrawRectangle(disp,root,gc,wa.x,wa.y,pre.ww,pre.wh);
    pre.ww = xm.x_root - pre.x;
    pre.wy = xm.y_root - pre.y;
    if(pre.ww < 0) pre.ww = 0;
    if(pre.ww < 0) pre.wh = 0;
    XDrawRectangle(disp,root,gc,wa.x,wa.y,pre.ww,pre.wh);
    return;
  }
}

void event_proc(void)
{
  XEvent ev;
  
  XNextEvent(disp,&ev);
  switch(ev.type){
  case MapRequest:
    reparent_win(ev.xmaprequest.window,True); break;
  case ConfigureRequest:
    handle_configure_request(ev.xconfigurerequest); break;
  case ButtonPress:
    handle_button_press(ev.xbutton); break;
  case ButtonRelease:
    handle_button_release(ev.xbutton); break;
  case MotionNotify:
    handle_motion_notify(ev.xmotion); break;
  case MapNotify:
    XMapWindow(disp,ev.xmap.event); break;
  case UnmapNotify:
    XUnmapWindow(disp,ev.xunmap.event); break;
  case DestroyNotify:
    XDestroyWindow(disp,ev.xdestroywindow.event); break;
  }
}

int main(void)
{
  XGCValues xgcv;

  disp = XOpenDisplay(NULL);
  root = RootWindow(disp,0);
  xgcv.foreground = 0xffffffff;
  xgcv.subwindow_mode = IncludeInferiors;
  xgcv.function = GXxor;
  gc = XCreateGC(disp,root,GCForeground | GCSubwindowMode | GCFunction, &xgcv);
  swa.background_pixmap = XCreatePixmapFromBitmapData(disp,root,onsen_bits,onsen_width,onsen_height,
						      BlackPixel(disp,0),WhitePixel(disp,0),DefaultDepth(disp,0));
  swa.event_mask = ButtonPressMask | ButtonReleaseMask | PointerMotionMask | SubstructureNotifyMask | SubstructureRedirectMask;
  swa.cursor = XCreateFontCursor(disp,XC_gumby);
  swa.do_not_propagate_mask = ButtonPressMask | ButtonReleaseMask | PointerMotionMask;
  XSelectInput(disp,root,SubstructureRedirectMask);
  reparent_toplevels();
  while(True) event_proc();
  return 0;
}
