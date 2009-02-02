#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>

int main(void)
{
  const char *font_name = "*helvetica-medium-r-normal*24*iso8859-1";
  XFontStruct *fst;
  XCharStruct cst;
  Display *disp;
  int width, height, asc, dsc, derc,mwidth;

  disp = XOpenDisplay(NULL);
  if((fst = XLoadQueryFont(disp, font_name)) == NULL){
    fprintf(stderr,"Error!\n");
    exit(1);
  }
  char a[] = "~";


/*   width = fst->per_char->width; */
/*   width =  XTextWidth(fst, a, strlen(a)); */
  XTextExtents(fst,a, strlen(a), &derc, &asc, &dsc, &cst);
  asc = fst->max_bounds.ascent;
  dsc = fst->max_bounds.descent;

  printf("asc = %d, des =  %d, width =  %d, lbe = %d, rbe = %d, mwidth = %d\n",asc, dsc, cst.width, cst.lbearing, cst.rbearing, cst.width);
  return 0;
}
