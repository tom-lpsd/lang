#!/usr/bin/perl -w
use strict;
use Data::Dumper;
use JSON;

my $obj = { id => [ 'foo', 'bar', { aa => 'bb'}],
	    hoge => 'boge',};

my $js = objToJson($obj);

$obj = jsonToObj($js);

print "$js\n";
print Dumper($obj);
