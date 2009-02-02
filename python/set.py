#!/usr/bin/python

class Set(list):
    def __init__(self, value = []):
        list.__init__([])
        self.concat(value)

    def intersect(self, other):
        res = []
        for x in self:
            if x in other:
                res.append(x)
        return Set(res)

    def union(self, other):
        res = Set(self)
        res.concat(other)
        return res

    def concat(self, value):
        for x in value:
            if not x in self:
                self.append(x)

    def __and__(self, other):
        return self.intersect(other)
    def __or__(self, other):
        return self.union(other)
    def __repr__(self):
        return 'Set:' + list.__repr__(self)
