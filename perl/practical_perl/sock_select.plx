#!/usr/bin/perl -w
use strict;
use IO::Socket;
use IO::Select;

my $main_sock = new IO::Socket::INET (LocalHost => 'localhost',
				      LocalPort => 1200,
				      Proto     => 'tcp',
				      Listen    => 5,
				      Reuse     => 1,
	);
die "Socket could not be created. Reason: $!" unless $main_sock;

my $readable_handles = new IO::Select();
$readable_handles->add($main_sock);

my ($new_readable, $new_sock);

while(1) {
    ($new_readable) = IO::Select->select($readable_handles,
	                                    undef, undef, undef);

    for my $sock (@$new_readable) {
	if ($sock == $main_sock) {
	    $new_sock = $sock->accept();
	    $readable_handles->add($new_sock);
	}
	else {
	    my $buf = <$sock>;
	    if ($buf) {
		print "You said $buf";
	    }
	    else {
		$readable_handles->remove($sock);
		close($sock);
	    }
	}
    }
}

