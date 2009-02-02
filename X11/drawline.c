#include <X11/Xlib.h>

int main(void)
{
    Display *dp;
    Window w;
    XSetWindowAttributes attr;
    GC gc;
    XGCValues gv;
    unsigned int black, white;

    dp = XOpenDisplay(NULL);
    black = BlackPixel(dp, 0);
    white = WhitePixel(dp, 0);
    w = XCreateSimpleWindow(dp, RootWindow(dp, 0), 20, 20, 500, 400, 2, black, white);
    attr.override_redirect = True;
    XChangeWindowAttributes(dp, w, CWOverrideRedirect, &attr);
    XMapWindow(dp, w);

    gv.line_width = 10;
    gc = XCreateGC(dp, w, GCLineWidth, &gv);

    XDrawLine(dp, w, gc, 50, 200, 450, 200);
    XFlush(dp);

    getchar();

    return 0;
}
