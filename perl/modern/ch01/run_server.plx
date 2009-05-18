#!/usr/bin/env perl
use strict;
use warnings;
use TimestampedEchoServer;

my $s = TimestampedEchoServer->new(address => '127.0.0.1', port => 9999);
$s->bind;
$s->run;
