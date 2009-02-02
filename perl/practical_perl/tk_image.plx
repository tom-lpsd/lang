#!/usr/bin/perl -w
use Tk;

$top = MainWindow->new();
$top->title("Simple Image");

$l = $top->Label(-text => 'hello',
                 -anchor => 'n',
                 -relief => 'groove',
	         -width => 100, -height => 30);
$image = $l->Photo(-file => '/home/tom/blog/image/mari40.gif');
$l->configure(-image => $image);
$l->pack();
MainLoop();

