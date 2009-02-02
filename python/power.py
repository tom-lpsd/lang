#!/usr/bin/env python
L = []
for x in range(7):
    L.append(2**x)
X = 5

i = 0
if 2**X in L:
    print 'at index', L.index(2**X)
else:
    print X, 'not found'
