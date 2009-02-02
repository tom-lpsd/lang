#!/usr/bin/perl -w

use strict;
use Data::Dumper;
use Jcode;

sub search {
    my $layer = shift;
    my @files = glob "$layer/*";
    my $node = {};
    foreach (@files){
	my $jc = Jcode->new($_);
	if(-d){
	    $node->{$jc->utf8} = search("\Q$_\E");
	}
	elsif(-f){
	    $node->{$jc->utf8} = "file";
	}
    }
    return $node;
}

my $root = search(".");

print Dumper($root);
