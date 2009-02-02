#!/usr/bin/perl -w
use strict;
use Tk;

my $top = MainWindow->new();

my $t = $top->Text(-width=>80, -height=>10)->pack();
$t->insert("insert", " hoge");
$t->insert('1.3', 'Sample');
$t->tagConfigure('foo', -foreground=>'yellow',-background=>'red');
$t->tagAdd('foo', '1.3', '1.6');
MainLoop();

