package EchoServer;
use Moose;

has address => (
    is => 'rw',
    isa => 'Str',
    required => 1,
);

has port => (
    is => 'rw',
    isa => 'Int',
    required => 1,
    default => 9999,
);

has server_socket => (
    is => 'rw',
    isa => 'IO::Socket',
);

__PACKAGE__->meta->make_immutable;

no Moose;

use IO::Socket::INET;

sub bind {
    my $self = shift;

    my $socket = IO::Socket::INET->new(
        Listen    => 5,
        LocalAddr => $self->address,
        LocalPort => $self->port,
        Proto     => 'tcp',
    );
    unless ($socket) {
        die "ソケットを作成できませんでした: $@";
    }

    $self->server_socket($socket);
}

sub run {
    my $self = shift;

    my $socket = $self->server_socket;
    while (my $client = $socket->accept) {
        $self->process_request($client);
    }
}

sub process_request {
    my ($self, $client) = @_;

    until ($client->eof) {
        my $req = $self->read_request($client);
        $self->write_response($client, $req);
    }
}

sub read_request {
    my ($self, $client) = @_;
    my $line = <$client>;
    return $line;
}

sub write_response {
    my ($self, $client, $request) = @_;
    print $client $request;
}

1;
