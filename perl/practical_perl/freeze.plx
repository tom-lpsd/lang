#!/usr/bin/perl -w
use FreezeThaw qw|freeze thaw|;

$c = { 'even' => [2,4,6,8],
       'odd'  => [1,3,5,7]};
$obj = bless {'foo' => 'bar'}, 'Example';
$msg = freeze($c, $obj);
open (F, "> test") || die;
syswrite(F, $msg, length($msg));

