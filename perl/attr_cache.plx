#!/usr/bin/env perl
use strict;
use warnings;

package Foo;
use Cache::Memcached;
use Attribute::Cached;

sub new {
    bless [], shift;
}

sub getCache {
    Cache::Memcached->new({ servers => ['localhost:11211']});
}

sub getCacheKey {
    my ($pkg, $name, $self, @args) = @_;
    return "$name:$args[0]";
}

sub foo :Cached(time => 300) {
    my $init = 1;
    for (0..$_[1]) {
	$init = $_;
    }
    return $init;
}

package Bar;

sub new {
    bless [], shift;
}

sub foo {
    my $init = 1;
    for (0..$_[1]) {
	$init = $_;
    }
    return $init;
}

package main;
use Benchmark qw/timethese/;

my $foo = Foo->new;
my $bar = Bar->new;

timethese(10000, {
    foo => sub { $foo->foo(10000); },
    bar => sub { $bar->foo(10000); },
});


