#!/usr/bin/perl -w
use Storable;

$a = [100,200, {foo=>'bar'}];
eval {
    store($a, 'test.dat');
};
print "Error writing to file: $@" if $@;
$b = retrieve('test.dat');

print $b->[0] . "\n";
print $b->[1] . "\n";
print $b->[2]->{foo} . "\n";

