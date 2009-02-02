#include <gtk/gtk.h>

void button_pressed(GtkObject *obj, gpointer date)
{
  g_message("Hello World !");
}

gint exposed(GtkWidget *widget, GdkEvent *event, gpointer data)
{
  g_message("Exposed !");
  return TRUE;
}

gint configured(GtkWidget *widget, GdkEvent *event, gpointer date)
{
  g_message("Configured !");
  return TRUE;
}

void gui_config(void)
{
  GtkWidget *window;
  GtkWidget *button;

  window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  button = gtk_button_new_with_label("こんにちはGTK");
  gtk_container_add(GTK_CONTAINER(window), button);

  gtk_signal_connect(GTK_OBJECT(button), "clicked",
		     GTK_SIGNAL_FUNC(button_pressed), NULL);
  gtk_signal_connect(GTK_OBJECT(window), "destroy",
		     GTK_SIGNAL_FUNC(gtk_main_quit), NULL);

  gtk_signal_connect(GTK_OBJECT(button), "expose_event",
		     GTK_SIGNAL_FUNC(exposed), NULL);
  gtk_signal_connect(GTK_OBJECT(window), "configure_event",
		     GTK_SIGNAL_FUNC(configured), NULL);

  gtk_widget_show_all(window);
}

gint main(gint argc, gchar *argv[])
{
  gtk_set_locale();
  gtk_init(&argc, &argv);
  gui_config();
  gtk_main();
  return 0;
}
