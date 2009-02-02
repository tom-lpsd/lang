#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;
use XML::LibXML;

my $doc = XML::LibXML::Document->new('1.0', 'utf-8');
my $entry = $doc->createElement("entry");
$entry->appendText("hogehoge");
$doc->setDocumentElement($entry);
say $doc->toString;

