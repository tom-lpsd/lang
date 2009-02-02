#include "nongui.h"

int main(void)
{
  Employer *er = new Employer;
  Employee *ee = new Employee;

  QObject::connect(ee,SIGNAL(salaryChanged(int)),
		   er,SLOT(sayComplain(int)));

  int en;
  std::cin >> en;
  ee->setSalary(en);
  return 0;
}
