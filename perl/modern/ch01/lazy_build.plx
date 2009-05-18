#!/usr/bin/env perl
use strict;
use warnings;
use LazyBuild;
use IO::Socket::INET;

my $lb = LazyBuild->new(address => '127.0.0.1');
$lb->server_socket(IO::Socket::INET->new(
    Listen => 3,
    LocalAddr => 'localhost',
    LocalPort => 9000,
    Proto => 'tcp',
));
print $lb->server_socket->sockport, "\n";
