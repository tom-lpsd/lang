#!/usr/bin/perl -w
use strict;
use Msg;

my $conn = Msg->connect('localhost', 8080);
die "Error: Could not connect\n" unless $conn;
$conn->send_now("Message: ");
my ($msg, $err) = $conn->rcv_now();
print $msg . "\n";

