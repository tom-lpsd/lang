#include <stdio.h>
#include <gtk/gtk.h>

gint main(gint argc, gchar *argv[])
{
  GtkWidget *target;
  GtkSignalQuery *query;
  guint *signals;
  guint i, nsignals;
  
  gtk_init(&argc, &argv);
  
  target = gtk_button_new();
  signals = GTK_OBJECT_SIGNALS(target);
  nsignals = GTK_OBJECT_NSIGNALS(target);

  for(i=0;i<nsignals;i++){
    query = gtk_signal_query(signals[i]);
    printf("%s\n",query->signal_name);
  }
  return 0;
}
