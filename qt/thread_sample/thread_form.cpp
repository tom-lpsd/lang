#include <QLayout>
#include "thread_form.h"

ThreadForm::ThreadForm(QWidget *parent)
  : QDialog(parent)
{
  setWindowTitle(tr("Threads"));

  threadA.setMessage("A");
  threadB.setMessage("B");
  
  threadAButton = new QPushButton(tr("Start A"), this);
  threadBButton = new QPushButton(tr("Start B"), this);
  quitButton = new QPushButton(tr("Quit"),this);
  quitButton->setDefault(true);

  connect(threadAButton, SIGNAL(clicked()),
	  this, SLOT(startOrStopThreadA()));
  connect(threadBButton, SIGNAL(clicked()),
	  this, SLOT(startOrStopThreadB()));
  connect(quitButton, SIGNAL(clicked()),
	  this, SLOT(close()));
  
  QHBoxLayout *topLayout = new QHBoxLayout(this);
  topLayout->setMargin(6);
  topLayout->addWidget(threadAButton);
  topLayout->addWidget(threadBButton);
  topLayout->addWidget(quitButton);
}

void ThreadForm::startOrStopThreadA()
{
  if (threadA.isRunning()){
    threadA.stop();
    threadAButton->setText(tr("Start A"));
  }
  else {
    threadA.start();
    threadAButton->setText(tr("Stop A"));
  }
}

void ThreadForm::startOrStopThreadB()
{
  if (threadB.isRunning()){
    threadB.stop();
    threadBButton->setText(tr("Start B"));
  }
  else {
    threadB.start();
    threadBButton->setText(tr("Stop B"));
  }
}

void ThreadForm::closeEvent(QCloseEvent *event)
{
  threadA.stop();
  threadB.stop();
  threadA.wait();
  threadB.wait();
  event->accept();
}
