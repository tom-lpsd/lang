#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>

#define max(x,y) (((x) > (y)) ? (x) : (y))
#define DEFAULT_MAIN_TEXT "This is test."
#define DEFAULT_EXIT_TEXT "Exit"
#define DEFAULT_BGCOLOR "white"
#define DEFAULT_FGCOLOR "black"
#define DEFAULT_BDWIDTH 1
#define DEFAULT_FONT "8x16"

typedef struct XHELLO_PARAMS
{
  char *name;
  char **p_value_string;
} XHELLO_PARAMS;

/* リソース情報のデフォルト値を設定 */
char *mbgcolor = DEFAULT_BGCOLOR,
  *mfgcolor = DEFAULT_FGCOLOR,
  *mfont = DEFAULT_FONT,
  *ebgcolor = DEFAULT_BGCOLOR,
  *efgcolor = DEFAULT_FGCOLOR,
  *efont = DEFAULT_FONT,
  *mgeom_rsrc = NULL,
  *mtext_rsrc = NULL,
  *etext_rsrc = NULL,
  *display_name = NULL,
  *mtext_cline = NULL,
  *etext_cline = NULL,
  *mgeom_cline = NULL,
  *mtext = DEFAULT_MAIN_TEXT,
  *etext = DEFAULT_EXIT_TEXT,
  *mgeom = NULL;

/* リソース情報を格納する構造体配列 */
XHELLO_PARAMS resources[] = {
  {"background", &mbgcolor},
  {"foreground", &mfgcolor},
  {"font", &mfont},
  {"geometry", &mgeom_rsrc},
  {"text", &mtext_rsrc},
  {"exit.background", &ebgcolor},
  {"exit.foreground", &efgcolor},
  {"exit.font", &efont},
  {"exit.text", &etext_rsrc}
};

int num_resources = sizeof(resources)/sizeof(XHELLO_PARAMS);

/* コマンドラインから受け付けるパラメータを格納する構造体配列 */
XHELLO_PARAMS options[] = {
  {"-display", &display_name},
  {"-d", &display_name},
  {"-geometry", &mgeom_cline},
  {"-g", &mgeom_cline},
  {"-mtext", &mtext_cline},
  {"-m", &mtext_cline},
  {"-etext", &etext_cline},
  {"-e", &etext_cline}
};

int num_options = sizeof(options)/sizeof(XHELLO_PARAMS);

char *app_name = "xhello";

XFontStruct *mfontstruct, *efontstruct;
unsigned long mbgpix, mfgpix, ebgpix, efgpix;

unsigned int ewidth, eheight;
int ex,ey,extxt,eytxt;

XWMHints xwmh;
XSizeHints xsh;
Display *p_disp;
Window Main, Exit;
GC theGC, exitGC;
XEvent theEvent;
int Done = 0;
char default_geometry[80];
void usage(void);

