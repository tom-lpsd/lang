#!/usr/bin/python

class Listener:
    def __repr__(self):
        res = "<Instance of %s(" % self.__class__.__name__
        for sup in self.__class__.__bases__:
            res += sup.__name__ + ', '
        res += "\b\b)> address %s" % id(self)
        return res

if __name__ == '__main__':
    class A(Listener):
        pass

    class B(A):
        pass
    
    class C(A):
        pass

    class D(B,C):
        pass

    a = D()
    print dir(D)
