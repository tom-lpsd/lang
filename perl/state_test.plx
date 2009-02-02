#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;

sub foo {
    state $a = 0;
    say $a;
    $a++;
    sub { $a++; };
}

my $a = foo;
$a->();
foo;

