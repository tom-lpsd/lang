package PCShop::Computer;
@ISA = qw|PCShop::StoreItem|;

sub new {
    my $pkg = shift;
    my $self = $pkg->SUPER::new("Computer", 0, 0);
    $self->{_components} = [];
    $self->components(@_);
    $self;
}

sub components {
    my $self = shift;
    @_ ? push (@{$self->{_components}}, @_) : @{$self->{_components}};
}

sub price {
    my $self = shift;
    my $price = 0;
    for my $component ($self->components()) {
	$price += $component->price();
    }
    $price;
}

1;
