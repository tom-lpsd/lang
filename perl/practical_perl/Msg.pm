package Msg;
use strict;
use IO::Select;
use IO::Socket;
use Carp;
use vars qw|%rd_callbacks %wt_callbacks $rd_handles $wt_handles|;
%rd_callbacks = ();
%wt_callbacks = ();
$rd_handles = IO::Select->new();
$wt_handles = IO::Select->new();
my $blocking_supported = 0;

sub connect {
    my ($pkg, $to_host, $to_port, $rcvd_notification_proc) = @_;
    my $sock = IO::Socket::INET->new(
	    PeerAddr => $to_host,
	    PeerPort => $to_port,
	    Proto => 'tcp');
    return undef unless $sock;

    my $conn = bless {
	sock => $sock,
	rcvd_notification_proc => $rcvd_notification_proc,
    }, $pkg;

    if ($rcvd_notification_proc) {
	my $callback = sub {_rcv($conn)};
	set_event_handler ($sock, read => $callback);
    }
    $conn;
}

sub disconnect {
    my $conn = shift;
    my $sock = delete $conn->{sock};
    return unless defined($sock);
    set_event_handler($sock, read => undef, write => undef);
    close($sock); undef $!;
}

sub send_now {
    my ($conn, $msg) = @_;
    _enqueue ($conn, $msg);
    $conn->_send(1);
}

sub send_later {
    my ($conn,$msg) = @_;
    _enqueue($conn, $msg);
    my $sock = $conn->{sock};
    return unless defined($sock);
    set_event_handler($sock, write => sub {$conn->_send(0)});
}

sub _enqueue {
    my ($conn, $msg) = @_;
    my $len = length($msg);
    $msg = pack('N', $len) . $msg;
    push (@{$conn->{queue}}, $msg);
}

sub _send {
    my ($conn, $flush) = @_;
    my $sock = $conn->{sock};
    return unless defined($sock);
    my ($rq) = $conn->{queue};

    $flush ? $conn->set_blocking() : $conn->set_non_blocking();
    my $offset = (exists $conn->{send_offset}) ? $conn->{send_offset} : 0;

    while(@$rq) {
	my $msg = $rq->[0];
	my $bytes_to_write = length($msg) - $offset;
	my $bytes_written = 0;
	while ($bytes_to_write) {
	    $bytes_written = syswrite($sock, $msg, $bytes_to_write, $offset);
	    if (!defined($bytes_written)) {
		if (_err_will_block($!)) {
		    $conn->{send_offset} = $offset;
		    return 1;
		}
		else {
		    $conn->handle_send_err($!);
		    return 0;
		}
	    }
	    $offset += $bytes_written;
	    $bytes_to_write -= $bytes_written;
	}
	delete $conn->{send_offset};
	$offset = 0;
	shift @$rq;
	last unless $flush;
    }

    if (@$rq) {
	set_event_handler($sock, write => sub {$conn->_send(0)});
    }
    else {
	set_event_handler($sock, write => undef);
    }
    1;
}

sub handle_send_err {
    my ($conn, $err_msg) = @_;
    warn "Error while sending: $err_msg \n";
    set_event_handler($conn->{sock}, write=>undef);
}

my ($g_login_proc, $g_pkg);
my $main_socket = 0;

sub new_server {
    @_ == 4 || die "new_server (myhost, myport, login_proc)\n";
    my ($pkg, $my_host, $my_port, $login_proc) = @_;
    $main_socket = IO::Socket::INET->new(
	    LocalAddr => $my_host,
	    LocalPort => $my_port,
	    Listen => 5,
	    Proto => 'tcp',
	    Reuse => 1);
    die "Could not create socket: $! \n" unless $main_socket;
    set_event_handler($main_socket, read=> \&_new_client);
    $g_login_proc = $login_proc;
    $g_pkg = $pkg;
}

sub _new_client {
    my $sock = $main_socket->accept();
    my $conn = bless {
	sock => $sock,
	state => 'connected',
    }, $g_pkg;
    my $rcvd_notification_proc = &$g_login_proc($conn);
    if ($rcvd_notification_proc) {
	$conn->{rcvd_notification_proc} = $rcvd_notification_proc;
	my $callback = sub {_rcv($conn) };
	set_event_handler($sock, read=>$callback);
    }
    else {
	$conn->disconnect();
    }
}

