#!/usr/bin/env python

class Foo:
    def __get__(self, instance, owner):
        print(self, instance, owner)

f = Foo()
f.bar
