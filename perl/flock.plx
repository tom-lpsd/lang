#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;
use Fcntl qw/:flock/;

open FOO, 'foo' or die "Cannot open file foo.";
say "begin...";
flock FOO, LOCK_EX;
say "please input something.";
my $foo = <>;
say "OK";
flock FOO, LOCK_UN;
close FOO;
