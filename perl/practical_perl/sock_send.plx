#!/usr/bin/perl -w
use strict;
use IO::Socket;

my $sock = new IO::Socket::INET(PeerAddr => 'localhost',
	                        PeerPort => 1200,
				Proto    => 'tcp',
	);
die "Socket could not be created. Reason: $!\n" unless $sock;
for(1 .. 10){
    print $sock "Msg $_: How are you?\n";
    $sock->flush;
}
close($sock);

