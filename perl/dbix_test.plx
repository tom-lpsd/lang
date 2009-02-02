#!/usr/bin/env perl
use DB::Main;

my $schema = DB::Main->connect("dbi:SQLite:dbname=dbix.db");
my @all_artists = $schema->resultset('Artist')->all;
print $all_artists[0]->name, "\n";
