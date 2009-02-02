#!/usr/bin/perl -w
use strict;
use LWP::Simple;

my $url = "http://www.yahoo.co.jp/";
my $html = get($url);
print $html;
