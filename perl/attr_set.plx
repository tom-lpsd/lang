#!/usr/bin/env perl
use 5.010;

package Foo;
use strict;
use warnings;

sub MODIFY_CODE_ATTRIBUTES {
    $_[1]->();
    say @_;
    return;
}

package Bar;
use base 'Foo';

sub foo { say "OK"; }

package main;
use attributes;

attributes->import('Bar', \&Bar::foo, 'Hoge');
