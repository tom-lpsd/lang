#include <gtk/gtk.h>

gint main(gint argc, gchar *argv[])
{
  gtk_set_locale();
  gtk_init(&argc,&argv);
  gtk_widget_show(gtk_color_selection_dialog_new("Color Picker"));
  gtk_main();
  return 0;
}
