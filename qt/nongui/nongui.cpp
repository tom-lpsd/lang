#include "nongui.h"

void Employee::setSalary(int newSalary)
{
  if (newSalary != mySalary){
    mySalary = newSalary;
    emit salaryChanged(mySalary);
  }
}
