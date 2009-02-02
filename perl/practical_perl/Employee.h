#ifndef _Employee_h_
#define _Employee_h_
#include <Object.h>
// File : 'Employee.h'
// User : "tom"
class Employee : public Object {
    int id;
    string name;
    int dept_id;
    Employee();
public:
    Employee *Create();
    ~Employee();

    int get_id();
    void set_id(int);
    string get_name();
    void set_name(string);
    int get_dept_id();
    void set_dept_id(int);
}
#endif
