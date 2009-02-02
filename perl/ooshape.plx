#!/usr/bin/perl -w
use strict;
use OpenOffice::OODoc;

my $doc = ooDocument(file => "output.odp", create => 'presentation');
my $drawpage = $doc->getDrawPage(0);

$doc->createImageElement("Picture1",
			 style => "standard",
			 page => $drawpage,
			 position => "0cm, 0cm",
			 size => "10cm, 5cm",
			 import => "template/sample.png",
			 );

$doc->save();
