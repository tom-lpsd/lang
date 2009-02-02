#!/usr/bin/perl -w
use strict;
use Net::POP3;

my $m = Net::POP3->new(Host=>'moon.odn.ne.jp');
die "Counld not open account" unless $m;
my $n = $m->login('hax97120', 'gspzis3b');
print "Number of msgs reveived: $n\n";
my $r_msgs = $m->list();

for my $msg_id (keys %$r_msgs) {
    print "Msg $msg_id (", $r_msgs->{$msg_id}, "):\n";
    print "-----------------\n";
    my $rl_msg = $m->top($msg_id, 3);
    print @$rl_msg;
}
$m->quit();

