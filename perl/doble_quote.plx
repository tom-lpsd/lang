#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;
use Benchmark qw/timethese/;

my @foo = qw/foo bar baz/;

timethese(1000000, {
    join => sub {
	join '', @foo;
    },
    quote => sub {
	do { local $"=""; "@foo" }
    }
});
