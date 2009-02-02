#!/usr/bin/perl -w
use strict;
use ClassChain;

my $cc = ClassChain3->new(40);
$cc->shout;
print $cc->{attr} . "\n";
