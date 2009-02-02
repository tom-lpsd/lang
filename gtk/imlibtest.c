#include <gdk_imlib.h>

gint main(gint argc, gchar *argv[])
{
  GdkImlibImage *im;
  gdk_init(&argc,&argv);
  gdk_imlib_init();

  im = gdk_imlib_load_image("DSPsystem.jpg");
  gdk_imlib_flip_image_horizontal(im);
  gdk_imlib_save_image(im, "imlibtest.jpg",NULL);

  return 0;
}
