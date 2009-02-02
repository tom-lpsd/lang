#!/usr/bin/python
f1 = open("myfile.txt",'w')
f1.write("Hello file world!\n")
f1.close()

f2 = open("myfile.txt",'r')
print f2.readline()[:-1]
f2.close()

