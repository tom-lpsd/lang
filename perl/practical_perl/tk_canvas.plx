#!/usr/bin/perl -w
use strict;
use Tk;

my $top = MainWindow->new();

my $canvas = $top->Canvas(-width => 200, -height => 100)->pack();
my $id = $canvas->create('line', 10, 10,
	100, 100, -fill => 'red');
MainLoop();

