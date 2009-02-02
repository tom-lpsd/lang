package Foo;
use 5.010;
use Moose;
use Role::Foo;

with 'Role::Foo';

sub foo {
    say "foo";
}

1;
