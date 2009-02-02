#!/usr/bin/perl -w
use strict;

sub timed_out {
    die "GOT TIRED OF WAITING";
}

$SIG{ALRM} = \&timed_out;

eval {
    alarm(10);
    my $c = <>;
    alarm(0);
};
if ($@ =~ /GOT TIRED OF WAITING/) {
    print "Timed out...\n";
}
       	
