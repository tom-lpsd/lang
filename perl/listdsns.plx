#!/usr/bin/perl -w
# ch04/listdsns: すべてのデータソースとすべてのインストール済ドライバを列挙する

use DBI;

### インストールされたドライバのためにDBIを調べる．
my @drivers = DBI->available_drivers();

die "No drivers found!\n" unless @drivers; # 万が一のために．

### ドライバにわたって繰り返し，
### それぞれのドライバに対するデータソースをリストする．

foreach my $driver ( @drivers ) {
  print "Driver: $driver\n";
  my @dataSources = DBI->data_sources( $driver );
  foreach my $dataSource ( @dataSources ){
    print "\tData Source is $dataSource\n";
  }
  print "\n";
}

exit;
