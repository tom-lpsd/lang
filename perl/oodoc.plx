#!/usr/bin/perl -w
use strict;
use OpenOffice::OODoc;

my $text = "テスト";
my $text2 = "TEST";
my $doc = ooDocument(file => "template/hoge.odf");
$doc->selectElementsByContent($text, $text2);
$doc->save("template/hoge2.odf");

