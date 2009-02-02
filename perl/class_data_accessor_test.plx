#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;
use Test::Simple tests => 5;

package Foo;
use base qw/Class::Data::Inheritable/;

__PACKAGE__->mk_classdata('foo' => 100);

package Bar;
use base qw/Foo/;

__PACKAGE__->foo(200);

package main;

ok(Foo->foo == 100, "Foo's foo is 100.");
ok(Bar->foo == 200, "Bar's foo is 200.");

my $obj = bless \(my $dummy), "Foo";
ok($obj->foo == 100,
    "Foo's instance also has foo whose value is 100.");

$obj->foo(300);
ok(Foo->foo == 300, 
    "Foo's foo is now 300 after its instance change foo's value.");

ok(Bar->foo == 200,
    "Bar's foo is not affected.");

