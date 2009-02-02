#include <X11/Xlib.h>
#include <stdio.h>

int main(void)
{
    Display *dp;
    dp = XOpenDisplay(NULL);
    printf("Vendor %s\n", ServerVendor(dp));
    printf("Width %d\n", DisplayWidth(dp, 0));
    printf("Height %d\n", DisplayHeight(dp, 0));
    printf("WidthMM %d\n", DisplayWidthMM(dp, 0));
    printf("HeightMM %d\n", DisplayHeightMM(dp, 0));
    printf("DefaultScreen %d\n", DefaultScreen(dp));
    XCloseDisplay(dp);
    return 0;
}

