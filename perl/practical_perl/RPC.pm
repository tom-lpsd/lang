package RPC;
use Msg;
use strict;
use Carp;
@RPC::ISA = qw|Msg|;
use FreezeThaw qw|freeze thaw|;

sub connect {
    my ($pkg, $host, $port) = @_;
    my $conn = $pkg->SUPER::connect($host, $port, \&_incoming_msg);
    return $conn;
}

my $g_msg_id = 0;
my $send_err = 0;

sub handle_send_err {
    $send_err = $!;
}

sub rpc {
    my $conn = shift;
    my $subname = shift;

    $subname = (caller() . "::" . $subname) unless $subname =~ /:/;
    my $gimme = wantarray ? 'a' : 's';
    my $msg_id = ++$g_msg_id;
    my $serialized_msg = freeze ('>', $msg_id, $gimme, @_);

    $conn->send_later($serialized_msg);
    do {
	Msg->event_loop(1);
    } until (exists $conn->{rcvd}->{$msg_id} || $send_err);
    if ($send_err) {
	die "RPC Error: $send_err";
    }

    my $rl_retargs = delete $conn->{rcvd}->{$msg_id};
    if(ref($rl_retargs->[0]) eq 'RPC::Error') {
	die ${$rl_retargs->[0]};
    }
    wantarray ? @$rl_retargs : $rl_retargs->[0];
}

sub new_server {
    my ($pkg, $my_host, $my_port) = @_;
    $pkg->SUPER::new_server($my_host, $my_port, sub {$pkg->_login(@_)});
}
sub _login {
    \&_incoming_msg;
}

sub _incoming_msg {
    my ($conn, $msg, $err) = @_;
    return if ($err);
    return unless defined($msg);
    my ($dir, $id, @args) = thaw($msg);
    my ($result, @results);
    if ($dir eq '>') {
	my $gimme = shift @args;
	my $sub_name = shift @args;
	eval {
	    no strict 'refs';

	    if ($gimme eq 'a') {
		@results = &{$sub_name} (@args);
	    }
	    else {
		$result = &{$sub_name} (@args);
	    }
	};
	if ($@) {
	    $msg = bless \$@, "RPC::Error";
	    $msg = freeze('<', $id, $msg);
	}
	elsif ($gimme eq 'a') {
	    $msg = freeze('<', $id, @results);
	}
	else {
	    $msg = freeze('<', $id, $result);
	}
	$conn->send_later($msg);
    }
    else {
	$conn->{rcvd}->{$id} = \@args;
    }
}
1;

