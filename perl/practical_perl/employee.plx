#!/usr/bin/perl -w
use strict;
use Employee;

my $emp = HourlyEmployee->new("tom", 23, "plain",
			      900, 1000);

print $emp->promote . "\n";
