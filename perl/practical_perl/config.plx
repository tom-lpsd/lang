#!/usr/bin/perl -w
use Config;
while (($k, $v) = each %Config) {
    print "$k => $v \n";
}

