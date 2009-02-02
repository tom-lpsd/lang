#!/usr/bin/python

class Meta:
    def __getattr__(self, name):
        print 'get %s' % name
        return None

    def __setattr__(self, name, val):
        print 'set %s to %s' % (name, val)
        self.__dict__[name] = val
