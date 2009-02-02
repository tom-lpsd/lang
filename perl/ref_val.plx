#!/usr/bin/perl
use strict;

sub func {
    $_ = $_ + 3 for @_;
}

my @a = (1,2,3);
func(@a);
print "@a\n";
