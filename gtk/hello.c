#include <gtk/gtk.h>

void hello(GtkWidget *widget, gpointer data)
{
  g_print("こんにちは，世界\n");
  gtk_main_quit();
}

gint delete_event(GtkWidget *widget, GdkEvent *event, gpointer data)
{
  g_print("deleteイベント発生\n");
  return TRUE;
}

void destroy(GtkWidget *widget, gpointer data)
{
  gtk_main_quit();
}

int main(int argc, char *argv[])
{
  GtkWidget *window, *window2;
  GtkWidget *button, *button2;

  gtk_set_locale();
  gtk_init(&argc, &argv);
  gtk_rc_parse("./gtkrc");

  window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  window2 = gtk_window_new(GTK_WINDOW_TOPLEVEL);

  gtk_signal_connect(GTK_OBJECT(window), "delete_event", GTK_SIGNAL_FUNC(delete_event), NULL);
  gtk_signal_connect(GTK_OBJECT(window2), "delete_event", GTK_SIGNAL_FUNC(delete_event), NULL);
  gtk_container_border_width(GTK_CONTAINER(window), 30);
  gtk_container_border_width(GTK_CONTAINER(window2), 30);

  button = gtk_button_new_with_label("Hello, World\nこんにちは，世界");
  button2 = gtk_button_new_with_label("これはテスト");
  
  gtk_signal_connect(GTK_OBJECT(button), "clicked", GTK_SIGNAL_FUNC(hello), NULL);
  gtk_signal_connect(GTK_OBJECT(button2), "clicked", GTK_SIGNAL_FUNC(hello), NULL);
  gtk_container_add(GTK_CONTAINER(window), button);
  gtk_container_add(GTK_CONTAINER(window2), button2);
  gtk_widget_show(button);
  gtk_widget_show(button2);
  gtk_widget_show(window);
  gtk_widget_show(window2);

  gtk_main();

  return 0;
}
