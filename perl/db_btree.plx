#!/usr/bin/perl -w
#
# ch02 /DBM/dupkey1: DB_BTREEメカニズムでBerkeley DBを作成し，重複キーを許す．
#                    それから，重複キーを持ついくつかのテストオブジェクトデータを
#                    挿入し，最終的なデータをダンプする．

use DB_File;
use Fcntl ':flock';
use Megalith;

### Berkeley DBのBTreeモードを重複キーを扱うように設定する．
$DB_BTREE->{'flags'} = R_DUP;

### 既存のデータベースファイルを取り除く．
unlink 'dupkey2.dat';

### データベースを開く．
my %database;
my $db = tie %database, 'DB_File', "dupkey2.dat",
  O_CREAT | O_RDWR, 0666, $DB_BTREE
  or die "Can't initialize database: $!\n";

### 他の人がアクセスしないように，排他的にデータベースをロックする．
my $fd = $db->fd();
open DATAFILE, "+<&=$fd"
  or die "Can't safely open file: $!\n";
print "Acquiring exclusive lock...";
flock( DATAFILE, LOCK_EX)
  or die "Unable to acquire lock: $!. Aborting";
print "Acquired lock. Ready to update database!\n\n";

### 重複キーで，行を作成，パック，挿入する．
$database{'Wiltshire'} =
  new Megalith( 'Avebury',
		'Wiltshire',
		'SU 103 700',
		'Stone Circle and Henge',
		'Largest stone circle in Britain' )->pack();

$database{'Wiltshire'} =
  new Megalith( 'Stonehenge',
		'Wiltshire',
		'SU 123 400',
		'Stone Circle and Henge',
		'The most popularly known ston circle in the world' )->pack();

$database{'Wiltshire'} =
  new Megalith( 'The Sanctuary',
		'Wiltshire',
		'SU 118 680',
		'Stone Circle ( destroyed )',
		'No description avalable' )->pack();

### データベースをダンプする．
foreach my $key ( keys %database ) {
 
  ### レコードをmegalithオブジェクトにアンパックする．
  my $megalith = new Megalith( $database{$key} );

  ### そしてレコードを表示する．
  $megalith->dump();
}

### データベースを閉じる．

undef $db;
undef %database;

### ロックを開放するために，ファイルハンドルを閉じる．
close DATAFILE;

exit;
