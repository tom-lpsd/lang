#!/usr/bin/perl -w
use TieFile;

tie @lines, 'TieFile', 'TieFile.pm';
for (0 .. 20) {
    print $lines[$_];
}

