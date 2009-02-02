#!/usr/bin/perl -w
package Employee;
use strict;
use ObjectTemplate;
our @ISA = qw|ObjectTemplate|;
attributes qw|name age position|;

package main;
my $obj = Employee->new(name => "Norma Jean",
                        age  => 25);
$obj->position("Actress");
print $obj->name, ":", $obj->age. "\n";

