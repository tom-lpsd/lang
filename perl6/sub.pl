#!/usr/bin/env pugs

sub foo ($foo is copy) {
    sub { $foo += 100; };
}

my $x = 100;
my $s = foo($x);
say $s() ~ " " ~ $x;

