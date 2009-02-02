#!/usr/bin/perl -w
use strict;
use Monitor;

my $c;
monitor(\$c, 'c');
$c = 100;
print $c . "\n";
