#!/usr/bin/perl -w
use strict;
use File;

my $obj = File->open("File.pm");
print $obj->next_line;
$obj->put_back("---------------------------------\n");
print $obj->next_line;
print $obj->next_line;
