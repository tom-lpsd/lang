#!/usr/bin/perl -w
use strict;
use InsideOut::User;

my $iusr = InsideOut::User->new({name => 'tom', address => 'Tokyo'});
print $iusr->get_name, "\n";
print $iusr->get_address, "\n";
