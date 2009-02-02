#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;
use Scalar::Util qw/weaken/;

{
    package A;

    sub new {
	bless \(my $__), shift;
    }

    sub DESTROY {
	say "destroy";
    }
}

my A $r;
{
    my A $a = A->new;
    $r = $a;
}
weaken($r);

say "Program ended."
