#ifndef _Department_h_
#define _Department_h_
#include <Object.h>
// File : 'Department.h'
// User : "tom"
class Department : public Object {
    int id;
    string name;
    Department();
public:
    Department *Create();
    ~Department();

    int get_id();
    void set_id(int);
    string get_name();
    void set_name(string);
}
#endif

