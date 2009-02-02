#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;
use Test::More tests => 4;

package A;

sub f {
    return "A";
}

package B;
our @ISA = qw/A/;

package C;
our @ISA = qw/A/;

sub f {
    return "C";
}

package D;
our @ISA = qw/B C/;

package main;

my $obj = bless {}, "D";

is(join ("", @{mro::get_linear_isa("D")}), "DBAC", "dfs order");
is($obj->f, "A", "A's f");

mro::set_mro("D", "c3");

is(join ("", @{mro::get_linear_isa("D")}), "DBCA", "c3 order");
is($obj->f, "C", "C's f");
