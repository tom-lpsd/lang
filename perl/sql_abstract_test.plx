#!/usr/bin/perl -w
use strict;
use SQL::Abstract;
use Data::Dumper;

my $sql = SQL::Abstract->new;
my ($sth, @bind) = $sql->select('foo', 
				[qw/a b c/],
				{ time => {'LIKE', '20070927'}});
print Dumper($sth, @bind);
