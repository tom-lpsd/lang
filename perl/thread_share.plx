#!/usr/bin/env perl 
use 5.010;
use threads;
use threads::shared;

my $foo :shared = 0;

sub bar {
    my $name = shift;
    for (1..10000) {
	local $| = 1;
	lock($foo);
	say $name . " " . $foo++;
    }
}

my $th1 = threads->create(\&bar, "th1");
my $th2 = threads->create(\&bar, "th2");

$th1->join();
$th2->join();

