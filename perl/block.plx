#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;

FOO: {
    for (0..10) {
	say $_;
	last FOO if $_ == 5;
    }
    say "end of loop";
    last FOO;
    say "below last statement";
}

