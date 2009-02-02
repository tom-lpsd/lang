#!/usr/bin/perl -w
use strict;
use RPC;

my $host = 'localhost';
my $port = 8080;
RPC->new_server($host, $port);
RPC->event_loop();

sub ask_sheep {
    print "Question: @_\n";
    return "No";
}
