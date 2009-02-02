#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;
use Cache::Memcached::Fast;

my $memd = Cache::Memcached::Fast->new({
    servers => ['localhost:11211'],
    namespace => 'test:',
}) or die "memcached construction failed";

my $foo = {
    foo => 200
};

$memd->set('hoge', $foo);
say %{$memd->get('hoge')};
