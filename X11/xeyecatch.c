#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>

#define MERGIN 5

char *fontname="-adobe-helvetica-bold-r-*-*-34-*-*-*-*-*-*-*";
/* char *fontname = "fixed"; */
char *text="Welcome , Brother!";

Display *disp;
Colormap cmap;
XColor *colors;
int ncolors = 100;

void mainloop(void)
{
  int i,val;
  while(True){
    val = colors[0].pixel;
    for(i=0;i<ncolors-1;i++)
      colors[i].pixel = colors[i+1].pixel;
    colors[ncolors-1].pixel = val;
    XStoreColors(disp,cmap,colors,ncolors);
  }
}

void get_args(int argc,char *argv[])
{
  int i;

  for(i=0;i<argc;){
    if(!strcmp("-fn",argv[i])){ /* フォントの変更 */
      fontname = (char *)malloc(strlen(argv[i+1])+1);
      strcpy(fontname,argv[i+1]);
      i += 2;
    }else if(!strcmp("-ncolors",argv[i])){
      ncolors = atoi(argv[i+1]); /* カラー数変更 */
      i += 2;
    }else{
      text = (char *)malloc(strlen(argv[i])+1);
      strcpy(text,argv[i]); /* 表示するテキスト変更 */
      i++;
    }
  }
}

int main(int argc, char *argv[])
{
  Window win,rootwin;
  int screen;
  GC gc;
  XFontStruct *font_info;
  XImage *ximage;
  Pixmap pixmap;
  int i,font_ascent,font_height,text_width,width,height;
  unsigned char *image;
  unsigned long plane_mask[1],*pixels;
  double th;

  get_args(argc-1,argv+1);  /* 引数処理 */

  colors = (XColor *)malloc(sizeof(XColor)*ncolors);
  pixels = (unsigned long *)malloc(sizeof(unsigned long)*ncolors);

  disp = XOpenDisplay(NULL);
  screen = DefaultScreen(disp);
  rootwin = RootWindow(disp,screen);
  gc = XCreateGC(disp,rootwin,0,NULL);
  cmap = DefaultColormap(disp,screen);

  font_info = XLoadQueryFont(disp,fontname);
  font_ascent = font_info->max_bounds.ascent;
  font_height = font_ascent + font_info->max_bounds.descent;
  text_width = XTextWidth(font_info,text,strlen(text));
  XSetFont(disp,gc,font_info->fid);
  width = 2*MERGIN+text_width;
  width = (1+width/ncolors)*ncolors;
  height = 2*MERGIN+font_height;
  win = XCreateSimpleWindow(disp,rootwin,0,0,width,height,1,0,0);

  XAllocColorCells(disp,cmap,False,plane_mask,0,pixels,ncolors);
  for(i=0;i<ncolors;i++){
    th = 2.0 * M_PI * i /ncolors;
    colors[i].flags = DoRed | DoGreen | DoBlue;
    colors[i].pixel = pixels[i];
    colors[i].red = 65535*(cos(th)+2)/3;
    colors[i].green = 65535*(cos(th+2.0*M_PI/3)+2)/3;
    colors[i].blue = 65535*(cos(th+4.0*M_PI/3)+2)/3;
  }

  image = (unsigned char *)malloc(width*height);
  for(i=0;i<width*height;i++)
    image[i] = colors[(i%width)/(width/ncolors)].pixel;
  pixmap = XCreatePixmap(disp,win,width,height,DefaultDepth(disp,screen));
  XPutImage(disp,pixmap,gc,
	    XCreateImage(disp,DefaultVisual(disp,screen),
			 DefaultDepth(disp,screen),ZPixmap,0,image,width,height,8,0),
	    0,0,0,0,width,height);
  XSetForeground(disp,gc,BlackPixel(disp,screen));
  XDrawString(disp,pixmap,gc,(width-text_width)/2,MERGIN+font_ascent,text,strlen(text));
  XSetWindowBackgroundPixmap(disp,win,pixmap);
  XMapWindow(disp,win);
  mainloop();
}
