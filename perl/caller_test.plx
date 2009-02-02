#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;

package Foo;

sub foo {
    local $, = " ";
    say caller(0);
}

package main;

Foo::foo;
