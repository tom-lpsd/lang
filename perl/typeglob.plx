#!/usr/bin/perl -w

*HOGE = \100;
*HOGE = [10,20,30];
print "$HOGE\n";
print @HOGE, "\n";

open HOGE,">hoge.txt";
*ABC = \*HOGE;
print ABC "ihoaisdfoij\n";
print "$ABC\n";
print @ABC, "\n";
