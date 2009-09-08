#include "ruby.h"

static VALUE t_init(VALUE self)
{
  VALUE arr;
  arr = rb_ary_new();
  rb_iv_set(self,"@arr",arr);
  return self;
}

static VALUE t_add(VALUE self, VALUE anObject)
{
  VALUE arr;
  arr = rb_iv_get(self,"@arr");
  rb_ary_push(arr,anObject);
  return arr;
}

static VALUE t_say(VALUE self)
{
  printf("Hello World2!\n");
  return self;
}

VALUE cHello;

void Init_Hello()
{
  cHello = rb_define_class("Hello",rb_cObject);
  rb_define_method(cHello, "initialize", t_init, 0);
  rb_define_method(cHello, "add", t_add, 1);
  rb_define_method(cHello, "say", t_say, 0);
}
