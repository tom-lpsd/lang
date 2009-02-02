#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;

sub find_fold (&$$\@);
sub find_fold2 (&$$\@);

sub find_fold (&$$\@) {
    my ($pred, $process, $seed, $list) = @_;
    return $seed if (@$list == 0);
    if ($pred->(my $car = shift @$list)) {
	$seed = $process->($car, $seed);
	find_fold(\&$pred, $process, $seed, @$list);
    } else {
	find_fold(\&$pred, $process, $seed, @$list);
    }
}

sub cons {
    say "found: $_[0]";
    unshift @{$_[1]}, $_[0];
    $_[1];
}

my @list = 1..10;

my $res = find_fold { ($_[0] % 2) != 0 } \&cons, [], @list;

say "(@$res)";

sub find_fold2 (&$$\@) {
    my ($pred, $process, $seed, $list) = @_;
    return $seed if (@$list == 0);
    if ($pred->(my $car = shift @$list)) {
	return $process->($car, $seed, sub { find_fold2(\&$pred, $process, $_[0], @$list) });
    }
    goto \&find_fold2;
}

our $next;

sub breaker {
    my $proc = shift;
    sub {
	my ($elt, $seed, $cont) = @_;
	our $next = sub { push @_, $proc->($elt, $seed); goto $cont; };
	undef;
    }
}

@list = 1..10;
find_fold2 { ($_[0] % 2) != 0 } breaker(\&cons), [], @list;

1 until $res = $next->();

say "(@$res)";

