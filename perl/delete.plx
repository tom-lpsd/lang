#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;

my %foo = ( foo => 100);

delete $foo{foo} or say "NO";
delete $foo{bar} or say "OK";
