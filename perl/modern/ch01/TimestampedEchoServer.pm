package TimestampedEchoServer;
use Moose;

extends 'EchoServer';

before write_response => sub {
    my ($self, $client, $request) = @_;
    print $client scalar(localtime), " ";
};

__PACKAGE__->meta->make_immutable;

no Moose;

1;
