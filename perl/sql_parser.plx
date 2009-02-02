#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;
use SQL::Parser;
use Data::Dumper qw/Dumper/;

open F, "<sample.sql";
my $sql = do { local $/; <F> };
$sql =~ s/`//g;

say $sql;

my $parser = SQL::Parser->new;

my $result = $parser->parse($sql);

say Dumper($result);
