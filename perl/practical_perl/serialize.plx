#!/usr/bin/perl -w
use strict;

package Employee;
use ObjectTemplate;
our @ISA = qw|ObjectTemplate|;
attributes(qw|_id name age dept|);

package Department;
use ObjectTemplate;
our @ISA = qw|ObjectTemplate|;
attributes(qw|_id name address|);

package main;
use Adaptor::File;

my $dept = new Department (name=>'Materials Handling');
my $emp1 = new Employee (name=>'John', age=>23, dept=>$dept);
my $emp2 = new Employee (name=>'Larry', age=>45, dept=>$dept);

my $db = Adaptor::File->new('test.dat', 'empfile.cfg');
$db->store($dept);
$db->store($emp1);
$db->store($emp2);
$db->flush();

my @emps = $db->retrieve_where('Employee', "age > 40 && name != 'John'");
for my $emp (@emps) {
    print "$emp " . $emp->name . " " . $emp->age . "\n";
}

