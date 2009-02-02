#!/usr/bin/env python
class Foo:
    def foo(self):
        print("foo")

class Bar(Foo):
    def foo(self):
        super().foo()
        print("bar")

class Baz(Foo):
    def foo(self):
        super().foo()
        print("baz")

class Hoge(Bar, Baz):
    def foo(self):
        super().foo()
        print("hoge")

h = Hoge()
h.foo()

print()

b = Bar()
b.foo()
