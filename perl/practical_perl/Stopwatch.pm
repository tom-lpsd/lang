package Stopwatch;

sub TIESCALAR {
    my ($pkg) = @_;
    my $obj = time();
    bless \$obj, $pkg;
}

sub FETCH {
    my $self = shift;
    time() - $$self;
}

sub STORE {
    my ($self, $val) = @_;
    $$self = time();
}

1;
