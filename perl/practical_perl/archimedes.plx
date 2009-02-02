#!/usr/bin/perl -w
use strict;
use Tk;

my $top = MainWindow->new();
my $canvas = $top->Canvas(-width=>300, -height=>245)->pack();

my $origin_x = 110; my $origin_y = 70;
my $PI = 3.1415926535;
my $circle_radius = 5;
my $path_radius = 0;
for (my $angle = 0;$angle <= 360; 
	$path_radius += 7, $circle_radius += 3, $angle += 20) {
    my $path_x = $origin_x + $path_radius * cos ($angle * $PI / 180);
    my $path_y = $origin_y - $path_radius * sin ($angle * $PI / 180);

    $canvas->create('oval', $path_x - $circle_radius,
	    $path_y - $circle_radius, $path_x + $circle_radius,
	    $path_y + $circle_radius, -fill => 'yellow');
    $canvas->create('line', $origin_x, $origin_y,
	    $path_x, $path_y,
	    -fill => 'slategray');
}
MainLoop();

