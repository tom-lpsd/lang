#!/usr/bin/perl -w
use strict;
use RPC;

my $host = 'localhost';
my $port = 8080;
my $conn = RPC->connect($host, $port);
my $answer = $conn->rpc('ask_sheep',
	"Ba ba black sheep, have you any wool ?");
print "$answer\n";
