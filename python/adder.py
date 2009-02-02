#!/usr/bin/python

class Adder:
    def __init__(self, val):
        self.data = val
    def add(self, oth):
        print "Not Implemented"
    def __add__(self,oth):
        return self.add(oth)

class ListAdder(Adder):
    def add(self, oth):
        return self.data + oth

class DictAdder(Adder):
    def add(self, oth):
        res = {}
        res.update(self.data)
        res.update(oth)
        return res

