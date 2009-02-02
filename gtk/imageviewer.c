#include <stdlib.h>
#include <gtk/gtk.h>
#include <gdk_imlib.h>

static GdkImlibImage *im = NULL;
static GdkPixmap *pixmap = NULL;

gint configured(GtkWidget *widget, GdkEventConfigure *event)
{
  gint w,h;
  w = widget->allocation.width;
  h = widget->allocation.height;
  gdk_imlib_render(im,w,h);

  if(pixmap){
    gdk_pixmap_unref(pixmap);
  }
  pixmap = gdk_imlib_move_image(im);

  return TRUE;
}

gint exposed(GtkWidget *widget, GdkEventExpose *event)
{
  if(pixmap){
    gdk_draw_pixmap(widget->window,
		    widget->style->fg_gc[GTK_WIDGET_STATE(widget)],
		    pixmap, 
		    event->area.x, event->area.y,
		    event->area.x, event->area.y,
		    event->area.width, event->area.height);
  }
  return TRUE;
}

void gui_config()
{
  GtkWidget *window;
  GtkWidget *drawing_area;
  
  window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  
  drawing_area = gtk_drawing_area_new();
  gtk_drawing_area_size(GTK_DRAWING_AREA(drawing_area),
			im->rgb_width, im->rgb_height);
  gtk_container_add(GTK_CONTAINER(window),drawing_area);

  gtk_signal_connect(GTK_OBJECT(window), "destroy",
		     GTK_SIGNAL_FUNC(gtk_main_quit), NULL);
  gtk_signal_connect(GTK_OBJECT(drawing_area), "expose_event",
		     GTK_SIGNAL_FUNC(exposed), NULL);
  gtk_signal_connect(GTK_OBJECT(drawing_area), "configure_event",
		     GTK_SIGNAL_FUNC(configured), NULL);
  gtk_widget_set_events(drawing_area,GDK_EXPOSURE_MASK);
  gtk_widget_show_all(window);
}

gint main(gint argc, gchar *argv[])
{
  gtk_init(&argc, &argv);
  gtk_set_locale();
  gdk_imlib_init();
  if ( (argc<2) || ((im = gdk_imlib_load_image(argv[1])) == NULL) ){
    g_error("正しいイメージファイルが指定されていません．");
    exit(-1);
  }
  gui_config();
  gtk_main();

  return 0;
}
