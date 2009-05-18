package LazyBuild;
use Moose;

has address => (
    is => 'rw',
    isa => 'Str',
    required => 1,
);

has port => (
    is => 'rw',
    isa => 'Int',
    default => 9999,
);

has server_socket => (
    is  => 'rw',
    isa => 'IO::Socket::INET',
    lazy_build => 1,
);

__PACKAGE__->meta->make_immutable;

no Moose;

use IO::Socket::INET;

sub _build_server_socket {
    my $self = shift;
    IO::Socket::INET->new(
        Listen => 5,
        LocalAddr => $self->address,
        LocalPort => $self->port,
        Proto => 'tcp',
    );
}
