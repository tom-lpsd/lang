#!/usr/bin/perl -w

use strict;
use DBI;

my $dbh = DBI->connect("dbi:Pg:dbname=test;host=tom-lpsd.dyndns.org", "", "",{PrintError => 1});
my $sth = $dbh->prepare( "SELECT * FROM shinamono");
$sth->execute();

while ( my @row = $sth->fetchrow_array() ) {
  print "$row[0] | $row[1]\n";
}

print "$dbh->{Name}\n";

my @tables = $dbh->tables();

for my $table (@tables) {
  print "Table: $table\n";
}

$dbh->disconnect();

exit;
