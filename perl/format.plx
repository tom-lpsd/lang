#!/usr/bin/perl -w
use strict;
my @a = (2,3,4,5,6,6,3,34,6);
my $a = 100;
my $b = "asdfkas;dlcjoiwerj;iasjd;ofiajsrfirii";

format STDOUT =
@>>>>>>>>>> ^>>>>
$a,$b
@<<<        ^<<<<~~
shift @a, $b
.

write;
