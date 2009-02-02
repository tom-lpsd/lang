package PCShop::CDROM;
@ISA = qw|PCShop::Component|;

sub new {
    my $pkg = shift;
    $pkg->SUPER::new("CDROM", 200, 5);
}

1;
