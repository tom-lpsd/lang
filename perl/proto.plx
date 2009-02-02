#!/usr/bin/perl -w
use strict;
use Test::More tests => 2;

sub foo ($) { shift; }
my @c = (4,5,6);
is( foo(@c), 3, "\@c is evaluated in scalar context.");
is(&foo(@c), 4, "\@c is evaluated in list context.");
