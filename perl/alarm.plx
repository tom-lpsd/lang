#!/usr/bin/evn perl
use 5.010;
use strict;
use warnings;

our $flag = 0;

sub trap {
    $flag = 1;
    say "OK";
}

$SIG{ALRM} = \&trap;

alarm 10;

1 until ($flag);
