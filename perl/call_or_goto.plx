#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;
use Benchmark qw/timethese/;

sub foo {
    $_[0];
}

timethese(2000000, {
    goto => sub {
	unshift @_, 100;
	goto \&foo;
    },
    call => sub {
	foo(100, @_);
    }
});
