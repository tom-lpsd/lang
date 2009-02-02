#!/usr/bin/perl -w
use Tk;

$top = MainWindow->new();
$top->title("Simple");

$l = $top->Label(-text => 'hello',
                 -anchor => 'n',
                 -relief => 'groove',
	         -width => 10, -height => 3);
$l->pack();
MainLoop();

