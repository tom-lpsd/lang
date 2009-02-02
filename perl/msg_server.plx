#!/usr/bin/perl -w
use strict;
use Msg;

my $host = 'localhost';
my $port = 8080;
Msg->new_server($host, $port, \&login_proc);
print "Server created. Waiting for events";
Msg->event_loop();

sub login_proc {
    return \&rcvd_msg_from_client;
}

sub rcvd_msg_from_client {
    my ($conn, $msg, $err) = @_;
    if (defined $msg) {
	print "$msg\n";
    }
    $conn->send_now("OK");
}

