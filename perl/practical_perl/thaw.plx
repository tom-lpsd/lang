#!/usr/bin/perl -w
use strict;
use FreezeThaw qw|thaw|;

open (F, "<test") || die;
my ($c, $obj) = thaw (<F>);
print $obj->{foo} . "\n";
print $c->{even}[1] . "\n";

