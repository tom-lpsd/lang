#!/usr/bin/env perl
use 5.010;
package Foo;
use strict;
use attributes qw/get reftype/;

sub MODIFY_CODE_ATTRIBUTES {
    @main::foo = @_[2..$#_];
    return;
}

sub FETCH_CODE_ATTRIBUTES {
    local $, = " ";
    $_[1]->(200);
    say @_;
}

sub MODIFY_SCALAR_ATTRIBUTES {
    local $, = " ";
    say @_;
    bless $_[1], $_[2];
    return;
}

sub foo : Bar :Baz {
    say $_[0];
}

my $foo : Hoge = 1;
say (ref \$foo);

package main;
use strict;
use attributes qw/get/;
Foo::foo(100);

our @foo;
$, = " ";
say @foo;
get \&Foo::foo;

