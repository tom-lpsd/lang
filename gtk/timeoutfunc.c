#include <stdio.h>
#include <gtk/gtk.h>

gint timeoutfunc(gint *n)
{
  if (*n==0){
    gtk_main_quit();
  }
  else{
    printf("%d\n",(*n)--);
  }
  return TRUE;
}

gint main(gint argc, gchar *argv[])
{
  gint n = 9;

  gdk_init(&argc, &argv);
  gtk_timeout_add(60000,(GtkFunction)timeoutfunc, (gpointer)&n);

  gtk_main();

  printf("Bang !!\n");
  return 0;
}
