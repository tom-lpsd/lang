#!/usr/bin/perl -w
use strict;
use Tk;

my $top = MainWindow->new();
my $button = $top->Button(
	-text => 'Start',
	-command => \&change_label);

$button->pack();
MainLoop();

sub change_label {
    $button->cget('-text') eq 'Start' ?
	$button->configure(-text => 'Stop') :
	$button->configure(-text => 'Start');
}

