#include <stdio.h>
#include <string.h>
#include "xwins.h"
#include "app_glob.c"

typedef struct D_BUTTON
{
  char *label;
  int (*action)(caddr_t);
  caddr_t action_args;
} D_BUTTON;

static int button_handler(XWIN *);

XWIN *MakeXButton(int x, int y,
		  unsigned width, unsigned height, unsigned bdwidth,
		  unsigned long bdcolor, unsigned long bgcolor,
		  Window parent, char *label, int (*button_action)(),
		  caddr_t action_data)
{
  XWIN *new_button;
  D_BUTTON *p_data;
  
  if((p_data = (D_BUTTON *)calloc(1,sizeof(D_BUTTON))) == NULL){
    fprintf(stderr, "No memory for button's data");
    exit(1);
  }

  if((new_button = (XWIN *)calloc(1,sizeof(XWIN))) == NULL){
    fprintf(stderr, "No memory for button");
    exit(1);
  }

  p_data->action = button_action;
  p_data->action_args = action_data;
  p_data->label = label;
  new_button->data = p_data;
  new_button->event_handler = button_handler;
  new_button->parent = parent;
  new_button->xid = XCreateSimpleWindow(theDisplay, parent, x, y,
					width, height, bdwidth, bdcolor, bgcolor);

  if(XSaveContext(theDisplay, new_button->xid, xwin_context, (caddr_t)new_button) != 0){
    fprintf(stderr,"Error saveing xwin_context date");
    exit(1);
  }

  XSelectInput(theDisplay,new_button->xid, ExposureMask | ButtonPressMask);
  XMapWindow(theDisplay, new_button->xid);
  return new_button;
}

int button_handler(XWIN *p_xwin)
{
  D_BUTTON *p_data = (D_BUTTON *) p_xwin->data;

  if(theEvent.xany.window == p_xwin->xid){
    switch(theEvent.type){
    case Expose:
      if(theEvent.xexpose.count == 0){
	XClearWindow(theDisplay, p_xwin->xid);
	XDrawString(theDisplay, p_xwin->xid, theGC,
		    theFontStruct->max_bounds.width /2,
		    theFontStruct->max_bounds.ascent +
		    theFontStruct->max_bounds.descent,
		    p_data->label, strlen(p_data->label));
      }
      break;
    case ButtonPress:
      if(p_data->action != NULL)
	(*p_data->action)(p_data->action_args);
    }
  }
  return 0;
}
		    
