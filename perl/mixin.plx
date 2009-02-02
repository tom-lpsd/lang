#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;

package Foo;

sub new {
    bless [], shift;
}

sub foo {
    say "foo";
}

package Bar;
use Class::Mixin to => 'Foo';

sub foo {
    say "foo in bar";
}

sub bar {
    say "bar";
}

package main;

my $foo = Foo->new;
$foo->foo;
$foo->bar;

{ local $, = "\n"; say keys %main::;}
