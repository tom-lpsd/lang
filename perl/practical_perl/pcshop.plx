#!/usr/bin/perl -w
use strict;
use PCShop;

my $cdrom = new PCShop::CDROM;
my $monitor = new PCShop::Monitor;
my $computer = new PCShop::Computer($monitor, $cdrom);
print $computer->net_price() . "\n";
