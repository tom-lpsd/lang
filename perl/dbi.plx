#!/usr/bin/perl -w
use strict;
use DBI;

my $name = "test";
my $dbh = DBI->connect("dbi:SQLite:dbname=$name","","");
my @names = $dbh->tables;
print "@names\n";
