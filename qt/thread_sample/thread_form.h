#include <QDialog>
#include <QPushButton>
#include <QCloseEvent>
#include "thread.h"

class ThreadForm : public QDialog
{
  Q_OBJECT;
public:
  ThreadForm(QWidget *parent = 0);
protected:
  void closeEvent(QCloseEvent *event);
private slots:
  void startOrStopThreadA();
  void startOrStopThreadB();
private:
  Thread threadA;
  Thread threadB;
  QPushButton *threadAButton;
  QPushButton *threadBButton;
  QPushButton *quitButton;
};