sub _rcv {
    my ($conn, $rcv_now) = @_;
    my ($msg, $offset, $bytes_to_read, $bytes_read);
    my $sock = $conn->{sock};
    return unless defined($sock);
    if (exists $conn->{msg}) {
	$msg = $conn->{msg};
	delete $conn->{msg};
	$offset = length($msg);
	$bytes_to_read = $conn->{bytes_to_read};
    }
    else {
	$msg = "";
	$offset = 0;
	$bytes_to_read = 0;
    }

    if (!$bytes_to_read) {
	my $buf;
	$conn->set_blocking();
	$bytes_read = sysread($sock, $buf, 4);
	if ($! || ($bytes_read != 4)) {
	    goto FINISH;
	}
	$bytes_to_read = unpack('N',$buf);
    }
    $conn->set_non_blocking() unless $rcv_now;
    while ($bytes_to_read) {
	$bytes_read = sysread($sock, $msg, $bytes_to_read, $offset);
	if (defined ($bytes_read)) {
	    if ($bytes_read == 0) {
		last;
	    }
	    $bytes_to_read -= $bytes_read;
	    $offset += $bytes_read;
	}
	else {
	    if (_err_will_block($!)) {
		$conn->{msg} = $msg;
		$conn->{bytes_to_read} = $bytes_to_read;
		return ;
	    }
	    else {
		last;
	    }
	}
    }

FINISH:
    if (length($msg) == 0) {
	$conn->disconnect();
    }
    if ($rcv_now) {
	return ($msg, $!);
    }
    else {
	&{$conn->{rcvd_notification_proc}}($conn, $msg, $!);
    }
}

sub rcv_now {
    my ($conn) = @_;
    my ($msg, $err) = _rcv($conn, 1);
    return wantarray ? ($msg, $err) : $msg;
}

BEGIN {
    eval {
	require POSIX; POSIX->import(qw(F_SETFL O_NONBLOCK EAGAIN));
    };
    $blocking_supported = 1 unless $@;
}

sub _err_will_block {
    if ($blocking_supported) {
	return ($_[0] == EAGAIN());
    }
    return 0;
}

sub set_non_blocking {
    if ($blocking_supported) {
	my $flags = fcntl ($_[0], F_GETFL(), 0);
	my $conn = shift;
	fcntl ($conn->{sock}, F_SETFL(), $flags | O_NONBLOCK());
    }
}

sub set_blocking {
    if ($blocking_supported) {
	my $flags = fcntl ($_[0], F_GETFL(), 0);
	$flags &= ~O_NONBLOCK();

	my $conn = shift;
	fcntl ($conn->{sock}, F_SETFL(), $flags);
    }
}

sub set_event_handler {
    shift unless ref($_[0]);
    my ($handle, %args) = @_;
    my $callback;
    if (exists $args{write}) {
	$callback = $args{write};
	if($callback) {
	    $wt_callbacks{$handle} = $callback;
	    $wt_handles->remove($handle);
	}
	else {
	    delete $wt_callbacks{$handle};
	    $wt_handles->remove($handle);
	}
    }
    if (exists $args{read}) {
	$callback = $args{read};
	if ($callback) {
	    $rd_callbacks{$handle} = $callback;
	    $rd_handles->add($handle);
	}
	else {
	    delete $rd_callbacks{$handle};
	    $rd_handles->remove($handle);
	}
    }
}

sub event_loop {
    my ($pkg, $loop_count) = @_;
    my ($conn, $r, $w, $rset, $wset);
    while(1) {
	last unless ($rd_handles->count() || $wt_handles->count());
	($rset, $wset) =
	    IO::Select->select ($rd_handles, $wt_handles, undef, undef);

	for $r (@$rset) {
	    &{$rd_callbacks{$r}}($r) if exists $rd_callbacks{$r};
	}
	for $w (@$wset) {
	    &{$wt_callbacks{$w}}($w) if exists $wt_callbacks{$w};
	}
	if (defined($loop_count)) {
	    last unless --$loop_count;
	}
    }
}
1;

