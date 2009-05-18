#!/usr/bin/env perl
package Foo;
use Moose;

package Bar;
use 5.010;
use Moose;
extends 'Foo';

BEGIN { say "In Bar: ", our @ISA }

package main;
use 5.010;
use strict;
use warnings;

say 'OK';
