#!/usr/bin/python

class Animal:
    def reply(self):
        self.speak()
    def speak(self):
        print "animal"

class Mammal(Animal):
    def speak(self):
        print "mammal"

class Cat(Mammal):
    def speak(self):
        print "meow"

class Dog(Mammal):
    def speak(self):
        print "bow wow"

class Primate(Mammal):
    def speak(self):
        print "Hello"

class Hacker(Primate):
    pass

if __name__ == '__main__':
    spot = Cat()
    spot.reply()
    data = Hacker()
    data.reply()
