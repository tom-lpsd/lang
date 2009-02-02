#include <X11/Xlib.h>
#include <stdio.h>

int main(void)
{
    Display *dp = XOpenDisplay(NULL);
    Window w = XCreateSimpleWindow(dp, DefaultRootWindow(dp),
	    50, 50, 400, 300, 2, BlackPixel(dp, 0), WhitePixel(dp, 0));
    XMapWindow(dp, w);
    XFlush(dp);
    getchar();
    XCloseDisplay(dp);
    return 0;
}
