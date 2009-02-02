#!/usr/bin/perl -w
use strict;
use Tk;

my $top = MainWindow->new();

my $bev = "coffee";
my $coffee = $top->Radiobutton(
	-variable => \$bev,
	-text => 'Coffee',
	-value => 'coffee');

my $tea = $top->Radiobutton(
	-variable => \$bev,
	-text => 'Tea',
	-value => 'tea');

my $milk = $top->Radiobutton(
	-variable => \$bev,
	-text => 'Milk',
	-value => 'milk');

$coffee->pack(-side => 'left');
$tea->pack(-side => 'left');
$milk->pack(-side => 'left');
MainLoop();

