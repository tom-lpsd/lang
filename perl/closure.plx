#!/usr/bin/perl -w
use strict;

our $bias = 100;

sub make_closure {
    my $a = shift;
    return sub { return $a + $bias + shift; };
}

my $add2 = make_closure(2);
my $add10 = make_closure(10);

print $add2->(10), "\n";
print $add10->(10), "\n";

$bias = 10;

print $add2->(10), "\n";
print $add10->(10), "\n";

