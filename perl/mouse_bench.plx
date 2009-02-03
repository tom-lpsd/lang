#!/usr/bin/env perl
package Foo;
use Mouse;

has foo => (is => 'rw');

__PACKAGE__->meta->make_immutable(inline_destructor => 1);

package Bar;
use strict;
use warnings;
use base qw/Class::Accessor::Fast/;

__PACKAGE__->mk_accessors(qw/bar/);

package main;
use 5.010;
use strict;
use warnings;

use Benchmark qw(timethese);

timethese(1000000, {
    mouse => sub {
        my $foo = Foo->new();
        $foo->foo(10);
    },
    caf => sub {
        my $bar = Bar->new();
        $bar->bar(10);
    },
});
