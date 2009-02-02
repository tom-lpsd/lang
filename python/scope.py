#!/usr/bin/env python
x = 100
y = 200
z = 10
def foo(x):
    z = 10
    def bar():
        z = 200
        x.append(4)
        return z * 100
    print bar()
    print z
    x.append(3)

a = [1,2,3]
foo(a)
print a
print y
