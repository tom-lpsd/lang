package ClassChain;

sub new {
    print "ClassChain::new called.\n";
    bless {attr => $_[1]}, $_[0];
}

sub shout {
    print "Class Chain !!\n";
}

sub DESTROY {
    print "ClassChain is die.\n"
}

package ClassChain2;
@ISA = qw|ClassChain|;

sub new {
    my $self = shift->SUPER::new(@_);
    print "ClassChain2::new called.\n";
    return $self;
}

sub DESTROY {
    print "ClassChain2 is die.\n";
    shift->SUPER::DESTROY;
}

package ClassChain3;
@ISA = qw|ClassChain2|;

sub new {
    my $self = shift->SUPER::new(@_);
    print "ClassChain3::new called.\n";
    return $self;
}

sub DESTROY {
    print "ClassChain3 is die.\n";
    shift->SUPER::DESTROY;
}

1;
