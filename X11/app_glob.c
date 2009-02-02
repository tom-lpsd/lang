#ifndef APP_GLOB_C
#define APP_GLOB_C

#ifdef DEF_APP_GLOB

Display *the Display;
GC theGC;
int AppDone = 0;
XEvent theEvent;
XFontStruct *theFontStruct;
unsigned long theBGpix, theFGpix;
char *theAppName = " ";
Window thaMain;
XWindowAttributes MainXWA;

#else

extern Display *theDisplay;
extern GC theGC;
extern int AppDone;
extern XEvent theEvent;
extern XFontStruct *theFontStruct;
extern unsigned long theBGpix,theFGpix;
extern char *theAppName;
extern Window thaMain;
extern XWindowAttributes MainXWA;

#endif /* DEF_APP_GLOB */
#endif /* APP_GLOB_C */
