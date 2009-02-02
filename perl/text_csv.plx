#!/usr/bin/env perl
use strict;
use warnings;
use Text::CSV_PP;

my $csv = Text::CSV_PP->new;

$csv->print(*STDOUT, [qw/a b c d e f/]);
