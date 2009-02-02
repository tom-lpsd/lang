#include <qapplication.h>
#include "thread_form.h"

int main(int argc, char *argv[])
{
  QApplication app(argc,argv);
  ThreadForm *dialog = new ThreadForm;
  dialog->show();
  return app.exec();
}
