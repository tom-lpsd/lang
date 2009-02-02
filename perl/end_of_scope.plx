#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;
use B::Hooks::EndOfScope;

sub foo {
    on_scope_end {
        say "END OF SCOPE!!";
    };
    say "FOO BODY!!";
}

foo;
