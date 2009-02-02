#!/usr/bin/perl -w
use strict;
use Tk;

my $top = MainWindow->new();

my $celsius_val = 50;
my $fahrenheit_val;

compute_fahrenheit();

$top->Scale(-orient=>'horizontal',
	-from => 0,
	-to => 100,
	-tickinterval => 10,
	-label => 'Celsius',
	-font => '-adobe-helvetica-medium-r-normal'
	          . '--10-100-75-75-p-56-iso8859-1',
	-length => 300,
	-variable => \$celsius_val,
	-command => \&compute_fahrenheit
	)->pack(
	    -side => 'top',
	    -fill => 'x',
	    -pady => '5');

$top->Scale(-orient=>'horizontal',
	-from =>32,
	-to => 212,
	-tickinterval => 20,
	-label => 'Fahrenheit',
	-font => '-adobe-helvetica-medium-r-normal'
	          . '--10-100-75-75-p-56-iso8859-1',
	-length => 300,
	-variable => \$fahrenheit_val,
	-command => \&compute_celsius
	)->pack(
	    -side => 'top',
	    -fill => 'x',
	    -pady => '5');

sub compute_celsius {
    $celsius_val = ($fahrenheit_val - 32)*5/9;
}
sub compute_fahrenheit {
    $fahrenheit_val = ($celsius_val * 9/5) + 32;
}

MainLoop();

