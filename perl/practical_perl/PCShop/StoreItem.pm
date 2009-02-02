package PCShop::StoreItem;

my $_sales_tax = 8.5;

sub new {
    my ($pkg, $name, $price, $rebate) = @_;
    bless {
	_name => $name, _price => $price, _rebate => $rebate,
    }, $pkg;
}

sub sales_tax {
    shift;
    @_ ? $_sales_tax = shift : $_sales_tax; 
}

sub name {
    my $self = shift;
    @_ ? $self->{_name} = shift : $self->{_name};
}
sub price {
    my $self = shift;
    @_ ? $self->{_price} = shift : $self->{_price};
}
sub rebate {
    my $self = shift;
    @_ ? $self->{_rebate} = shift : $self->{_rebate};
}
sub net_price {
    my $self = shift;
    return $self->price * (1+$self->sales_tax / 100);
}

1;
