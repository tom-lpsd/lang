#!/usr/bin/env perl
use strict;
use warnings;
use Module::Pluggable::Object;

my $locator = Module::Pluggable::Object->new(
        search_path => [qw/Catalyst::Plugin/],
    );

print "$_\n" for $locator->plugins;
