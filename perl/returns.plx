#!/usr/bin/env perl -w
use strict;
use Benchmark qw(timethese cmpthese);

sub foo {
    my @foo;
    push @foo, $_ for (1..1000); 
    return @foo;
}

sub bar {
    my @bar;
    push @bar, $_ for (1..1000);
    return \@bar;
}

sub foo_hash {
    my %foo;
    @foo{1..1000} = 1..1000;
    return %foo;
}

sub bar_hash {
    my %bar;
    @bar{1..1000} = 1..1000;
    return \%bar;
}

my $c = 
timethese(-5, {
	value_array => sub { my @foo = foo; },
	ref_array => sub { my $bar = bar; },
	value_hash => sub { my %foo = foo_hash; },
	ref_hash => sub { my $bar = bar_hash; },
    });

cmpthese($c);
