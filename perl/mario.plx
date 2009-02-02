#!/usr/bin/env perl
use 5.010;
use strict;
use Games::Nintendo::Mario;

my $hero = Games::Nintendo::Mario->new(name => 'Luigi');
$hero->damage;

