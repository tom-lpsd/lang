@foreach class_list
@openfile ${class_name}.h
#ifndef _${class_name}_h_
#define _${class_name}_h_
#include <Object.h>
@perl $user = $ENV{"USER"};
// File : '${class_name}.h'
// User : "$user"
class $class_name : public Object {
@foreach attr_list
    $attr_type $attr_name;
@end
    $class_name();
public:
    $class_name *Create();
    ~$class_name();

@foreach attr_list
    $attr_type get_${attr_name}();
    void set_${attr_name}($attr_type);
@end .. attr_list
}
#endif
@end .. class_list

