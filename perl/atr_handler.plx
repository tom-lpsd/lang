#!/usr/bin/env perl
package Foo;
use 5.010;
use strict;
use Attribute::Handlers;

sub Foo :ATTR {
    local $, = "\n";
    say @_;
    say $_[4]->[0];
}

sub Bar {
    say "OK";
}

package main;
use base qw/Foo/;

main->Bar();

sub foo :Foo("
This is Foo method.
This is not Bar method.
")
{
    say "OK";
}

foo();
