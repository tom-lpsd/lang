#!/usr/bin/perl -w
use List::Util qw/max/;

@a = (1,2,3,4,45,6,6,7,9);
$a = \(max @a);
$$a = 100;
print "@a\n";

