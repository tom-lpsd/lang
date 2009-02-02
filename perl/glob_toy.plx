#!/usr/bin/perl -w
use strict;
use warnings;

package Foo;
our $a = 100;
bless \$a, "Foo";

package main;
print *{$Foo::{a}}{SCALAR}, "\n";
