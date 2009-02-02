#!/usr/bin/env perl
use strict;
use warnings;
use Class::DBI;
use List::Util qw/max/;

package Foo::DBI;
use base 'Class::DBI';
__PACKAGE__->connection('dbi:Pg:dbname=sandbox', 'tom', '', {AutoCommit=>1});

package Foo::CBsample;
use base 'Foo::DBI';
__PACKAGE__->table('cbsample');
__PACKAGE__->columns(All => qw/id name/);

package main;
my $cb = Foo::CBsample->retrieve(1);
print $cb->name, "\n";

my @all = Foo::CBsample->retrieve_all;
print "@$_\n" for (map {[$_->id, $_->name]} @all);
my $id = max @all + 1;
my $cb2 = Foo::CBsample->insert({id => $id, name => 'baz'});

my @foos = Foo::CBsample->search( name => 'baz');
for (@foos) {
    print $_->id, "\n";
}

