#include <iostream>
#include "thread.h"
using namespace std;

Thread::Thread()
{
  stopped = false;
}

void Thread::run()
{
  while(!stopped){
    cerr << messageStr.toStdString();
  }
  stopped = false;
  cerr << endl;
}

void Thread::setMessage(const QString &message)
{
  messageStr = message;
}

void Thread::stop()
{
  stopped = true;
}

