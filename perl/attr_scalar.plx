#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;

package Foo;

sub MODIFY_HASH_ATTRIBUTES {
    say @_;
    return ();
}

package Bar;
BEGIN { our @ISA = 'Foo'; }

our %bar : Foo = ( foo => 100);

package main;

say %Bar::bar;
