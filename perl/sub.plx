#!/usr/bin/perl -w
use strict;

sub foo {
    print "@_\n";
    $_[0] = 200;
}

sub bar {
    &foo;
}

my $a = 100;
bar($a);
print "$a\n";

