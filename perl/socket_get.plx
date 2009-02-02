#!/usr/bin/perl -w
# pcl-cvsモードで日本語を入力するとどうなるかのテスト．

use strict;
use IO::Socket;
use URI;

my $location = shift || die "使用法: $0 URL\n";

my $url = new URI($location);
my $host = $url->host;
my $port = $url->port || 80;
my $path = $url->path || "/";

my $socket = new IO::Socket::INET (PeerAddr => $host, PeerPort => $port, Proto => 'tcp')
  or die "サーバに接続できません。\n";

$socket->autoflush (1);

print $socket "GET $path HTTP/1.1\n","Host: $host\n\n";
print while (<$socket>);

$socket->close;
