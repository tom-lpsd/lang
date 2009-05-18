#!perl
use strict;
use warnings;

$_ = "Just another Perl hackger, ";
my @words = /(\S+)/g;

while (/(\S+)/g) {
    print "Next word is '$1'\n";
}


