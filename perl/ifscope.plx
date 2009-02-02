#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;

sub foo {
    $_[0] ? 100 : 0;
}

sub bar {
    if (my $foo = foo($_[0])) {
	say $foo;
    }
    else {
	say $foo;
    }
}

bar(100);
bar(undef);
