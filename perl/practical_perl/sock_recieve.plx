#!/usr/bin/perl -w
use strict;
use IO::Socket;

$SIG{CHLD} = sub { wait() };

my $main_sock = new IO::Socket::INET (LocalHost => 'localhost',
				      LocalPort => 1200,
				      Proto     => 'tcp',
				      Listen    => 5,
				      Reuse     => 1,
	);
die "Socket could not be created. Reason: $!" unless $main_sock;

my ($new_sock, $buf);
my $accept_count = 0;

our $pid;
while( $new_sock = $main_sock->accept()) {
    $pid = fork();
    die "Cannot fork: $!" unless defined($pid);
    if($pid == 0) {
	while (defined ($buf = <$new_sock>)) {
	    print $new_sock "You said: $buf";
	}
	exit(0);
    }
}
close($main_sock);

