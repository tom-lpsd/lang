#!/usr/bin/perl -w
use strict;
use Class::HideMethods;

package Fooo;
sub foo :Private('dayo') :Foo('hoge') {
    print "foo\n";
}

#my $foo :Private('foo');
our $foo;
foo();
print $foo, "\n";
sub f :Private('foo') {};
