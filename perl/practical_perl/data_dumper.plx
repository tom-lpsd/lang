#!/usr/bin/perl -w
use Data::Dumper;

$c = {even => [2,4,],
      odd  => [1,3,]};

$obj = bless {foo=>'bar'}, 'Example';
$msg = Dumper($c, $obj);
print $msg;

$a = 100;
@b = (2,3);
print Data::Dumper->Dump([$a, \@b], ["foo", "*bar"]);

