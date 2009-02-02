package PCShop::Monitor;
@ISA = qw|PCShop::Component|;

sub new {
    my $pkg = shift;
    $pkg->SUPER::new("Monitor", 400, 15);
}

1;
