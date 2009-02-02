#!/usr/bin/env perl
package A;
use 5.010;
use strict;
use warnings;
use B::Deparse;

my $foo = 100;
sub foo {
    say "foo";
    given ("bar") {
	when (/ba/) { say "ba"; }
    }
    sub { $foo + 100 };
}


sub bar {
    my $deparse = B::Deparse->new("-p", "-sC");
    $deparse->coderef2text(\&foo);
}
		       
package main;
my $body = A::bar;
print $body;
say "";
my $foo = A::foo;
print $foo->();