int main(int argc, char *argv[])
{
  int i,j;
  char *tmpstr;
  Colormap default_cmap;
  XColor color;
  int bitmask;
  XGCValues gcv;
  XSetWindowAttributes xswa;
  app_name = argv[0];

  /* コマンドライン引数の処理 */
  for(i=1;i<argc;i+=2){
    for(j=0;j<num_options;j++){
      if(strcmp(options[j].name, argv[i]) == 0){
	*options[j].p_value_string = argv[i+1];
	break;
      }
    }
    if(j >= num_options)
      usage();
  }

  /* ディスプレイにつなぐ */
  if((p_disp = XOpenDisplay(display_name)) == NULL){
    fprintf(stderr, "%s: can't open display named %s\n", argv[0], XDisplayName(display_name));
    exit(1);
  }

  /* デフォルトのリソースを取得 */
  for(i=0;i<num_resources;i++){
    if((tmpstr = XGetDefault(p_disp, app_name, resources[i].name)) != NULL)
      *resources[i].p_value_string = tmpstr;
  }

  /* フォント情報を取得 */
  if((mfontstruct = XLoadQueryFont(p_disp, mfont)) == NULL){
    fprintf(stderr, "%s: display %s cannot load font %s\n", app_name, DisplayString(p_disp), mfont);
    exit(1);
  }

  if((efontstruct = XLoadQueryFont(p_disp, efont)) == NULL){
    fprintf(stderr, "%s: display %s cannot load font %s\n", app_name, DisplayString(p_disp), efont);
    exit(1);
  }

  
  /* カラーマップの設定 */
  default_cmap = DefaultColormap(p_disp, DefaultScreen(p_disp));

  if(XParseColor(p_disp, default_cmap, mbgcolor, &color) == 0 || XAllocColor(p_disp, default_cmap, &color) == 0)
    mbgpix = WhitePixel(p_disp, DefaultScreen(p_disp));
  else
    mbgpix = color.pixel;

  if(XParseColor(p_disp, default_cmap, mfgcolor, &color) == 0 || XAllocColor(p_disp, default_cmap, &color) == 0)
    mfgpix = WhitePixel(p_disp, DefaultScreen(p_disp));
  else
    mfgpix = color.pixel;

  if(XParseColor(p_disp, default_cmap, ebgcolor, &color) == 0 || XAllocColor(p_disp, default_cmap, &color) == 0)
    ebgpix = WhitePixel(p_disp, DefaultScreen(p_disp));
  else
    ebgpix = color.pixel;

  if(XParseColor(p_disp, default_cmap, efgcolor, &color) == 0 || XAllocColor(p_disp, default_cmap, &color) == 0)
    efgpix = WhitePixel(p_disp, DefaultScreen(p_disp));
  else
    efgpix = color.pixel;


  /* 表示するテキストを場合に応じて変更 */
  if(etext_cline != NULL) etext = etext_cline;
  else
    if(etext_rsrc != NULL) etext = etext_rsrc;

  if(mtext_cline != NULL) mtext = mtext_cline;
  else
    if(mtext_rsrc != NULL) mtext = mtext_rsrc;

  /* Exitボタンのテキスト幅等を取得し，ウィンドウの大きさを決定する */
  extxt = efontstruct->max_bounds.width / 2;
  eytxt = efontstruct->max_bounds.ascent +
    efontstruct->max_bounds.descent;
  ewidth = extxt + XTextWidth(efontstruct, etext, strlen(etext)) +4;
  eheight = eytxt + 4;

  /* メインウィンドウの大きさを決定し，XSizeHints構造体に入れておく */
  xsh.flags = (PPosition |PSize | PMinSize);
  xsh.height = mfontstruct->max_bounds.ascent +
    mfontstruct->max_bounds.descent + eheight + 10;
  xsh.min_height = xsh.height;
  xsh.width = XTextWidth(mfontstruct, mtext, strlen(mtext)) + 2;
  xsh.width = max(xsh.width, ewidth);
  xsh.min_width = xsh.width;
  xsh.x = (DisplayWidth(p_disp, DefaultScreen(p_disp)) - xsh.width) / 2;
  xsh.y = (DisplayHeight(p_disp, DefaultScreen(p_disp)) - xsh.height) / 2;

  /* ジオメトリ文字列をつくる */
  sprintf(default_geometry, "%dx%d+%d+%d", xsh.width, xsh.height, xsh.x, xsh.y);
  mgeom = default_geometry;

  /* リソース値，コマンドラインからの指定値があれば上書きする */
  if(mgeom_cline != NULL) mgeom = mgeom_cline;
  else
    if(mgeom_rsrc != NULL) mgeom = mgeom_rsrc;

  bitmask = XGeometry(p_disp, DefaultScreen(p_disp), mgeom, default_geometry, DEFAULT_BDWIDTH,
		      mfontstruct->max_bounds.width,
		      mfontstruct->max_bounds.ascent +
		      mfontstruct->max_bounds.descent,
		      1, 1, &(xsh.x), &(xsh.y),
		      &(xsh.width), &(xsh.height));
  if(bitmask & (XValue | YValue)) xsh.flags |= USPosition;
  if(bitmask & (WidthValue | HeightValue)) xsh.flags |= USSize;

  /* メインウィンドウを生成 */
  Main = XCreateSimpleWindow(p_disp, DefaultRootWindow(p_disp), xsh.x, xsh.y, xsh.width, xsh.height, DEFAULT_BDWIDTH, mfgpix, mbgpix);

  /* 作ったウィンドウの情報をウィンドウマネージャに通知する */
  XSetStandardProperties(p_disp, Main, app_name, app_name, None, argv, argc, &xsh);

  /* その他の必要な情報をウィンドウマネージャに通知する */
  xwmh.flags = (InputHint | StateHint);
  xwmh.input = False;
  xwmh.initial_state = NormalState;
  XSetWMHints(p_disp, Main, &xwmh);

  /* グラフィックコンテキストを生成 */
  gcv.font = mfontstruct->fid;
  gcv.foreground = mfgpix;
  gcv.background = mbgpix;
  theGC = XCreateGC(p_disp, Main, (GCFont | GCForeground | GCBackground), &gcv);
  
  xswa.colormap = DefaultColormap(p_disp, DefaultScreen(p_disp));
  xswa.bit_gravity = CenterGravity;
  XChangeWindowAttributes(p_disp, Main, (CWColormap | CWBitGravity), &xswa);

  /* 受け付けるイベントの指定 */
  XSelectInput(p_disp, Main, ExposureMask);

  /* メインウィンドウを表示 */
  XMapWindow(p_disp, Main);

  /* 子ウィンドウの生成 */
  ex = 1;
  ey = 1;

  Exit = XCreateSimpleWindow(p_disp, Main, ex, ey, ewidth, eheight, DEFAULT_BDWIDTH, efgpix, ebgpix);
  
  XSelectInput(p_disp, Exit, ExposureMask | ButtonPressMask);

  XMapWindow(p_disp, Exit);

  gcv.font = efontstruct->fid;
  gcv.foreground = efgpix;
  gcv.background = ebgpix;
  exitGC = XCreateGC(p_disp, Exit, (GCFont | GCForeground | GCBackground), &gcv);

  /* イベントループ */
  while(!Done){
    XNextEvent(p_disp, &theEvent);
    
    if(theEvent.xany.window == Main){
      if(theEvent.type == Expose && theEvent.xexpose.count == 0){
	int x,y,itemp;
	unsigned int width, height, utemp;
	Window wtemp;

	if(XGetGeometry(p_disp, Main, &wtemp, &itemp, &itemp, &width, &height, &utemp, &utemp) == 0)
	  break;
	
	x = (width - XTextWidth(mfontstruct, mtext, strlen(mtext))) / 2;
	y = eheight + (height - eheight +
		       mfontstruct->max_bounds.ascent -
		       mfontstruct->max_bounds.descent) / 2;
	XClearWindow(p_disp, Main);
	XDrawString(p_disp, Main, theGC, x, y, mtext, strlen(mtext));
      }
    }
    if(theEvent.xany.window == Exit){
      switch(theEvent.type){
      case Expose :
	if(theEvent.xexpose.count == 0){
	  XClearWindow(p_disp, Exit);
	  XDrawString(p_disp, Exit, exitGC, extxt, eytxt, etext, strlen(etext));
	}
	break;
      case ButtonPress:
	Done = 1;
      }
    }
  }

  /* 作成したウィンドウの後始末 */
  XFreeGC(p_disp, theGC);
  XFreeGC(p_disp, exitGC);
  XDestroyWindow(p_disp, Main);
  XCloseDisplay(p_disp);

  return 0;
}

/* ヘルプ表示関数 */
void usage(void)
{
  fprintf(stderr, "usage: %s [-display host:display] \
[-geometry geom] [-mtext text], [-etext text]\n", app_name);
  exit(1);
}
