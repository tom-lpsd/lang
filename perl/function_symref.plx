#!/usr/bin/env perl
use 5.010;

package Foo;

sub foo {
    say "foo";
}

package main;
use strict;
use warnings;

my $ref = "Foo::foo";

defined (&$ref) and do { say "OK" };

{
    no strict 'refs';
    defined (&$ref()) and do { say "OK2" };
}

&Foo::foo;
