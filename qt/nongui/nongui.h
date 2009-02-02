#ifndef _NONGUI_H
#define _NONGUI_H
#include <QObject>
#include <iostream>

class Employee : public QObject
{
  Q_OBJECT;
public:
  Employee() { mySalary = 0; }
  int salary() const { return mySalary; }
public slots:
  void setSalary(int newSalary);
signals:
  void salaryChanged(int newSalary);
private:
  int mySalary;
};

class Employer : public QObject
{
  Q_OBJECT;
public slots:
  void sayComplain(int){
    std::cerr << "HOHOHO" << std::endl;
  }
};

#endif // _NONGUI_H
