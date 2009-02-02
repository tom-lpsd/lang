#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;

package A;

sub foo {
    my $self = shift;
    my $foo = shift;
    sub { $foo + shift(); };
}

package B;

package main;
my $a = bless {}, "B";

say $a->A::foo(2)->(100);
