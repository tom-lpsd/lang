#!/usr/bin/env perl
use strict;
use warnings;
use XML::Atom::Client;
use XML::Atom::Entry;
use XML::Atom::Feed;

my $api = XML::Atom::Client->new;
$api->username('tom-lpsd');
$api->password('********');

my $feed = $api->getFeed("http://b.hatena.ne.jp/atom/feed");

print $feed->as_xml;
