#include <gtk/gtk.h>
#define OTHE_KOMA_LEN 8
#define OTHE_KOMA_WIDTH 20
#define OTHE_KOMA_HEIGHT 20

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
  GtkWidget *window;
  GtkWidget *table;
  int x,y;
  
  gtk_set_locale();
  gtk_init(&argc, &argv);
  gtk_rc_parse("./gtkrc");
  
  window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  gtk_window_set_title(GTK_WINDOW(window), "REVERSE");

  gtk_signal_connect(GTK_OBJECT(window), "delete_event", GTK_SIGNAL_FUNC(delete_event), NULL);
  gtk_signal_connect(GTK_OBJECT(window), "destroy", GTK_SIGNAL_FUNC(destroy), NULL);

  table = gtk_table_new(OTHE_KOMA_LEN, OTHE_KOMA_LEN, TRUE);
  gtk_container_add(GTK_CONTAINER(window), table);

  for(x=0;x<OTHE_KOMA_LEN;x++){
    for(y=0;y<OTHE_KOMA_LEN;y++) {
      GtkWidget *button;
      button = gtk_button_new_with_label("○");
      gtk_widget_set_usize(GTK_WIDGET(button), OTHE_KOMA_WIDTH, OTHE_KOMA_HEIGHT);
      gtk_table_attach_defaults(GTK_TABLE(table), button, x, x+1, y, y+1);
      gtk_widget_show(button);
    }
  }

  gtk_widget_show(table);
  gtk_widget_show(window);

  gtk_main();

  return 0;
}
