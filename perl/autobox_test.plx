#!/usr/bin/env perl
use 5.010;
use autobox SCALAR => Foo;

package Foo;
sub world {
    say shift, ", world.";
}

package ARRAY;
sub each {
    my ($aref, $sub) = @_;
    $sub->($_) for (@$aref);
}

package main;
"Hello"->world;
[1,2,3]->each(sub { say shift; }) ;
