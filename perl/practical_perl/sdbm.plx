#!/usr/bin/perl -w
use Fcntl;
use SDBM_File;
tie (%h, 'SDBM_File', 'foo.dbm', O_RDWR|O_CREAT, 0640)
    || die $!;
$h{a} = 10;
while (($k, $v) = each %h) {
    print "$k, $v\n";
}
untie %h;

