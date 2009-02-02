#!/usr/bin/perl -w
use strict;
use Stopwatch;

my $s;
tie $s, 'Stopwatch';

$s = 0;
sleep(10);
print "$s\n";
